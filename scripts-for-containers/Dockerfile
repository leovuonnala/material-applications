# Use Docker official CLI image based on Alpine
FROM docker:stable

# Install git and bash
RUN apk add --no-cache git bash

# Copy the script into the container
COPY builder.sh /usr/local/bin/builder.sh

# Make it executable
RUN chmod +x /usr/local/bin/builder.sh

# Set entrypoint to run the script with passed args
ENTRYPOINT ["/usr/local/bin/builder.sh"]
