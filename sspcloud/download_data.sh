#!/usr/bin/env bash
echo "Executing the download_data.sh script"

# === Description ===
# This script downloads a data file from an S3 bucket using `mc` (MinIO client)
# and stores it in the ~/work/data directory.

# === Config destination folder ===
DEST_DIR="$HOME/work/data"
# Ensure destination folder exists
mkdir -p "$DEST_DIR"

# === S3 settings ===

# Configure alias for the public S3 endpoint (anonymous access)
mc alias set s3 https://minio.lab.sspcloud.fr "" ""

# === Download all data files ===
# You can modify the list of files
FILES=(
    "s3/jareknapora/data_WP9_S1_PL/WP9_S1_Tourism_synt.rds"
)

# Function to download with retry
download_file() {
    local file=$1
    local dest=$2
    local retries=3
    local count=0

    while [ $count -lt $retries ]; do
        echo "Attempt $((count+1)) to download $file..."
        if mc cp "$file" "$dest"; then
            echo "Download of $file succeeded."
            return 0
        else
            echo "Download failed for $file. Retrying..."
            ((count++))
            sleep 2
        fi
    done
    echo "Failed to download $file after $retries attempts."
    return 1
}

# Iterate and download each file
for FILE in "${FILES[@]}"; do
    echo "Downloading $FILE to $DEST_DIR..."
    download_file "$FILE" "$DEST_DIR"
done
