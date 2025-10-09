#!/bin/bash

# Quick workflow syntax validation without Docker
# This checks basic syntax and structure

echo "🔍 Checking GitHub Actions workflow syntax..."
echo ""

# Check if yq or jq is available for YAML parsing
if command -v yamllint &> /dev/null; then
    echo "✅ Using yamllint for validation"
    yamllint .github/workflows/release.yml
elif python3 -c "import yaml" 2>/dev/null; then
    echo "✅ Using Python YAML parser for validation"
    python3 << 'EOF'
import yaml
import sys

try:
    with open('.github/workflows/release.yml', 'r') as f:
        workflow = yaml.safe_load(f)

    print("✅ YAML syntax is valid")
    print("")
    print("Workflow details:")
    print(f"  Name: {workflow.get('name', 'N/A')}")
    print(f"  Triggers: {', '.join(workflow.get('on', {}).keys())}")
    print(f"  Jobs: {len(workflow.get('jobs', {}))}")
    print("")

    for job_name, job_config in workflow.get('jobs', {}).items():
        steps = len(job_config.get('steps', []))
        runs_on = job_config.get('runs-on', 'N/A')
        print(f"  • {job_name}: {steps} steps on {runs_on}")

    sys.exit(0)
except yaml.YAMLError as e:
    print(f"❌ YAML syntax error: {e}")
    sys.exit(1)
except Exception as e:
    print(f"❌ Error: {e}")
    sys.exit(1)
EOF
else
    echo "⚠️  No YAML validator found. Installing yamllint is recommended:"
    echo "     pip install yamllint"
    echo ""
    echo "Attempting basic check..."

    # Basic syntax check
    if grep -q "^name:" .github/workflows/release.yml && \
       grep -q "^on:" .github/workflows/release.yml && \
       grep -q "^jobs:" .github/workflows/release.yml; then
        echo "✅ Basic structure looks OK"
    else
        echo "❌ Workflow file might be malformed"
        exit 1
    fi
fi

echo ""
echo "💡 For full validation with Docker, use: ./test-workflow.sh validate"
