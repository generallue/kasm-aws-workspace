#!/bin/bash

# Step 1: Install Certbot
sudo apt update
sudo apt install certbot -y

# Step 2: Stop OpenVPN
sudo systemctl stop openvpn

# Step 3: Obtain Let's Encrypt Certificate
sudo certbot certonly --standalone -d vpn.domain.com

# Step 4: Configure OpenVPN
sudo sed -i 's|^cert .*|cert /etc/letsencrypt/live/vpn.domain.com/fullchain.pem|' /etc/openvpn/server.conf
sudo sed -i 's|^key .*|key /etc/letsencrypt/live/vpn.domain.com/privkey.pem|' /etc/openvpn/server.conf

# Step 5 (Optional): Enable TLS Authentication
sudo sed -i '$ a tls-auth /etc/openvpn/ta.key 0' /etc/openvpn/server.conf
sudo sed -i '$ a key-direction 0' /etc/openvpn/server.conf

# Step 6 (Optional): Generate TLS-Auth Key
sudo openvpn --genkey --secret /etc/openvpn/ta.key

# Step 7: Start OpenVPN
sudo systemctl start openvpn

# Step 8: Automate Certificate Renewal (Optional)
sudo certbot renew --dry-run

# Step 9: Output completion message
echo "SSL certificate has been configured for your OpenVPN server."
