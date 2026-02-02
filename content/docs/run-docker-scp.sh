#!/bin/bash
#
# docker-scp.sh - SCP wrapper that uses linuxserver/openssh-server Docker image
#
# Usage:
#   ./docker-scp.sh [SCP_OPTIONS] source destination
#
# Examples:
#   ./docker-scp.sh -r localdir user@remote:/path/to/dir     # Upload
#   ./docker-scp.sh user@remote:/path/to/file localfile      # Download
#   ./docker-scp.sh -P 2222 user@host1:/file user@host2:/dir # Remote-to-remote

set -e

# Docker image to use
DOCKER_IMAGE="linuxserver/openssh-server:version-8.8_p1-r1"

# Function to show usage
show_usage() {
  echo "Usage: $0 [SCP_OPTIONS] source destination"
  echo ""
  echo "A wrapper around scp that uses the $DOCKER_IMAGE Docker image"
  echo "for secure file transfers."
  echo ""
  echo "Examples:"
  echo "  $0 -r localdir user@remote:/path/to/dir    # Upload a directory"
  echo "  $0 user@remote:/path/to/file localfile     # Download a file"
  echo "  $0 -P 2222 file.txt user@host:/path/       # Specify port"
  echo ""
  echo "Options:"
  echo "  Same options as the standard scp command"
  exit 1
}

# Function to print commands before execution (only if -v flag is present)
print_command() {
  # Check if -v is in the arguments
  if [[ "$*" == *" -v "* ]] || [[ "$OPTIONS" == *"-v"* ]]; then
    echo "ðŸ“‹ EXECUTING: $@"
  fi
}

# Check if Docker is installed and running
if ! command -v docker &>/dev/null; then
  echo "Error: Docker is not installed or not in PATH"
  exit 1
fi

# Check if we have at least 2 arguments (source and destination)
if [ $# -lt 2 ]; then
  show_usage
fi

# Check if help is requested
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_usage
fi

# Create a temporary directory for SSH keys and config
TMP_DIR=$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT

# Prepare SSH directory structure
mkdir -p $TMP_DIR/.ssh
chmod 700 $TMP_DIR/.ssh

# Check if ~/.ssh directory exists and copy the entire folder
if [ -d ~/.ssh ]; then
  # Copy all files from ~/.ssh to temporary directory
  cp -r ~/.ssh/* $TMP_DIR/.ssh/

  # Set appropriate permissions for private keys (assuming standard naming patterns)
  find $TMP_DIR/.ssh -name "id_*" ! -name "*.pub" -exec chmod 600 {} \;

  # Set appropriate permissions for public keys and other files
  find $TMP_DIR/.ssh -name "*.pub" -exec chmod 644 {} \;
  find $TMP_DIR/.ssh -name "known_hosts" -exec chmod 644 {} \;
  find $TMP_DIR/.ssh -name "config" -exec chmod 600 {} \;
  find $TMP_DIR/.ssh -name "authorized_keys" -exec chmod 600 {} \;

  # Print the contents of the temporary SSH directory if verbose
  if [[ "$OPTIONS" == *"-v"* ]]; then
    echo "ðŸ“‚ Contents of temporary SSH directory after copying:"
    echo "---------------------------------------------------"
    ls -la $TMP_DIR/.ssh
    echo "---------------------------------------------------"
  fi
fi

# Parse the last two arguments as source and destination
ARGS=("$@")
SOURCE="${ARGS[${#ARGS[@]} - 2]}"
DEST="${ARGS[${#ARGS[@]} - 1]}"
OPTIONS=("${ARGS[@]:0:${#ARGS[@]}-2}")

# Function to check if path is remote (contains :)
is_remote() {
  [[ "$1" == *":"* ]]
}

# Handle different copy scenarios
if is_remote "$SOURCE" && is_remote "$DEST"; then
  # Remote to remote copy is not directly supported
  # We'll need to first download to a temp file, then upload
  echo "Remote-to-remote copy, will use a local temporary file"

  # Create temp file for intermediate storage
  TEMP_FILE="$TMP_DIR/temp_file"

  # Run Docker container to download from source to temp file
  print_command "docker run --rm -i \
        -v \"$(realpath $TMP_DIR/.ssh):/root/.ssh\" \
        -v \"$(realpath $TMP_DIR):/tmp\" \
        \"$DOCKER_IMAGE\" \
        scp ${OPTIONS[*]} $SOURCE /tmp/temp_file"

  docker run --rm -i \
    -v "$(realpath $TMP_DIR/.ssh):/root/.ssh" \
    -v "$(realpath $TMP_DIR):/tmp" \
    "$DOCKER_IMAGE" \
    scp "${OPTIONS[@]}" "$SOURCE" "/tmp/temp_file"

  # Run Docker container to upload from temp file to destination
  print_command "docker run --rm -i \
        -v \"$(realpath $TMP_DIR/.ssh):/root/.ssh\" \
        -v \"$(realpath $TMP_DIR):/tmp\" \
        \"$DOCKER_IMAGE\" \
        scp ${OPTIONS[*]} /tmp/temp_file $DEST"

  docker run --rm -i \
    -v "$(realpath $TMP_DIR/.ssh):/root/.ssh" \
    -v "$(realpath $TMP_DIR):/tmp" \
    "$DOCKER_IMAGE" \
    scp "${OPTIONS[@]}" "/tmp/temp_file" "$DEST"

elif is_remote "$SOURCE"; then
  # Remote to local copy (download)
  LOCAL_DIR=$(dirname "$DEST")
  LOCAL_FILE=$(basename "$DEST")

  # Ensure local directory exists
  mkdir -p "$LOCAL_DIR"

  # Run Docker container
  print_command "docker run --rm -i \
        -v \"$(realpath $TMP_DIR/.ssh):/root/.ssh\" \
        -v \"$(realpath $LOCAL_DIR):/output\" \
        \"$DOCKER_IMAGE\" \
        scp ${OPTIONS[*]} $SOURCE /output/$LOCAL_FILE"

  docker run --rm -i \
    -v "$(realpath $TMP_DIR/.ssh):/root/.ssh" \
    -v "$(realpath $LOCAL_DIR):/output" \
    "$DOCKER_IMAGE" \
    scp "${OPTIONS[@]}" "$SOURCE" "/output/$LOCAL_FILE"

elif is_remote "$DEST"; then
  # Local to remote copy (upload)
  LOCAL_DIR=$(dirname "$SOURCE")
  LOCAL_FILE=$(basename "$SOURCE")

  # Run Docker container
  print_command "docker run --rm -i \
        -v \"$(realpath $TMP_DIR/.ssh):/root/.ssh\" \
        -v \"$(realpath $LOCAL_DIR):/input\" \
        \"$DOCKER_IMAGE\" \
        scp ${OPTIONS[*]} /input/$LOCAL_FILE $DEST"

  docker run --rm -i \
    -v "$(realpath $TMP_DIR/.ssh):/root/.ssh" \
    -v "$(realpath $LOCAL_DIR):/input" \
    "$DOCKER_IMAGE" \
    scp "${OPTIONS[@]}" "/input/$LOCAL_FILE" "$DEST"

else
  # Local to local copy, we can just use the host's cp command
  echo "Both source and destination are local, using cp instead of Docker"
  print_command "cp -r ${OPTIONS[*]} \"$SOURCE\" \"$DEST\""
  cp -r "${OPTIONS[@]}" "$SOURCE" "$DEST"
fi

# Completed successfully
if [[ "$OPTIONS" == *"-v"* ]]; then
  echo "Transfer completed."
fi

# sudo geany /usr/local/bin/docker-scp
#
# chmod a+x /usr/local/bin/docker-scp
# # Check if it works
# which docker-scp
