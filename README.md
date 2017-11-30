# Terraform ecs

```sh
terraform init
terraform workspace new -state=terraform.tfstate test
terraform init -backend-config="access_key=somekey" -backend-config="secret_key=somesecret" -backend-config="region=ap-southeast-2" -backend-config="bucket=bucketname" -backend-config="key=keyname"
terraform plan -var aws_access_key='somekey' -var aws_secret_key='somesecret' -var-file=workspace-variables/somevars.tfvars
terraform apply -var aws_access_key='somekey' -var aws_secret_key='somesecret' -var-file=workspace-variables/somevars.tfvars
```

_TODO - needs more juice_

* s3 setup etc
* blog it?
