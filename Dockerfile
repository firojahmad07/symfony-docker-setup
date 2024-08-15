# Use the official PHP image as the base
FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs=20.16.0-1nodesource1

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the existing application directory contents
COPY . .

# Install Symfony
RUN composer create-project symfony/skeleton

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]