# Terraform Plan Analysis Tools

This directory contains tools for analyzing Terraform plans using OpenAI's API to provide insights, recommendations, and security checks.

## Overview

The tools in this directory allow you to:

1. Generate a Terraform plan in JSON format
2. Send the plan to OpenAI API for analysis
3. Generate a report with findings and recommendations
4. Optionally post the analysis as a comment to a GitHub Pull Request

## Tools

### `analyze_terraform_plan.py`

A Python script that takes a Terraform plan JSON file and sends it to OpenAI API for analysis.

#### Usage

```bash
python analyze_terraform_plan.py --plan_file <path_to_plan.json> --output_file <output.md> --api_key <openai_api_key>
```

#### Parameters

- `--plan_file`: Path to the Terraform plan JSON file (required)
- `--output_file`: Path to save the analysis output (optional)
- `--api_key`: OpenAI API key (optional, can also be set via OPENAI_API_KEY environment variable)

### `tf_plan_analysis.sh`

A shell script that automates the entire process, from generating a Terraform plan to posting the analysis to a GitHub PR.

#### Usage

```bash
./tf_plan_analysis.sh -w <working_dir> [-o <output_file>] [-g <github_token>] [-p <pr_number>] [-r <repo>] [-a <api_key>]
```

#### Parameters

- `-w WORKING_DIR`: Working directory containing Terraform files (required)
- `-o OUTPUT_FILE`: File to save the analysis output (default: terraform_analysis.md)
- `-g GITHUB_TOKEN`: GitHub token for PR comment (optional)
- `-p PR_NUMBER`: Pull request number (required if posting to PR)
- `-r REPO`: GitHub repository in format owner/repo (required if posting to PR)
- `-a API_KEY`: OpenAI API key (can also use OPENAI_API_KEY env var)

## Integration with GitHub Actions

These tools are integrated into the GitHub Actions workflow for this project. When a PR is created or updated, the workflow will:

1. Generate a Terraform plan
2. Send the plan to OpenAI for analysis
3. Post the analysis as a comment on the PR

To enable this integration, you need to add the `OPENAI_API_KEY` secret to your GitHub repository.

## Example Analysis Output

The analysis will include:

- Summary of planned changes (resources being added, changed, or destroyed)
- Potential security issues or vulnerabilities
- Performance optimization recommendations
- Cost optimization suggestions
- Best practice recommendations
- Compliance concerns (if any)

## Running Locally

To run the analysis locally:

```bash
# Navigate to your Terraform directory
cd /path/to/terraform/files

# Run the analysis script
/path/to/tf_plan_analysis.sh -w . -o analysis.md -a YOUR_OPENAI_API_KEY
```

## Requirements

- Python 3.6+
- `requests` Python package
- Terraform CLI
- OpenAI API key