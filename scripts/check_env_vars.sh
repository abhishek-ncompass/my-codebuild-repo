# Function to check for missing environment variables
check_env_vars() {
  # List of required variables
  REQUIRED_VARS=("VAR1" "VAR2" "VAR4")

  # Initialize a variable to keep track of missing environment variables
  MISSING_VARS=()

  # Check if each required variable is set
  for VAR in "${REQUIRED_VARS[@]}"; do
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
