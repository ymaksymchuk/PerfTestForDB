FROM mysql:latest

ENV DATABASE_HOST=db
ENV DATABASE_USER=root
ENV DATABASE_PASSWORD=root
ENV DATABASE_NAME=jmeter_demo
ENV DATABASE_PORT=3306
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=jmeter_demo

EXPOSE 4444:4444

WORKDIR jmeter_agent

COPY ./initdb.sql /docker-entrypoint-initdb.d/
COPY ServerAgent ./ServerAgent
COPY jdk8u242jre ./jdk8u242jre
COPY run_jmeter_agent.sh .

CMD "sh run_jmeter_agent.sh"