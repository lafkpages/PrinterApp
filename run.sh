# Start server
python3 -m http.server -d ./public/ 65457 &
SERVER_PID=$!

kill_server() {
  echo "Killing server..."
  kill $SERVER_PID
  exit 0
}

trap 'kill_server' SIGINT

sleep 1

# Open in browser
open -u "http://127.0.0.1:65457/" &

echo "Press ctrl-c to quit"

while true; do
  sleep 1
done