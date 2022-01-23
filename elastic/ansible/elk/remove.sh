systemctl stop elasticsearch.service
systemctl stop kibana.service
systemctl stop logstash.service
systemctl disable elasticsearch.service
systemctl disable kibana.service
systemctl disable logstash.service
systemctl daemon-reload

rm -fr /etc/yum.repos.d/elastic.repo
yum erase elasticsearch kibana logstash bind-utils java-1.8.0-openjdk -y
