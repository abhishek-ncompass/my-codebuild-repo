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

# ---------------------------------------------------------------------------------


# # Function to check for missing environment variables
# check_env_vars() {


#   extract_required_vars() {
#           local script_file="$1"
#           grep -oP '\$\{?\w+\}?' "$script_file" | sort -u
#         }

#   # List of script files to check
#   SCRIPT_FILES=("scripts/deploy.sh")


#   # List of required variables
#   # REQUIRED_VARS=("VAR1" "VAR2" "VAR4")
#   REQUIRED_VARS=()

#   for script in "${SCRIPT_FILES[@]}"; do
#           if [ -f "$script" ]; then
#             while IFS= read -r var; do
#               REQUIRED_VARS+=("$var")
#             done < <(extract_required_vars "$script")
#           else
#             echo "Warning: Script file '$script' not found."
#           fi
#         done

#   EXCLUDED_VARS=("LAYER_ARN" "SCHEMA_SYNC_LAYER_ARN" "LAYER_COMMON_ARN" "LAYER_CHROME_ARN" "LAYER_CUSTOM_ARN" "LAYER_SCHEMA_ARN" "LAYER_SHARP_ARN" "CODEBUILD_SOURCE_VERSION" "CODEBUILD_RESOLVED_SOURCE_VERSION")
#   MISSING_VARS=()
#   AVAILABLE_VARS=$(printenv | awk -F= '{print $1}')

#   echo $AVAILABLE_VARS

#   # Check if each required variable is set
#   for VAR in "${REQUIRED_VARS[@]}"; do
#     if [ -z "${!VAR}" ]; then
#       echo "Error: Environment variable '$VAR' is missing."
#       MISSING_VARS+=("$VAR")
#     else
#       echo "Environment variable '$VAR' is set to: ${!VAR}"
#     fi
#   done

# # Check for each required variable
#     for VAR in "${REQUIRED_VARS[@]}"; do
#         # Skip excluded variables
#         if [[ " ${EXCLUDED_VARS[@]} " =~ " ${VAR} " ]]; then
#             echo "Skipping check for excluded variable '$VAR'."
#             continue
#         fi

#         # Check if the environment variable is set or missing
#         if ! echo "$AVAILABLE_VARS" | grep -q "^$VAR$"; then
#             echo "Error: Environment variable '$VAR' is missing."
#             MISSING_VARS+=("$VAR")
#         else
#             echo "Environment variable '$VAR' is set."
#         fi
#     done

#     # If there are any missing variables, log them and exit with an error
#     if [ ${#MISSING_VARS[@]} -gt 0 ]; then
#         echo "The following required environment variables are missing: ${MISSING_VARS[@]}"
#         echo "Build failed due to missing environment variables."
#         exit 1  # Exit with a non-zero status to fail the build
#     fi
# }