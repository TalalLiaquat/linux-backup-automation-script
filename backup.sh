#!/bin/bash

# Stop script if any command fails
set -e

# ==============================
# Variables
# ==============================

SOURCE_DIR=$1
BACKUP_DIR="/backups"
LOG_FILE="/var/log/backup.log"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_NAME="backup_$TIMESTAMP.tar.gz"

# ==============================
# Function for logging
# ==============================

log_message() {
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $1" >> "$LOG_FILE"
}

# ==============================
# Check if source folder provided
# ==============================

if [ -z "$SOURCE_DIR" ]; then
    echo "Usage: ./backup.sh /path/to/source"
    exit 1
fi

# ==============================
# Check if source directory exists
# ==============================

if [ ! -d "$SOURCE_DIR" ]; then
    log_message "ERROR: Source directory not found: $SOURCE_DIR"
    echo "Source directory does not exist!"
    exit 1
fi

# ==============================
# Create backup directory if not exists
# ==============================

if [ ! -d "$BACKUP_DIR" ]; then
    mkdir -p "$BACKUP_DIR"
    log_message "Backup directory created: $BACKUP_DIR"
fi

# ==============================
# Check disk space
# ==============================

AVAILABLE_SPACE=$(df "$BACKUP_DIR" | awk 'NR==2 {print $4}')

if [ "$AVAILABLE_SPACE" -lt 10000 ]; then
    log_message "ERROR: Disk space is too low!"
    echo "Disk space is low!"
    exit 1
fi

# ==============================
# Create Backup
# ==============================

if tar -czf "$BACKUP_DIR/$BACKUP_NAME" "$SOURCE_DIR"; then
    log_message "SUCCESS: Backup created successfully: $BACKUP_NAME"
    echo "Backup created successfully!"
else
    log_message "ERROR: Backup failed!"
    echo "Backup failed!"

    # Bonus Email Alert
    echo "Backup Failed on $(date)" | mail -s "Backup Failure Alert" admin@example.com

    exit 1
fi

# ==============================
# Delete backups older than 7 days
# ==============================

find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -delete

log_message "Old backups older than 7 days deleted."

echo "Task completed successfully!"