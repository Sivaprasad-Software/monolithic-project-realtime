# web-devlopent-code
In this project using git + github + terraform + ansible + jenkins tools we use automate the deployment in prod swerver
launch instance and add that instace to IAM role admin-role ==> go to actions  ==> security ==> Edit IAM role ==> add the created IAM role
first of all clone the repo into your server[
and then install the terraform in our server am using amazon-linux-AMI
        [sudo yum install -y yum-utils shadow-utils
          sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
           sudo yum -y install terraform]
and then install ansible in our server
 ansible dependies you install using this command [ sudo yum install python python-devel python-pip -y && sudo pip install boto --use-feature=2020-resolver ]
 and then make configurations in [sudo vi /etc/ansible/ansible.cfg]
                        in this file we set inventory path [ inventory     = /opt/ansible/inventory/aws_ec2.yml] under this 
                                                           [ host_key_checking = False] and then go to  330 line
                                                            [enable_plugin  = aws_ec2] you write this
  and then you need to create a pem.key in /etc/ansible/ this path 
  and then you create a inventory path cd /opt/
                                     sudo mkdir ansible && cd ansible
                                     sudo mkdir inventory && cd inventory
                                     sudo vi aws_ec2.yml and writev this 
                                                        [---
                                                         plugin: aws_ec2
                                                         regions:
                                                           - eu-west-2 (in which region you want you mention that)
                                                         filter:
                                                           tag:Environment: "prod"]
  and istall jenkins dependency java-11 first [ sudo amazon-linux-extras install java-openjdk11 -y] and install jenkins i dont write jenkins commands you can go jenkins.io wesite]
  and you change or provide your IAM user Acess key and Secret key it will work only to create one instance and after you create one more user and give that credentials
  and you create a job in jenkins
      click on freestyle
      click on this project is parameterised ==> choice meter ==> Name= action ==> Choices = apply , destroy
      in that git we give your github url
      and after in build steps choose execute shell
        in execute shell write this 
        [ sleep 10s
          cd terraform
          terraform validate
          terraform init
          terraform plan
          terraform $action --auto-approve
          sleep 20s
          if [ action == "destroy" ]; then
               exit 0;
          else
               cd ../ansible
               ansible-playbook -i /opt/ansible/inventory/aws_ec2.yml deployment.yml
          fi
          
          
          this fine click save and build it your application can run on  terraform created instance public-ip:80.
