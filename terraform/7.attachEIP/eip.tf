resource "aws_eip" "ip" {
  instance = "i-00e32932aa54062c4" #aws_instance.server.id
  vpc      = true
}

/*
data "aws_instance" "server" {

}
*/