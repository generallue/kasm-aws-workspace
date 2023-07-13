# Kasm UseCase

Mostly used to bypass network restrictions and open suspiciuos links in safe environment.

# Kasm Installation Cmd
cd /tmp && curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.13.1.421524.tar.gz && tar -xf kasm_release_1.13.1.421524.tar.gz && yes | sudo bash kasm_release/install.sh

Just copy paste the cmd in your machine/ec2/vm/any to install and use Kasm Workspace.

Rest Explore yourself :)

# Kasm Terraform Setup

Make sure to change key pair value and instance type - I tried with t2.micro only workspace is up other images are not loading - instance.tf

Make Sure to update tf backend block in main.tf

IF you are trying to set this up in different region, make sure to update vpc.tf with correct region.
