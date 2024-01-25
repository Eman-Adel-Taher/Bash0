#!/bin/bash

# Function to perform domain enumeration
enumerate_domains() {
    local input_file="$1"
    local iterations="$2"
    local output_file="$3"

    # Initial enumeration
    echo "Performing initial domain enumeration..."
    cat "$input_file" | sort -u > "$output_file"

    # Iterate for the specified number of times
    for ((i=1; i<=iterations; i++)); do
        echo "Iteration $i: Performing subdomain enumeration..."
        temp_file="${output_file}_temp"
        
        # Use sublist3r for subdomain enumeration
        sublist3r -dL "$output_file" -o "$temp_file"

        # Use amass for additional subdomain enumeration
        amass enum -d "$(cat "$output_file" | tr '\n' ',')" -o "$temp_file" -silent

        # Use dnsrecon for more subdomain enumeration
        dnsrecon -d "$(cat "$output_file" | tr '\n' ' ')" -t axfr -j -z -v -o "$temp_file"

        # Combine and sort results
        cat "$output_file" "$temp_file" | sort -u > "$output_file"

        # Clean up temporary file
        rm "$temp_file"
    done
}

# Check if required tools are installed
check_dependencies() {
    local dependencies=("sublist3r" "amass" "dnsrecon")

    for tool in "${dependencies[@]}"; do
        if ! command -v "$tool" > /dev/null; then
            echo "Error: $tool not found. Please install it."
            exit 1
        fi
    done
}

# Main script
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 input_file iterations output_file"
    exit 1
fi

input_file="$1"
iterations="$2"
output_file="$3"

# Check if required tools are installed
check_dependencies

# Perform domain enumeration
enumerate_domains "$input_file" "$iterations" "$output_file"

echo "Domain enumeration completed. Results saved to $output_file."
