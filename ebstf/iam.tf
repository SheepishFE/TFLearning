resource "aws_iam_role" "nfsinstanceprofile" {
    name                = "nfsinstanceprofile"
    assume_role_policy   = file("assume-role-policy-ec2.json")
}

resource "aws_iam_role_policy" "nfs-iam-role-policy" {
    name   = "nfs-iam-role-policy"
    role   = aws_iam_role.nfsinstanceprofile.id
    policy = file("iam-policy-nfs.json") 
}

resource "aws_iam_instance_profile" "nfsinstanceprofile-iamrole" {
    name = aws_iam_role.nfsinstanceprofile.name
    role = aws_iam_role.nfsinstanceprofile.name
}