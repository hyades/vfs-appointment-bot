FROM --platform=linux/amd64 python:3.9-slim as build
# commands install the cv2 dependencies that are normally present on the local machine,
# but might be missing in your Docker container
WORKDIR /app
ADD . .

# Install Firefox
RUN apt-get update && \
    apt-get install -y curl bzip2 && \
    curl -L -o firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/113.0.1/linux-x86_64/en-US/firefox-113.0.1.tar.bz2 && \
    tar xvjf firefox.tar.bz2 -C /opt && \
    ln -s /opt/firefox/firefox /usr/bin/firefox && \
    rm firefox.tar.bz2

# Install app dependencies
RUN pip3 --no-cache-dir install -r requirements.txt

ENTRYPOINT [ "python3" ]
CMD ["vfs_appointment_bot/vfs_appointment_bot.py"]