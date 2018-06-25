FROM ubuntu:16.04

RUN apt-get  update
RUN apt-get -y upgrade

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-all
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-pip
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-setuptools 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q build-essential 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q python-dev 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q libevent-dev 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q git
RUN DEBIAN_FRONTEND=noninteractive pip install sphinx

COPY readthedocs.org src

WORKDIR src

RUN DEBIAN_FRONTEND=noninteractive pip install -r requirements.txt
RUN DEBIAN_FRONTEND=noninteractive ./manage.py migrate
# RUN DEBIAN_FRONTEND=noninteractive ./manage.py createsuperuser
EXPOSE 5000
CMD ["python", "manage.py", "runserver", "0.0.0.0:5000"]


