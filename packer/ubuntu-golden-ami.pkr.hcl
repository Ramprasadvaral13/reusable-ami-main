packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  region                  = "us-east-1"
  instance_type           = "t2.micro"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"]  # Canonical official Ubuntu owner
    most_recent = true
  }
  ssh_username = "ubuntu"
  ami_name     = "golden-ubuntu-{{timestamp}}"
}

build {
  name    = "ubuntu-golden-build"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      # Enable universe repo and repair indexes
      "sudo add-apt-repository universe",
      "sudo apt clean",
      "sudo apt update -y",
      "sudo apt upgrade -y",
      # Install desired packages and auto-fix dependencies if needed
      "sudo apt install -y nginx unzip jq || sudo apt-get install -f -y",
      "# Install AWS CLI v2",
      "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
      "unzip awscliv2.zip",
      "sudo ./aws/install",
      "aws --version",
      "# Install CloudWatch Agent",
      "curl -O https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb",
      "sudo dpkg -i amazon-cloudwatch-agent.deb || sudo apt-get install -f -y",

      # Install Node.js (LTS version)
      "curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -",
      "sudo apt install -y nodejs",
      "node -v",
      "npm -v",

      "sudo systemctl enable nginx"
    ]
  }

  post-processor "manifest" {
    output = "manifest.json"
  }
}
