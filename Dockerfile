FROM oraclelinux:8
LABEL maintainer="makhinya@gmail.com"

# 1. Install system components and dependencies
RUN yum -y install \
    at-spi2-core \
    atk \
    cairo \
    gdk-pixbuf2 \
    git \
    gtk3 \
    java-1.8.0-openjdk \
    libdrm \
    libxkbcommon \
    libXdamage \
    libXfixes \
    libXrandr \
    maven \
    mesa-libgbm \
    nss \
    pango \
    unzip

# 2. Create and configure pwuser
RUN useradd -p pwuser pwuser
USER pwuser
WORKDIR /home/pwuser
COPY ./scripts/download_driver.sh ./scripts/

# 3. Download drivers
# Please note that download path used from download_driver.sh so you may wish to make symlink from your project home:
# > ln -s /home/pwuser/playwright/src/main/resources/driver <project_home>/driver
RUN mkdir -p playwright/src/main/resources \
 && sh ./scripts/download_driver.sh

# 4. Here you are ready to use playwright-java!
