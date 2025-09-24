#!/bin/bash

# ==================================================
# 🧹 PROJECT 1: THE LOG CLEANER
# Automate cleanup of old log files before disk crashes
# Story: "At 3 AM, the disk hit 98%. I ran this — and saved the site."
# ==================================================

# CONFIGURATION
LOG_DIR="/var/log"           # Directory to clean (change if needed)
DAYS_OLD=7                   # Delete logs older than this many days
LOG_FILE="/var/log/cleanup_$(date '+%Y%m%d_%H%M%S').log" # Timestamped log file

# COLORS (for terminal output)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Function to show usage
usage() {
    echo "Usage: $0 [--dry-run]"
    echo "  --dry-run   : Show what would be deleted (no actual deletion)"
    exit 0
}

# Check if running as root (optional)
if [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}⚠️  Warning: Not running as root. Some logs may not be deletable.${NC}"
fi

# Parse arguments
DRY_RUN=false
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo -e "${YELLOW}🔍 DRY RUN MODE — No files will be deleted.${NC}"
    echo -e "${YELLOW}   This shows what WOULD be cleaned up.${NC}"
    echo ""
fi

# Confirm directory exists
if [ ! -d "$LOG_DIR" ]; then
    echo -e "${RED}❌ Error: Directory $LOG_DIR does not exist.${NC}"
    exit 1
fi

# Show current disk usage
echo -e "${GREEN}📊 Current Disk Usage:${NC}"
df -h | grep -E "(\/$|\/var$)"

echo ""
log_message "🧹 Starting log cleanup in $LOG_DIR (older than $DAYS_OLD days)"

# Build the find command
FIND_CMD="find $LOG_DIR -name \"*.log*\" -mtime +$DAYS_OLD"

if [ "$DRY_RUN" = true ]; then
    # DRY RUN — just print and log
    echo -e "${YELLOW}📋 Files that would be deleted:${NC}"
    eval $FIND_CMD -print | while read file; do
        echo "  → $file"
        log_message "Would delete: $file"
    done
    FILE_COUNT=$(eval $FIND_CMD | wc -l)
    echo -e "${YELLOW}📊 Total files: $FILE_COUNT${NC}"
    log_message "DRY RUN: $FILE_COUNT files would be deleted."
else
    # REAL RUN — confirmation
    echo -e "${RED}🧨 WARNING: This will DELETE files. Are you sure? (y/N)${NC}"
    read -r CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
        echo "🛑 Aborted by user."
        log_message "ABORTED: User canceled deletion."
        exit 0
    fi

    echo -e "${RED}🧨 DELETING FILES...${NC}"
    FILE_COUNT=0
    while IFS= read -r file; do
        if rm -f "$file" 2>/dev/null; then
            echo "  ✅ Deleted: $file"
            log_message "Deleted: $file"
            ((FILE_COUNT++))
        else
            echo "  ❌ Failed to delete: $file"
            log_message "Failed to delete: $file"
        fi
    done < <(eval $FIND_CMD -print)

    echo -e "${GREEN}✅ Cleanup complete. Deleted $FILE_COUNT files.${NC}"
    log_message "SUCCESS: Deleted $FILE_COUNT files."
fi

# Show disk usage after cleanup
echo ""
echo -e "${GREEN}📊 Disk Usage After Cleanup:${NC}"
df -h | grep -E "(\/$|\/var$)"

# Final success message
if [ "$DRY_RUN" = false ]; then
    echo ""
    echo -e "${GREEN}🎉 You just saved the server. Go get coffee. ☕${NC}"
fi
