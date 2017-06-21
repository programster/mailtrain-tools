FROM ubuntu:16.04

RUN apt-get update
RUN apt-get dist-upgrade -y

# Install the relevant packages
RUN apt-get install php7.0 php7.0-cli php7.0-mysql -y

# Add the files
ADD main.php /root/main.php

# Execute the containers startup script which will start many processes/services
# The startup file was already added when we added "project"
CMD ["/usr/bin/php", "/root/main.php"]
