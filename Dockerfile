FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
  apt-get install -y wget supervisor

# Download and extract Zulip
RUN wget https://www.zulip.org/dist/releases/zulip-server-latest.tar.gz
RUN tar -xf zulip-server-latest.tar.gz -C /root/
RUN mv /root/zulip-server-* /root/zulip

# Set up Zulip
WORKDIR /root/zulip
RUN ./scripts/setup/install --self-signed-cert --no-init-db --email=youremail@example.com --hostname=localhost

# Copy supervisor config file
COPY zulip.conf /etc/supervisor/conf.d/zulip.conf

# Expose Zulip's port
EXPOSE 9991

# Start Zulip
CMD ["supervisord", "-n"]
