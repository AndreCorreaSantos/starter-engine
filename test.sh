#!/usr/bin/env bash

echo "Environments with torchvision, ipykernel, and Python >= 3.10:"

# Skip the first two lines (header) of `mamba env list` and extract environment names
for env in $(mamba env list | tail -n +3 | awk '{print $1}'); do
    
    # Capture `mamba list` output for this environment once (to avoid multiple calls)
    env_list=$(mamba list -n "$env")
    
    # 1) Check if torchvision is installed
    if ! echo "$env_list" | grep -q '^torchvision\s'; then
        continue
    fi
    
    # 2) Check if ipykernel is installed
    if ! echo "$env_list" | grep -q '^ipykernel\s'; then
        continue
    fi
    
    # 3) Check Python version >= 3.10
    #    Grab the line for python and extract just the version (e.g. "3.10.9")
    python_version=$(echo "$env_list" | grep '^python\s' | awk '{print $2}')
    if [ -z "$python_version" ]; then
        # No python found (unlikely, but just in case)
        continue
    fi
    
    # Parse major.minor from the version
    IFS=. read -r major minor patch <<< "$python_version"
    
    # Compare major/minor to see if it's >= 3.10
    # (if major > 3, that also satisfies the condition)
    if [[ "$major" -lt 3 ]] || [[ "$major" -eq 3 && "$minor" -lt 10 ]]; then
        continue
    fi
    
    # If we reach here, it satisfies all conditions:
    echo "$env"
done
