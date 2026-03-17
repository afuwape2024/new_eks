#create web server ec2 
resource "aws_instance" "jenkin_server" {
  count = 1
  ami     = var.ami
  instance_type = var.instance_type
  subnet_id                   = var.web_subnet
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.web-security_group]
  user_data = file("${path.module}/jenkins.sh")
  iam_instance_profile = "delete_ec2_eks"

  tags = var.mandatory_tags

}

# Create the EBS Volume
resource "aws_ebs_volume" "jenkin_storage" {
  availability_zone = "us-east-2a"
  size              = 20 # Size in GiB
}

# Attach Volume to Instance
resource "aws_volume_attachment" "jenkins_storage_attach" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.jenkin_storage.id
  instance_id = aws_instance.jenkin_server[0].id
}
