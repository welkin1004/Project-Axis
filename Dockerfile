# Use the official PHP with Apache image
FROM php:8.1.10-apache

# Install required PHP extensions
RUN docker-php-ext-install mysqli curl mbstring

# Install PHPMyAdmin
ENV PHPMYADMIN_VERSION=5.2.0
RUN mkdir -p /var/www/phpmyadmin && \
    curl -L https://files.phpmyadmin.net/phpMyAdmin/$PHPMYADMIN_VERSION/phpMyAdmin-$PHPMYADMIN_VERSION-all-languages.tar.gz | tar xvz --strip-components 1 -C /var/www/phpmyadmin

# Install Node.js and NPM
ENV NODE_VERSION=18.17.0
RUN curl -fsSL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -
RUN apt-get install -y nodejs

# Set the working directory
WORKDIR /var/www/html

# Copy your PHP files into the container
COPY php-files/ /var/www/html/

# Install React.js
ENV REACT_VERSION=17.0.2
RUN npm install -g create-react-app@${REACT_VERSION}

# Expose ports
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]
