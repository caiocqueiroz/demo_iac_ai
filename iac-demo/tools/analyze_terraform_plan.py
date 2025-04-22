#!/usr/bin/env python3
import os
import sys
import json
import requests
import argparse
from pathlib import Path

def parse_arguments():
    parser = argparse.ArgumentParser(description='Analyze Terraform plan with OpenAI')
    parser.add_argument('--plan_file', type=str, required=True, help='Path to the Terraform plan JSON file')
    parser.add_argument('--output_file', type=str, help='Path to save the analysis output')
    parser.add_argument('--api_key', type=str, help='OpenAI API key (can also be set via OPENAI_API_KEY env var)')
    return parser.parse_args()

def read_terraform_plan(plan_file):
    try:
        with open(plan_file, 'r') as f:
            return f.read()
    except Exception as e:
        print(f"Error reading Terraform plan file: {e}")
        sys.exit(1)

def analyze_plan_with_openai(plan_content, api_key):
    if not api_key:
        api_key = os.environ.get('OPENAI_API_KEY')
        if not api_key:
            print("Error: OpenAI API key not provided. Set it via --api_key or OPENAI_API_KEY environment variable.")
            sys.exit(1)
    
    url = "https://api.openai.com/v1/chat/completions"
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }
    
    # Create a system prompt that instructs the model to analyze the Terraform plan
    system_prompt = """
    You are an expert in Terraform and cloud infrastructure. Analyze the provided Terraform plan output and create a comprehensive report including:
    
    1. Summary of planned changes (resources being added, changed, or destroyed)
    2. Potential security issues or vulnerabilities
    3. Performance optimization recommendations
    4. Cost optimization suggestions
    5. Best practice recommendations
    6. Compliance concerns (if any)
    
    Provide your analysis in markdown format with clear sections.
    """
    
    user_prompt = f"Here is the Terraform plan output to analyze:\n\n```\n{plan_content}\n```\n\nPlease provide your analysis."
    
    data = {
        "model": "gpt-4-turbo",
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_prompt}
        ],
        "temperature": 0.5,
        "max_tokens": 4000
    }
    
    try:
        response = requests.post(url, headers=headers, json=data)
        response.raise_for_status()
        result = response.json()
        return result["choices"][0]["message"]["content"]
    except Exception as e:
        print(f"Error calling OpenAI API: {e}")
        if hasattr(e, 'response') and hasattr(e.response, 'text'):
            print(f"Response: {e.response.text}")
        sys.exit(1)

def save_analysis(analysis, output_file):
    try:
        with open(output_file, 'w') as f:
            f.write(analysis)
        print(f"Analysis saved to {output_file}")
    except Exception as e:
        print(f"Error saving analysis: {e}")
        sys.exit(1)

def main():
    args = parse_arguments()
    
    plan_content = read_terraform_plan(args.plan_file)
    analysis = analyze_plan_with_openai(plan_content, args.api_key)
    
    if args.output_file:
        save_analysis(analysis, args.output_file)
    else:
        print(analysis)

if __name__ == "__main__":
    main()