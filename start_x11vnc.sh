#!/bin/bash
run_vnc_server() {
    export DISPLAY=:1
    local passwordArgument='-nopw'

    if [ -n "${VNC_SERVER_PASSWORD}" ]
    then
        local passwordFilePath="${HOME}/x11vnc.pass"
        if ! x11vnc -storepasswd "${VNC_SERVER_PASSWORD}" "${passwordFilePath}"
        then
            echo "[ERROR] Failed to store x11vnc password."
            exit 1
        fi
        passwordArgument=-"-rfbauth ${passwordFilePath}"
        echo "[INFO] The VNC server will ask for a password."
    else
        echo "[WARN] The VNC server will NOT ask for a password."
    fi

    x11vnc -ncache 10 -display ${DISPLAY} -forever "${passwordArgument}"  &
    # x11vnc -xkb -display ${DISPLAY} -forever ${passwordArgument} &
    wait $!
}

run_vnc_server &