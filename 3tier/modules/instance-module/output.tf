output "web_server" {
  value = aws_instance.jenkin_server[*].id
}
output "jenkins_storage" {
  value = aws_ebs_volume.jenkin_storage.id
}

output "jenkins_storage_attach" {
  value = aws_volume_attachment.jenkins_storage_attach.id
}