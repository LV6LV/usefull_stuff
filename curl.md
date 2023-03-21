# All credit goes to original posters
**check out the original post:**
https://unix.stackexchange.com/questions/83926/how-to-download-a-file-using-just-bash-and-nothing-else-no-curl-wget-perl-et/421318#421318

**---- *Modified by LV6LV* ----**


## curl without curl: 
```
function __curl() {
  read proto server path <<<$(echo ${1//// })
  DOC=/${path// //}
  HOST=${server//:*}
  PORT=${server//*:}
  [[ x"${HOST}" == x"${PORT}" ]] && PORT=80

  exec 3<>/dev/tcp/${HOST}/$PORT
  echo -en "GET ${DOC} HTTP/1.0\r\nHost: ${HOST}\r\n\r\n" >&3
  (while read line; do
   [[ "$line" == $'\r' ]] && break
  done && cat) <&3
  exec 3>&-
}

ivs@acsfrlt-j8shv32:/mnt/r $ __curl http://www.google.com/favicon.ico > mine.ico
ivs@acsfrlt-j8shv32:/mnt/r $ curl http://www.google.com/favicon.ico > theirs.ico
ivs@acsfrlt-j8shv32:/mnt/r $ md5sum mine.ico theirs.ico
f3418a443e7d841097c714d69ec4bcb8  mine.ico
f3418a443e7d841097c714d69ec4bcb8  theirs.ico

```

## Use uploading instead, via SSH from your local machine

```
wget -O - http://example.com/file.zip | ssh user@host 'cat >/path/to/file.zip'

```
