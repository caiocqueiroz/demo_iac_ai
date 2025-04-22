#!/bin/bash
set -e

# Usage function
usage() {
  echo "Usage: $0 -w WORKING_DIR [-o OUTPUT_FILE] [-g GITHUB_TOKEN] [-p PR_NUMBER] [-r REPO] [-a API_KEY]"
  echo
  echo "Options:"
  echo "  -w WORKING_DIR    Working directory containing Terraform files"
  echo "  -o OUTPUT_FILE    File to save the analysis output (default: terraform_analysis.md)"
  echo "  -g GITHUB_TOKEN   GitHub token for PR comment (optional)"
  echo "  -p PR_NUMBER      Pull request number (required if posting to PR)"
  echo "  -r REPO           GitHub repository in format owner/repo (required if posting to PR)"
  echo "  -a API_KEY        OpenAI API key (can also use OPENAI_API_KEY env var)"
  exit 1
}

# Parse arguments
OUTPUT_FILE="terraform_analysis.md"
while getopts "w:o:g:p:r:a:" opt; do
  case $opt in
    w) WORKING_DIR="$OPTARG" ;;
    o) OUTPUT_FILE="$OPTARG" ;;
    g) GITHUB_TOKEN="$OPTARG" ;;
    p) PR_NUMBER="$OPTARG" ;;
    r) REPO="$OPTARG" ;;
    a) OPENAI_API_KEY="$OPTARG" ;;
    *) usage ;;
  esac
done

# Validate required parameters
if [ -z "$WORKING_DIR" ]; then
  echo "Error: Working directory is required"
  usage
fi

# Make sure the working directory exists
if [ ! -d "$WORKING_DIR" ]; then
  echo "Error: Working directory $WORKING_DIR does not exist"
  exit 1
fi

# Change to the working directory
cd "$WORKING_DIR"
echo "Working in directory: $(pwd)"

# Check if terraform command exists
if ! command -v terraform &> /dev/null; then
  echo "Error: terraform command not found"
  exit 1
fi

# Create temp directory for plan files
TEMP_DIR=$(mktemp -d)
PLAN_OUT="$TEMP_DIR/tfplan"
PLAN_JSON="$TEMP_DIR/tfplan.json"

echo "Generating Terraform plan..."
# Initialize and create plan
terraform init -no-color
terraform plan -no-color -out="$PLAN_OUT"

echo "Converting plan to JSON format..."
# Convert the plan to JSON
terraform show -json "$PLAN_OUT" > "$PLAN_JSON"

# Determine the path to the Python script
SCRIPT_DIR="$(dirname "$0")"
PYTHON_SCRIPT="$SCRIPT_DIR/analyze_terraform_plan.py"

echo "Analyzing plan with OpenAI..."
# If API key was provided via argument, export it for the Python script
if [ -n "$OPENAI_API_KEY" ]; then
  export OPENAI_API_KEY
fi

# Run the Python script to analyze the plan
python3 "$PYTHON_SCRIPT" --plan_file "$PLAN_JSON" --output_file "$OUTPUT_FILE"

echo "Analysis saved to: $OUTPUT_FILE"

# Post to GitHub PR if requested
if [ -n "$GITHUB_TOKEN" ] && [ -n "$PR_NUMBER" ] && [ -n "$REPO" ]; then
  echo "Posting analysis to GitHub PR #$PR_NUMBER..."
  
  # Read the analysis file
  ANALYSIS_CONTENT=$(cat "$OUTPUT_FILE")
  
  # Create the JSON payload for the GitHub API
  COMMENT_PAYLOAD=$(cat <<EOF
{
  "body": "## Terraform Plan Analysis by OpenAI\n\n$ANALYSIS_CONTENT"
}
EOF
)

  # Post to GitHub using the API
  curl -s -X POST \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "$COMMENT_PAYLOAD" \
    "https://api.github.com/repos/$REPO/issues/$PR_NUMBER/comments"
  
  echo "Analysis posted to PR #$PR_NUMBER"
fi

# Cleanup
rm -rf "$TEMP_DIR"
echo "Done!"