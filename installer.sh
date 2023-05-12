#!/bin/bash

while true; do
    clear
    # Prompt the user for email address
    read -p "Enter your email address: " email

    # Prompt the user for website
    read -p "Enter your website: " website

    # Display the entered information
    echo "Email: $email"
    echo "Website: $website"

    # Prompt for confirmation
    read -p "Is the information correct? (y/n): " confirm

    # Check confirmation input
    if [ "$confirm" == "y" ] || [ "$confirm" == "Y" ]; then
        break  # Break out of the loop if confirmed
    fi

    echo "Please re-enter the information."
done

echo "Installing essential files"

apt update;apt install build-essential socat git curl gnupg2 ca-certificates lsb-release -y

echo "Installing Nginx"
echo "deb https://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \ | sudo tee /etc/apt/sources.list.d/nginx.list;curl -fsSL https://nginx.org/keys/nginx_signing.key | sudo apt-key add -;apt update; apt install nginx -y

echo "Installing acme"
curl https://get.acme.sh | sh;~/.acme.sh/acme.sh --set-default-ca --server letsencrypt;~/.acme.sh/acme.sh --register-account -m $email
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt;~/.acme.sh/acme.sh --register-account -m $email


echo "Issueing certificate for $website"
~/.acme.sh/acme.sh --issue --standalone -d $website --keylength 2048
~/.acme.sh/acme.sh --issue --standalone -d $website --keylength ec-256

mkdir -p /etc/letsencrypt/$website

~/.acme.sh/acme.sh --install-cert -d $website --cert-file /etc/letsencrypt/$website/cert.pem --key-file /etc/letsencrypt/$website/private.key --fullchain-file /etc/letsencrypt/$website/fullchain.cer
~/.acme.sh/acme.sh --install-cert -d $website --ecc --cert-file /etc/letsencrypt/$website/cert.pem.ecc --key-file /etc/letsencrypt/$website/private.key.ecc --fullchain-file /etc/letsencrypt/$website/fullchain.cer.ecc


curl https://raw.githubusercontent.com/pouyaam/tls_reality_domain/main/sample_config.conf > ./sample_config.conf

rm -rf /etc/nginx/conf.d/default.conf
sed -i "s/WEBSITE/$website/g" ./sample_config.conf
mv ./sample_config.conf /etc/nginx/conf.d/$website.conf


service nginx restart

# Example command: Display completion message

clear
echo "Installation complete!"
echo "Your tls address is $website:443"
