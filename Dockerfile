FROM ubuntu:16.04

RUN apt-get  update
RUN apt-get -y upgrade

RUN apt-get install -y -q python-all
RUN apt-get install -y -q python-pip
RUN apt-get install -y -q python-setuptools 
RUN apt-get install -y -q build-essential 
RUN apt-get install -y -q python-dev 
RUN apt-get install -y -q libevent-dev 
RUN apt-get install -y -q git
RUN pip install sphinx

COPY readthedocs.org src

WORKDIR src

RUN pip install -r requirements.txt
RUN ./manage.py migrate

# TODO Create the superuser in a non-interactive way.
# RUN DEBIAN_FRONTEND=noninteractive ./manage.py createsuperuser

EXPOSE 5000
CMD ["python", "manage.py", "runserver", "0.0.0.0:5000"]


