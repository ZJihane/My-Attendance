# Use an official PHP image with Apache
FROM php:8.1-apache

# Install required PHP extensions and Git
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && docker-php-ext-install pdo pdo_mysql

# Enable Apache mod_rewrite for Laravel
RUN a2enmod rewrite

# Install Node.js and npm
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs

# Set the working directory
WORKDIR /var/www/html

# Copy the application code to the container
COPY . /var/www/html

# Install Composer
COPY --from=composer:2.1 /usr/bin/composer /usr/bin/composer

# Install Composer dependencies
RUN composer install --no-dev --optimize-autoloader

# Install Node.js dependencies
RUN npm install

# Set permissions for Laravel (including public directory)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache /var/www/html/public

# Build the front-end assets
RUN npm run build

# Expose the web server port
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]
