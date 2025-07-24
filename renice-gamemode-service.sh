#!/bin/bash

update_renice() {
    if [ "$1" = "update" ]; then
        if [ -f /tmp/renice-gamemode-pid.log ]; then
            > /tmp/renice-gamemode-pid.log
            while read -r PID; do
                if [[ $PID =~ ^[0-9]+$ ]]; then
                    if kill -0 "$PID" 2>/dev/null; then
                        current_nice=$(ps -o nice= -p "$PID" | tr -d ' ')
                        if [[ -n "$current_nice" && "$current_nice" != "-" && "$current_nice" =~ [0-9] ]]; then
                            if [ "$current_nice" != "-20" ]; then
                                sudo renice -n -20 -p "$PID" && \
                                sleep 0.5
                            fi
                        else
                            sed -i "/^${PID}$/d" /tmp/renice-gamemode-pid.log
                        fi
                    else
                        sed -i "/^${PID}$/d" /tmp/renice-gamemode-pid.log
                    fi
                fi
            done < /tmp/renice-gamemode-pid.log
        fi
    fi
}

while true; do
    update_renice update
    sleep 15
done
