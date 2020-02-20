FROM sonarsource/sonar-scanner-cli
LABEL version="0.0.1"
LABEL repository="https://github.com:PRstoneth/sonar-scanner-action"
LABEL homepage="https://github.com/PRstoneth/sonar-scanner-action"
LABEL maintainer="Thurston Stone <thurston.stone@pestroutes.com>"
USER root
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod a+x /usr/bin/entrypoint.sh
