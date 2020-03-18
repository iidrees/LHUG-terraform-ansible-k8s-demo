# LHUG-terraform-ansible-k8s-demo



### Steps

  - Run `terraform init` in the `LHUG-terraform-ansible-k8s-demo/terraform` directory, so you would need to 
  change directory into that `terraform` directory first and than add your service `account.json` in the `creds` dir.
  - After running `terraform init`, then you run the command `terraform apply -auto-approve`  in order to terraform to run the config in our terraform scripts.
  - Next step is to come out of the `terraform` dir, and then change directory into the `ansible` dir
  - within the ansible dir, you should add your service `account.json` file in the root of that `ansible` dir.
  - Next, export the  `export GOOGLE_APPLICATION_CREDENTIALS=/FULL/PATH/TO/ansible/account.json` into the current terminal environment.
  - Next, connect to your k8s cluster by using the connect option on your GKE cluster
  - next run the command `gcloud auth activate-service-account --key-file=./ansible/account.json` outside the `ansible` dir
  - Next, perform a cluster role binding operation from your cluster against that service account we are using with this command `kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $(gcloud config get-value account)`.
  - Next, run the command `ansible-playbook ./ansible/playbook.main.yaml -vvv` to run your ansible scripts.
  - Check the GKE dashboard to see your resources.
  - You can also use the command `kubectl get pods` and `kubectl get svc` to get information about your pods and services


**PS**: PLEASE never push your service `account.json` file to any remote version control platform, also your terraform state files i.e. the files with the `*.tfstate` in them are not to also be pushed to any version control system because these files contain information would be a security breach for your servers if the content of these files ae made public.

Aside from the state files, the `terraform.tfvars` file is also another file you don't want to make public because it contains sensitive values.
The only reason why I am pushing it to my repo is because this is a demo & I don't have any sensitive data in there.


