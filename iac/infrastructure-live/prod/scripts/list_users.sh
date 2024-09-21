#!/bin/bash

# folder containing IAM users
folder=$1

# Output all subdirectories (assuming each folder is a user)
find "$folder" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;
