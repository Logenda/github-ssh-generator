#!/bin/bash

validate_email() {
    local email="$1"
    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

if [ "$#" -eq 0 ]; then
    read -p "Please enter your email address: " email
elif [ "$#" -eq 1 ]; then
    email="$1"
else
    echo "Usage: $0 [email]"
    echo "You can pass one email as a parameter or be prompted for one."
    exit 1
fi

while ! validate_email "$email"; do
    echo "Invalid email format. Please provide a valid email address."
    read -p "Email: " email
done

ssh-keygen -t ed25519 -C "$email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
