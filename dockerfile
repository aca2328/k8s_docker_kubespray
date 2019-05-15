FROM ubuntu:18.04
ENV ANSIBLE_FORCE_COLOR True

RUN echo $HOME

RUN apt-get update && apt-get install -y \
    curl \
    vim \
    git \
    inetutils-ping \
    iproute2 \
    python-pip \
    python3-pip
RUN echo "-------"
RUN git clone https://github.com/kubernetes-sigs/kubespray.git
WORKDIR kubespray
RUN pip install -r requirements.txt
RUN pip install boto3
RUN pip3 install ruamel.yaml
RUN cp -rfp inventory/sample inventory/k8s1
COPY get_aws_facts.yaml get_aws_facts.yaml
COPY get_aws_vars.yml get_aws_vars.yml
COPY get_aws_keys.yml get_aws_keys.yml
RUN ansible-playbook get_aws_facts.yaml
RUN ["/bin/bash", "-c", "CONFIG_FILE=inventory/k8s1/hosts.yaml python3 contrib/inventory_builder/inventory.py $(< get_aws_facts.output)"]
COPY id_rsa_priv key.priv
RUN chmod 600 key.priv
ENTRYPOINT ["/bin/bash"]
