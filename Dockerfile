FROM python:3.9-slim as build

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    bzip2 \
    && rm -rf /var/lib/apt/lists/*

# Install Firefox
RUN curl -L -o firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/113.0.1/linux-x86_64/en-US/firefox-113.0.1.tar.bz2 \
    && tar xvjf firefox.tar.bz2 -C /opt \
    && ln -s /opt/firefox/firefox /usr/bin/firefox \
    && rm firefox.tar.bz2

WORKDIR /app

# Copy the requirements file separately and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files
COPY . .

ENTRYPOINT [ "python3" ]
CMD ["vfs_appointment_bot/vfs_appointment_bot.py"]