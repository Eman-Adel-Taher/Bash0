#!/bin/bash


length=10
upper=true
lower=true
numbers=true
special_chars=false

# Function to generate random password
generate_password() {
    local password=""
    local complexity=0

    # Select character pool based on complexity requirements
    local char_pool=""
    if [ "$upper" == true ]; then
        char_pool+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        complexity=$((complexity + 1))
    fi
    if [ "$lower" == true ]; then
        char_pool+="abcdefghijklmnopqrstuvwxyz"
        complexity=$((complexity + 1))
    fi
    if [ "$numbers" == true ]; then
        char_pool+="0123456789"
        complexity=$((complexity + 1))
    fi
    if [ "$special_chars" == true ]; then
        char_pool+="!@#$%^&*()_-+=~"
        complexity=$((complexity + 1))
    fi

    # Generate random password
    local pool_length=${#char_pool}
    while [ ${#password} -lt "$length" ]; do
        local random_index=$((RANDOM % pool_length))
        password+=${char_pool:$random_index:1}
    done

    echo "Generated password: $password"
    echo "Complexity: $complexity"
}

# Process command-line arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
    -l | --length)
        length="$2"
        shift
        shift
        ;;
    -u | --upper)
        upper=true
        shift
        ;;
    -lc | --lower)
        lower=true
        shift
        ;;
    -n | --numbers)
        numbers=true
        shift
        ;;
    -sc | --special-chars)
        special_chars=true
        shift
        ;;
    *)
        echo "Invalid option: $key"
        exit 1
        ;;
    esac
done

# Generate password
generate_password
