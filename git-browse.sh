#!/usr/bin/env bash

# Define the function to open the repository URL in the browser
f() {
    remote_url=$(git remote get-url origin)
    if [[ $remote_url == git@* ]]; then
        remote_url=${remote_url/:/\/}
        remote_url=${remote_url/git@/https://}
        remote_url=${remote_url%.git}
    fi
    open "$remote_url"
}

# Call the function
f