# shell-projects-opshub

🟢 BEGINNER LEVEL — “Get Comfortable with Core Tools & Logic”
✅ For viewers who know basic Linux commands but haven’t written real scripts. 

📂 Project 1: The Log Cleaner
→ find, df, rm, simple if
→ Teaches: automation, safety checks, cron

📂 Project 2: The Backup Hero
→ tar, gzip, date, basic error handling
→ Teaches: file operations, naming conventions, reliability

📂 Project 3: The Health Checker
→ free, df, awk, color output
→ Teaches: parsing system data, thresholds, alerts

💡 These projects feel “useful immediately” — builds motivation + muscle memory. 

🟡 INTERMEDIATE LEVEL — “Handle Real-World Complexity”
✅ For viewers ready to read files, handle user input, and build reusable logic. 

📂 Project 4: The User Onboarder
→ useradd, reading CSV, loops
→ Teaches: batch operations, input validation, logging

📂 Project 5: The Deployment Buddy
→ scp, ssh, systemctl, rollback logic
→ Teaches: remote ops, functions, deployment safety

📂 Project 6: The File Organizer
→ ${file##*.}, case, config flags
→ Teaches: string manipulation, modular design, user options

📂 Project 7: The Security Auditor
→ find -perm, netstat, report generation
→ Teaches: security mindset, parsing system state, output formatting

💡 These mimic real sysadmin/DevOps tasks — perfect for resume bullets & interviews. 

🔴 ADVANCED LEVEL — “Production-Grade, Reliable, Scalable Scripts”
✅ For viewers ready to build tools used by teams — with error handling, modularity, and polish. 

📂 Project 8: The Report Generator
→ HTML output, embedding stats, email integration
→ Teaches: professional reporting, automation pipelines

📂 Project 9: The Process Watchdog
→ pgrep, background jobs, infinite loops, logging
→ Teaches: service reliability, monitoring, auto-healing

📂 Project 10: The DevOps Swiss Army Knife (CAPSTONE)
→ Menu system, modular sourcing, config files, help flags
→ Teaches: tool design, UX for scripts, professional polish

💡 These are portfolio gold — viewers can say:
“I built a unified ops toolkit used by my team.” 

🔑 Things to Explain Before Execution

The Real-World Problem (Why this matters)

Logs grow over time → can crash a system.

Disk full at odd hours → downtime + stress.

This script automates prevention.

Script Purpose (What this script solves)

Automates cleanup of old logs.

Prevents disk from running out of space.

Adds safety features: dry-run, confirmation, logging.

Key Components (Explain the building blocks)

Config section: log directory, retention days, log file.

Colors: improves readability in terminal.

Functions:

log_message() → records actions with timestamp.

usage() → explains how to use script.

Safety Checks:

Root warning.

Directory existence check.

Modes:

Dry-run mode (preview only).

Real run with user confirmation.

The Flow of Execution (How the script thinks)

Start → check environment (root, directory).

Show current disk usage.

Find old log files.

If dry-run → show what would be deleted.

If real → ask confirmation → delete files → log actions.

Show disk usage after cleanup.

End with a success message.

Features That Add Professional Value

Logging to file → proof of what happened.

Dry-run option → safe testing before real deletion.

User confirmation → avoids accidental deletes.

Automation ready → can be scheduled with cron.