FROM debian:bullseye
LABEL author=doc.heure@edrusb.org
LABEL image=edrusb/jupyteray

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
RUN apt-get install python3.9-venv -y
RUN apt-get install pkg-config -y
RUN apt-get install jq -y
RUN apt-get install openssh-server -y

## needed by kubedirector: curl python (2 or 3) tar rsync and bash
RUN apt-get install curl -y
RUN apt-get install tar -y
RUN apt-get install rsync -y
RUN apt-get install bash -y
RUN cd /usr/bin && ln -s python3 python

# jupyter is replaced by ssh for pod start as authkey is known later
RUN apt-get install openssh-server -y
RUN apt-get install expect -y

# installing Ray Virtual Environment
RUN python3 -m venv /opt/ray
RUN chgrp -R lab /opt/ray
RUN find /opt/ray -type d -exec chmod g+w {} \;

# non root user setup
RUN groupadd lab
RUN useradd -g lab -c "jupyter lab user" -u 1000 -M jovyan
RUN mkdir /home/jovyan && chown jovyan:lab /home/jovyan
RUN chsh jovyan -s /bin/bash
COPY ray-demo.ipynb /home/jovyan
RUN chown jovyan:lab /home/jovyan/ray-demo.ipynb

#### END OF OS SYSTEM INSTALLS

USER jovyan:lab

###################################

RUN . /opt/ray/bin/activate && pip install -U "ray[all]"
RUN . /opt/ray/bin/activate && pip install -U ipywidgets
RUN . /opt/ray/bin/activate && pip install jq

# installing Jupyterlab
ENV JUPYTER_ENABLE_LAB yes
RUN . /opt/ray/bin/activate && pip install jupyterlab

COPY jupypass /opt/ray/bin
RUN chmod 0755 /opt/ray/bin/jupypass

# installing scikit-learn
RUN . /opt/ray/bin/activate && pip install numpy scipy modin
RUN . /opt/ray/bin/activate && pip install matplotlib pandas seaborn
RUN . /opt/ray/bin/activate && pip install -U scikit-learn scikit-image
RUN . /opt/ray/bin/activate && pip install torch transformers

###################################

USER root

# the "startscript" analyses the cluster conf and launches ray either as head or worker
RUN mkdir /root/appconfig
COPY startscript /root/appconfig
RUN chmod 0755 /root/appconfig/startscript
RUN tar -C /root -czf /root/appconfig.tgz appconfig
RUN rm -rf /root/appconfig

# getting ready to run jupyterlab
COPY action /root/action
RUN chmod a+x /root/action

EXPOSE 8888
EXPOSE 8265
EXPOSE 8000
EXPOSE 22

CMD [ "/root/action" ]
