#!/bin/bash

PORT=65457

function handleRequest() {
  while read line; do
    echo $line
    trline=`echo $line | tr -d '[\r\n]'`

    [ -z "$trline" ] && break

    #HEADLINE_REGEX='(.*?)\s(.*?)\sHTTP.*?'
    HEADLINE_REGEX='^([^ ]+) ([^ ]+) HTTP.*'

    [[ "$trline" =~ $HEADLINE_REGEX ]] &&
      REQUEST=$(echo $trline | sed -E "s/$HEADLINE_REGEX/\1 \2/")
  done

  case "$REQUEST" in
    "GET /")
      RESPONSE=`echo -ne "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n"; cat public/index.html`
      ;;

    "GET /script.js")
      RESPONSE=`echo -ne "HTTP/1.1 200 OK\r\nContent-Type: text/javascript\r\n\r\n"; cat public/script.js`
      ;;

    "GET /printer.js")
      RESPONSE=`echo -ne "HTTP/1.1 200 OK\r\nContent-Type: text/javascript\r\n\r\n"; cat public/printer.js`
      ;;

    *)
      RESPONSE="HTTP/1.1 404 NotFound\r\n\r\n\r\nNot Found"
      ;;
  esac

  echo -n "$RESPONSE" > response
}

server() {
  ### Create the response FIFO
  rm -f response
  mkfifo response

  echo "Listening on $PORT..."

  while :; do
    cat response | nc -l "$PORT" | handleRequest
  done
}

# Start server
server &
SERVER_PID=$!

kill_server() {
  echo "Killing server..."
  kill $SERVER_PID
  exit 0
}

trap 'kill_server' SIGINT

sleep 1

# Open in browser
#open -u "http://127.0.0.1:$PORT/" &

echo "Press ctrl-c to quit"

while true; do
  sleep 1
done