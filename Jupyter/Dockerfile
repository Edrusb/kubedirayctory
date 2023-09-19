FROM debian:bookworm
LABEL author=doc.heure@edrusb.org
LABEL image=edrusb/jupyteraycluster

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
RUN python3 -m venv /opt/ray
RUN . /opt/ray/bin/activate && pip install -U "ray[all]"

# installing Jupyterlab
RUN . /opt/ray/bin/activate && pip install jupyterlab

# non root user setup
RUN groupadd lab
RUN useradd -g lab -c "jupyter lab user" -u 1000 -m jovyan
RUN chsh jovyan -s /bin/bash

# allowing members of group lab to install anything in the venv "ray"
RUN find /opt/ray -type d -exec chmod g+w {} \;
RUN chgrp -R lab /opt/ray

# getting ready to run jupyterlab
COPY action /root/action
RUN chmod a+x /root/action

EXPOSE 8888

CMD [ "/root/action" ]
