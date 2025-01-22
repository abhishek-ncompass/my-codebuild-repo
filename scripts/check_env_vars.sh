extract_required_vars() {
    local script_file="$1"
    grep -oP '\$\{?\w+\}?' "$script_file" | sed 's/[${}]//g' | sort -u
}

check_env_vars() {
    SCRIPT_FILES=("scripts/deploy.sh" "scripts/deploy2.sh")

    REQUIRED_VARS=()

    for script in "${SCRIPT_FILES[@]}"; do
        if [ -f "$script" ]; then
            while IFS= read -r var; do
                REQUIRED_VARS+=("$var")
            done < <(extract_required_vars "$script")
        else
            echo "Warning: Script file '$script' not found."
        fi
    done

    if [ ${#REQUIRED_VARS[@]} -eq 0 ]; then
        echo "No required environment variables found in the script files."
        exit 1
    fi

    MISSING_VARS=()

    EXCLUDED_VARS=("LAYER_ARN" "SCHEMA_SYNC_LAYER_ARN" "LAYER_COMMON_ARN" "LAYER_CHROME_ARN" "LAYER_CUSTOM_ARN" "LAYER_SCHEMA_ARN" "LAYER_SHARP_ARN" "CODEBUILD_SOURCE_VERSION" "CODEBUILD_RESOLVED_SOURCE_VERSION")

    AVAILABLE_VARS=$(printenv | awk -F= '{print $1}')

    echo "Required Variables (from scripts):"
    for VAR in "${REQUIRED_VARS[@]}"; do
        echo "$VAR"
    done
    echo "----------------------------"

    for VAR in "${REQUIRED_VARS[@]}"; do
        if [[ " ${EXCLUDED_VARS[@]} " =~ " ${VAR} " ]]; then
            continue
        fi

        if ! echo "$AVAILABLE_VARS" | grep -q "^$VAR$"; then
            # echo "Error: Environment variable '$VAR' is missing."
            MISSING_VARS+=("$VAR")
        # else
        #     echo "Environment variable '$VAR' is set."
        fi
    done

    if [ ${#MISSING_VARS[@]} -gt 0 ]; then
        echo "The following required environment variables are missing: ${MISSING_VARS[@]}"
        echo "Build failed due to missing environment variables."
        exit 1  
    fi
}

check_env_vars
