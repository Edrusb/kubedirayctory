FROM debian:bookworm
LABEL author=doc.heure@edrusb.org
LABEL image=edrusb/ray

ENV RAY_PORT=6379
ENV RAY_OBJECT_MANAGER_PORT=8301
ENV RAY_NODE_MANAGER_PORT=8302
ENV RAY_MIN_WORKER_PORT=8400
ENV RAY_MAX_WORKER_PORT=8499
ENV RAY_CLIENT_SERVER_PORT=10001
ENV RAY_DASHBOARD_PORT=8265
ENV RAY_DASHBOARD_AGENT_LISTEN_PORT=8303
ENV RAY_DASHBOARD_GRPC_PORT=8304
ENV RAY_METRICS_EXPORT_PORT=8305

# OS update
RUN apt-get update -y
RUN apt-get upgrade -y

# needed by me to troubleshoot
RUN apt-get install emacs-nox -y
RUN apt-get install less -y
RUN apt-get install lsb-release -y

# needed by ray
RUN apt-get install gcc g++ -y
RUN apt-get install python3-pip -y
RUN apt-get install python3.11-venv -y
RUN apt-get install pkg-config -y
RUN apt-get install jq -y
RUN apt-get install openssh-server -y

# installing Ray
RUN python3 -m venv $HOME/ray
RUN . $HOME/ray/bin/activate && pip install -U "ray[all]"

## needed by kubedirector: curl python (2 or 3) tar rsync and bash
RUN apt-get install curl -y
RUN apt-get install tar -y
RUN apt-get install rsync -y
RUN apt-get install bash -y
RUN cd /usr/bin && ln -s python3 python

# the "action" script launches sshd daemon which makes the container to persist
COPY action /root
RUN chmod 0750 /root/action
RUN chmod 0750 /root
RUN ssh-keygen -b 2048 -f /root/.ssh/id_rsa -t rsa -N ""
# the following brings password-less ssh between all Ray pods (heads and workers)
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# the "startscript" analyses the cluster conf and launches ray either as head or worker
RUN mkdir /root/appconfig
COPY startscript /root/appconfig
COPY background /root/appconfig
RUN chmod 0755 /root/appconfig/startscript
RUN chmod 0755 /root/appconfig/background
RUN tar -C /root -czf /root/appconfig.tgz appconfig
RUN rm -rf /root/appconfig

# installing scikit-learn
RUN . $HOME/ray/bin/activate && pip install -U scikit-learn

EXPOSE "$HEAD_PORT"
EXPOSE "$RAY_OBJECT_MANAGER_PORT"
EXPOSE "$RAY_NODE_MANAGER_PORT"
EXPOSE "$RAY_MIN_WORKER_PORT"
EXPOSE "$RAY_MAX_WORKER_PORT"
EXPOSE "$RAY_CLIENT_SERVER_PORT"
EXPOSE "$RAY_DASHBOARD_PORT"
EXPOSE "$RAY_DASHBOARD_AGENT_LISTEN_PORT"
EXPOSE "$RAY_DASHBOARD_GRPC_PORT"
EXPOSE "$RAY_METRIC_EXPORT_PORT"
EXPOSE 22

CMD [ "/root/action" ]
