FROM  kubeflownotebookswg/jupyter-scipy:v1.6.0

COPY Trustdb/* /etc/apt/trusted.gpg.d/
COPY sources.list /etc/apt

USER root
RUN apt-get update -y
RUN apt-get install python3=3.11.2-1+b1 -y

RUN pip install ray[all]
RUN pip install -U ipywidgets

# needed by ray
RUN apt-get install gcc g++ -y
RUN apt-get install python3-pip -y
RUN apt-get install python3.11-venv -y
RUN apt-get install pkg-config -y
RUN apt-get install jq -y
RUN apt-get install openssh-server -y

# installing Ray
RUN python3 -m venv $HOME/ray
RUN . $HOME/ray/bin/activate && pip install -U "ray[default]"

