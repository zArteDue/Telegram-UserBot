# We're using Alpine stable
FROM debian:buster-slim

#
# Early Aptitude configuration
#
RUN apt-get update
RUN apt-get install -y gnupg

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN echo "deb http://repo.mongodb.org/apt/debian \
    "stretch"/mongodb-org/4.0 main" \
    | tee /etc/apt/sources.list.d/mongodb.list

# Installing Python
RUN apt-get install -y \
    git \
    dash \
    python3 \
    redis \
    python-pip \
    curl \
    neofetch \
    sqlite \
    figlet

RUN apt-get install mongodb-org
RUN pip3 install --upgrade pip setuptools

RUN git clone -b master https://github.com/baalajimaestro/Telegram-UserBot
WORKDIR Telegram-UserBot

#
#Copies session and config(if it exists)
#

COPY ./userbot.session ./config.env*

#
# Install requirements
#

RUN sudo pip3 install -r requirements.txt
CMD ["dash","init/start.sh"]