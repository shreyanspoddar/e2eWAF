output "sgid" {
  value = aws_security_group.websg.id
}
output "Websubnet1id" {
  value = aws_subnet.Websubnet-1.id
}
output "Websubnet2id" {
    value = aws_subnet.Websubnet-2.id
}
output "databasesubnet1id" {
  value = aws_subnet.DatabaseSubnet-1.id
}
output "databasesubnet2id" {
  value = aws_subnet.DatabaseSubnet-2.id
}