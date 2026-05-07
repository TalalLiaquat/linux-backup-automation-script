🐧 Linux Backup Automation Script
===============================

## 📌 Overview
This project is a Bash-based automation script that creates compressed backups of a specified directory. It is designed as a beginner DevOps practice project to understand Linux scripting, automation, logging, and system-level task handling.

---

## 🚀 Features
- Accepts source directory as a command-line argument  
- Creates timestamped `.tar.gz` backups  
- Stores backups in a backup directory  
- Logs success and failure events with timestamps  
- Handles errors (missing directory, disk issues)  
- Automatically deletes backups older than 7 days (bonus feature)  

---

## 🛠️ Technologies Used
- Bash Scripting  
- Linux Commands  
- tar (compression utility)  
- find (file cleanup automation)  
- cron (optional for scheduling)  

---

## 📂 Project Structure

backup.sh # Main backup script
README.md # Project documentation


---

## ⚙️ How to Use

### 1. Give execute permission
chmod +x backup.sh
2. Run the script
./backup.sh /path/to/source-folder
Example
./backup.sh /var/www/html
📁 Output
Backups are stored as:
/backups/backup_YYYY-MM-DD_HH-MM-SS.tar.gz
Logs are stored in:
backup.log
⏰ Optional (Automation with Cron)

To run backup daily at 2 AM:

crontab -e
Add this line:
0 2 * * * /path/to/backup.sh /var/www/html
🔥 Learning Outcomes
Linux file system understanding
Bash scripting fundamentals
Automation using cron jobs
Error handling in shell scripts
Real-world DevOps workflow simulation
👨‍💻 Author

Talal Liaquat
Beginner DevOps & Computer Science Student
