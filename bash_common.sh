DEBUG=true

# ================================= #
# Fonctions d'affichage de messages
# ================================= #
print_error() {
    echo -e "\033[0;31m[!!!] $1\033[0m"
}

print_success() {
    echo -e "\033[0;32m[OK] $1\033[0m"
}

print_info() {
    echo -e "\033[0;34m[INFO] $1\033[0m"
}

print_additional_info() {
    echo -e "\033[0;33m[***] $1\033[0m"
}

# Function: run_silent
#
# Description:
#   Executes a specified Bash command as an argument to the function.
#   Captures the standard output (stdout) and standard error (stderr) of the command.
#   Displays debugging information if the DEBUG variable is set to true but runs silently otherwise.
#   This function is useful for running commands that do not produce output but may fail.
#
# Usage:
#   run_silent [command]
#
# Parameters:
#   - command: The Bash command to be executed.
#
# Environment Variables:
#   - DEBUG: If set to true, displays debugging information.
#
# Returns:
#   - Success (0): If the command executed successfully.
#   - Failure (1): If the command failed. Displays the error output of the command.
#
# Examples:
#   Example 1: 
#       Run a command that may produce an error
#       run_silent "ls -l /nonexistent"
#
# Notes:
#   - Uses eval to execute the provided command as an argument.
#   - Captures the output (stdout and stderr) of the command for display in case of failure.
#   - When DEBUG is set to true, displays debugging messages.
#   - Operates silently (without display) when used without DEBUG, showing error output only on failure.
#
run_silent() {
    local output

    if [ "$DEBUG" = true ]; then
        echo "[*] Executing command : $@"
    fi
    # Execute the command, capture the output and return the exit code
    output=$(eval "$@" 2>&1)

    if [ $? -eq 0 ]; then
        if [ "$DEBUG" = true ]; then
            echo "[*] Command successfully executed : $@"
        fi
        return 0
    else
        echo "[!!!] Command '$@' failed with following output :"
        # Display the output of the command
        print_error "$output"
        return 1
    fi
}