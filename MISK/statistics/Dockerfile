FROM python:rc-alpine3.13
RUN apk add --no-cache bash
ADD print_statistics.sh /
RUN chmod +x /print_statistics.sh
ENTRYPOINT ["/bin/bash", "/print_statistics.sh"]
