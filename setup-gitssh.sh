#!/bin/bash

validate_email() {
    local email="$1"
    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <email>"
    echo "You must pass exactly one parameter as the email for the SSH key comment."
    exit 1
fi

if ! validate_email "$1"; then
    echo "Invalid email format. Please provide a valid email address."
    exit 1
fi

ssh-keygen -t ed25519 -C "$1"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
