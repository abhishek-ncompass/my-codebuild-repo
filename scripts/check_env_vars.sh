# # Function to check for missing environment variables
# check_env_vars() {
#   # List of required variables
#   REQUIRED_VARS=("VAR1" "VAR2" "VAR4")

#   # Initialize a variable to keep track of missing environment variables
#   MISSING_VARS=()

#   # Check if each required variable is set
#   for VAR in "${REQUIRED_VARS[@]}"; do
#     if [ -z "${!VAR}" ]; then
#       echo "Error: Environment variable '$VAR' is missing."
#       MISSING_VARS+=("$VAR")
#     else
#       echo "Environment variable '$VAR' is set to: ${!VAR}"
#     fi
#   done

#   # If there are any missing variables, log them and exit with an error
#   if [ ${#MISSING_VARS[@]} -gt 0 ]; then
#     echo "The following required environment variables are missing: ${MISSING_VARS[@]}"
#     echo "Build failed due to missing environment variables."
#     exit 1  # Exit with a non-zero status to fail the build
#   fi
# }

# # Call the function
# check_env_vars


#!/bin/bash

# Function to extract required variables from script files
extract_required_vars() {
  local script_file="$1"
  # Use grep to find lines with variable usage and extract variable names
  # This will match both ${VAR} and $VAR formats
  grep -oP '\$\{?\w+\}?' "$script_file" | sort -u
}

# Function to check for missing environment variables
check_env_vars() {
  # List of script files to check for environment variables
  SCRIPT_FILES=("scripts/deploy.sh" "scripts/monitoring-deploy.sh" "scripts/deployAdminTool.sh" "scripts/deployMisc.sh" "scripts/deployOnboarding.sh")

  # Initialize an array to hold all required variables
  REQUIRED_VARS=()

  # Extract required variables from each script file
  for script in "${SCRIPT_FILES[@]}"; do
    if [ -f "$script" ]; then
      while IFS= read -r var; do
        REQUIRED_VARS+=("$var")
      done < <(extract_required_vars "$script")
    else
      echo "Warning: Script file '$script' not found."
    fi
  done

  # Initialize an array to track missing environment variables
  MISSING_VARS=()

  # Get the list of available environment variables
  AVAILABLE_VARS=$(printenv | awk -F= '{print $1}')

  # Check for each required variable
  for VAR in "${REQUIRED_VARS[@]}"; do
    # Skip excluded variables (you can add a list of excluded vars if needed)
    if [[ " ${EXCLUDED_VARS[@]} " =~ " ${VAR} " ]]; then
      echo "Skipping check for excluded variable '$VAR'."
      continue
    fi

    # Check if the environment variable is set or missing
    if [ -z "${!VAR}" ]; then
      echo "Error: Environment variable '$VAR' is missing."
      MISSING_VARS+=("$VAR")
    else
      echo "Environment variable '$VAR' is set to: ${!VAR}"
    fi
  done

  # If there are any missing variables, log them and exit with an error
  if [ ${#MISSING_VARS[@]} -gt 0 ]; then
    echo "The following required environment variables are missing: ${MISSING_VARS[@]}"
    echo "Build failed due to missing environment variables."
    exit 1  # Exit with a non-zero status to fail the build
  fi
}

# Call the function
check_env_vars
