#!/bin/bash
cat <<EOF >/home/ubuntu/setup.sh
#!/bin/bash

# Install jq, curl, libdigest-sha-perl
sudo apt-get update
sudo apt-get install -y jq curl libdigest-sha-perl
echo "1...Installed required libraries"

# Create a folder
mkdir actions-runner
cd actions-runner
echo "2...Created actions-runner directory"

# Download the runner package
curl -o actions-runner-linux-x64-2.305.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.305.0/actions-runner-linux-x64-2.305.0.tar.gz
echo "3...Downloaded the runner package"

# Optional: Validate the hash
echo "737bdcef6287a11672d6a5a752d70a7c96b4934de512b7eb283be6f51a563f2f  actions-runner-linux-x64-2.305.0.tar.gz" | shasum -a 256 -c
echo "4...Validated the hash"

# Extract the installer
tar xzf ./actions-runner-linux-x64-2.305.0.tar.gz
echo "5...Extracted the installer"

# Generate runners registration token

curl --request POST 'https://api.github.com/repos/boobal-writes/infrastructure/actions/runners/registration-token' --header "Authorization: token ${personal_access_token}" > response.json
chown ubuntu:ubuntu response.json
echo "6...Generated token"

# Create the runner
./config.sh --url https://github.com/boobal-writes/infrastructure --token \$(jq -r '.token' response.json) --name "ec2-github-runner-instance-$(hostname)" --unattended
echo "7...Created the runner"

# Last step, run it!
./run.sh
EOF
cd /home/ubuntu
chmod +x setup.sh
/bin/su -c "./setup.sh" - ubuntu | tee /home/ubuntu/setup.log