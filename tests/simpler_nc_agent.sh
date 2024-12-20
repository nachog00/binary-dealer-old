#!/bin/bash

#!/bin/bash

# Hardcoded variables
HOST="localhost"
PORT=3333
HEADERS="Connection: close\r\nHost: $HOST\r\nAccept: application/json\r\nContent-Type: application"

# Default to GET method
METHOD="GET"

# Parse command line arguments
while getopts ":m:" opt; do
  case ${opt} in
    m )
      METHOD=$OPTARG
      ;;
    \? )
      echo "Usage: $0 [-m method] endpoint"
      exit 1
      ;;
  esac
done
shift $((OPTIND - 1))

# Get the positional argument for endpoint
ENDPOINT="$1"

# Check if ENDPOINT was provided
if [ -z "$ENDPOINT" ]; then
    echo "Error: Endpoint must be specified."
    echo "Usage: $0 [-m method] endpoint"
    exit 1
fi

# Construct the HTTP request
REQUEST="$METHOD $ENDPOINT HTTP/1.1\r\n$HEADERS\r\n\r\n"

# Print the full request for debugging
echo -e "Full Request:\n$REQUEST"

# Send the request using nc
echo -e "$REQUEST" | nc "$HOST" "$PORT"
