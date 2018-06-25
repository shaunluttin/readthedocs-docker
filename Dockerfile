FROM ubuntu:16.04

RUN apt-get update
RUN apt-get -y upgrade

RUN apt-get install -y apt-utils
RUN apt-get install -y python-all
RUN apt-get install -y python-pip
RUN apt-get install -y python-setuptools 
RUN apt-get install -y build-essential 
RUN apt-get install -y python-dev 
RUN apt-get install -y libevent-dev 
RUN apt-get install -y git
RUN pip install sphinx

COPY readthedocs.org readthedocs

WORKDIR readthedocs

RUN pip install -r requirements.txt
RUN ./manage.py migrate

# Configure SSH
ENV SSH_PASSWD "root:Docker!"
RUN apt-get update 
RUN apt-get install -y --no-install-recommends dialog 
RUN apt-get update 
RUN apt-get install -y --no-install-recommends openssh-server  
RUN echo "$SSH_PASSWD" | chpasswd

COPY sshd_config /etc/ssh/
COPY init.sh /usr/local/bin/

# Expose two ports, the latter is for SSH.
EXPOSE 5000 2222

# CMD ["python", "manage.py", "runserver", "0.0.0.0:5000"]
ENTRYPOINT ["init.ssh"]


