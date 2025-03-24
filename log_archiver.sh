#!/bin/bash

# Check if the user provided a directory
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <log-directory>"
    exit 1
fi

LOG_DIR=$1
ARCHIVE_DIR="$HOME/log_archives"
TIMESTAMP=$(date "+%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
LOG_FILE="${ARCHIVE_DIR}/archive_log.txt"
# Create the archive directory if it doesn't exist
mkdir -p "$ARCHIVE_DIR"

# Compress the logs
if tar --exclude="btmp*" --exclude="private" -czf "${ARCHIVE_DIR}/${ARCHIVE_NAME}" -C "$LOG_DIR" .; then
   echo "[$(date)] Archived logs from $LOG_DIR to ${ARCHIVE_DIR}/${ARCHIVE_NAME}" >> "$LOG_FILE"
   echo "Logs successfully archived: ${ARCHIVE_NAME}"
else
   echo "[$(date)] Failed to archive logs from $LOG_DIR" >> "$LOG_FILE"
   echo "Error: Failed to archive logs."
   exit 1
fi
