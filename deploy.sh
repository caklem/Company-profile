#!/bin/bash

# Deployment Script for Hostinger
# Pastikan Anda sudah menginstal lftp: choco install lftp (Windows)

echo "🚀 Starting deployment to Hostinger..."

# Build the project
echo "📦 Building project..."
npm run build

if [ $? -eq 0 ]; then
    echo "✅ Build successful!"
else
    echo "❌ Build failed!"
    exit 1
fi

# FTP Configuration (Edit these values)
FTP_HOST="145.79.14.23"
FTP_USER="u230709022"
FTP_PASS="your-ftp-password"
REMOTE_DIR="/public_html"
LOCAL_DIR="./dist"

echo "📤 Uploading to Hostinger..."

# Upload using lftp
lftp -c "
set ftp:ssl-allow no;
open -u $FTP_USER,$FTP_PASS $FTP_HOST;
lcd $LOCAL_DIR;
cd $REMOTE_DIR;
mirror --reverse --delete --verbose --exclude-glob .git* --exclude-glob .DS_Store;
bye;
"

if [ $? -eq 0 ]; then
    echo "✅ Deployment successful!"
    echo "🌐 Website should be live at your domain"
else
    echo "❌ Deployment failed!"
    exit 1
fi

echo "🎉 Deployment completed!"
