# Written by Lv6Lv

I'll try to organize this as best as I can.

```

#!/bin/bash

# Ask the user how many SSIDs they want to monitor

# Uncomment and use the following line for interactive use
# read -p "Enter the number of SSIDs you want to monitor: " num_ssids

#Set to 1 for testing, or dynamically adjust based on user input, or use the above and comment the num_ssids
num_ssids=1 

for ((i=1; i<=num_ssids; i++)); do
    # Collect each SSID and the corresponding message
    read -p "Enter SSID $i: " ssid
    read -p "Enter the message for $ssid: " message

    # Prepare the monitoring command, adjusted for .csv files
    monitor_command="bash -c '\
    files=\$(find /home/kali/Desktop/alert -type f -name \"LIGMA*.kismet\"); \
    while true; do \
        for file in \$files; do \
            if grep -Flwq \"$ssid\" \"\$file\"; then \
            	current_time=\$(date \"+%H:%M.%S\"); \
            	echo \"-\"; \
            	echo \"$ssid has been found - \$current_time\"; \
            	echo \"-\"; \
                espeak -v en-us \"$message\" 2>/dev/null; \
            fi; \
        done; \
        sleep 3; \
    done'"

    # Open a new GNOME Terminal window for each monitoring process
    gnome-terminal --title="$ssid" -- bash -c "$monitor_command"
done

echo
echo "Monitoring has started separate terminal windows."

```
# Usages examples

Example 1 using airodump
```
airodump-ng <interface> --write <filename> --output-format csv

```

Example 2 using kismet (change kismet_logging.conf)
change the following first than run kismet
```
log_title=LIGMA

#you must create a directory because kismet will not.

log_prefix=<full path to the directory you've created>


log_template=%p%n-%d-%T-%i.%l
```
