# Use the official R base image
FROM rocker/shiny:latest

# Install system dependencies for R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libxt6 \
    libglpk-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev

# Copy your app and package installation script
COPY . /srv/shiny-server/

# Set working directory
WORKDIR /srv/shiny-server/

# Install R packages
RUN Rscript install.packages.R

# Expose Shiny port
EXPOSE 3838

# Make app readable
RUN chown -R shiny:shiny /srv/shiny-server

# Run the app as the 'shiny' user
USER shiny

CMD ["/usr/bin/shiny-server"]
