#!/bin/bash

# Function to get total CPU usage using top
get_cpu_usage() {
  echo "Total CPU Usage:"
  top -bn1 | grep "Cpu(s)" | \
    awk '{printf "%.1f%% user, %.1f%% system, %.1f%% idle\n", $2+$4, $6, $8}'
}

# Function to get total memory usage
get_memory_usage() {
  echo -e "\nTotal Memory Usage:"
  free -m | awk 'NR==2{printf "Used: %sMB (%.2f%%), Free: %sMB (%.2f%%)\n", $3, $3*100/$2, $4, $4*100/$2 }'
}

# Function to get total disk usage
get_disk_usage() {
  echo -e "\nTotal Disk Usage:"
  df -h --total | awk 'END{printf "Used: %s (%s), Free: %s (%s)\n", $3, $5, $4, $5 }'
}

# Function to get top 5 processes by CPU usage
get_top_cpu_processes() {
  echo -e "\nTop 5 Processes by CPU Usage:"
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6
}

# Function to get top 5 processes by memory usage
get_top_memory_processes() {
  echo -e "\nTop 5 Processes by Memory Usage:"
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6
}

# Stretch goals
get_os_version() {
  echo -e "\nOS Version:"
  lsb_release -a
}

get_uptime() {
  echo -e "\nUptime:"
  uptime
}

get_load_average() {
  echo -e "\nLoad Average:"
  uptime | awk -F'[a-z]:' '{ print $2 }'
}

get_logged_in_users() {
  echo -e "\nLogged In Users:"
  who
}

get_failed_login_attempts() {
  echo -e "\nFailed Login Attempts:"
  grep "Failed password" /var/log/auth.log | wc -l
}

# Main script
get_cpu_usage
get_memory_usage
get_disk_usage
get_top_cpu_processes
get_top_memory_processes
get_os_version
get_uptime
get_load_average
get_logged_in_users
get_failed_login_attempts
