
Using docker-compose:

mkdir /root/conf/jenkins
scp clientcert.jks root@elastic:/root/conf/jenkins/keystore.jks


  jenkins:
    image: jenkins:devopslatest
    container_name: jenkins
    volumes:
      - /root/conf/jenkins/keystore.jks:/var/jenkins_home/cert/keystore.jks
      - /root/data/jenkins_ci:/var/jenkins_home
    ports:
      - 8443:8443
    environment:
      - LDAP_SERVER=dc1.sofia.ifao.net
      - LDAP_ROOTDN=dc=sofia,dc=ifao,dc=net
      - LDAP_USER_SEARCH=(sAMAccountName={0})
      - LDAP_GROUP_SEARCH_FILTER=(sAMAccountName={0#})
      - LDAP_MANAGER_DN=ifao-bg\elastic_jenkins
      - LDAP_MANAGER_PASSWORD=*******
      - LDAP_DISABLE_MAIL_ADDRESS_RESOLVER=false
      - LDAP_INHIBIT_INFER_ROOTDN=false
      - LDAP_GROUP_MEMBERSHIP_STRATEGY=FromUserRecordLDAPGroupMembershipStrategy
      - JENKINS_OPTS=--httpPort=-1 --httpsPort=8443 --httpsKeyStore=/var/jenkins_home/cert/keystore.jks --httpsKeyStorePassword=******
    networks:
      esnet:
        ipv4_address: 172.30.0.47



Using/testing directly through docker container:

docker stop jen
docker volume remove jenkins_home
docker volume create jenkins_home
docker build --no-cache -t jenkins:devopslatest .
docker run --rm -d --env-file environment_file  --name jen -v jenkins_home:/var/jenkins_home -p 8443:8443 jenkins:devopslatest
