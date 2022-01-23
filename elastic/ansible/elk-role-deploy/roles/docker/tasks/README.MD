
Configure environment variables for this playbook:
GIT_USER=""
GIT_PASS=""

Execute playbook:
ansible-playbook elk-role-deploy/elastic-docker.yml -i inventory.txt -e "GIT_USER=$GIT_USER GIT_PASSWORD=$GIT_PASS" -kK

Note: This script should be executed only against "root" user. Entire deployment is made to work from root user only.
