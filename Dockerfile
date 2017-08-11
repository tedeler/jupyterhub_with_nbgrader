FROM python:3-stretch

MAINTAINER ted <ted@ted.de>

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt install nodejs
RUN npm install -g configurable-http-proxy

RUN pip install notebook
RUN pip install jupyterhub==0.7.2
RUN pip install nbgrader

RUN mkdir /home/john
RUN useradd john -b /home
RUN chown john /home/john

RUN jupyter nbextension install --sys-prefix --py nbgrader --overwrite
RUN jupyter nbextension enable --sys-prefix --py nbgrader
RUN jupyter serverextension enable --sys-prefix --py nbgrader
RUN pip install jupyterhub-dummyauthenticator

ADD jupyterhub_config.py jupyterhub_config.py
ADD nbgrader_config.py /etc/jupyter/nbgrader_config.py

RUN mkdir /srv/nbgrader
RUN mkdir /srv/nbgrader/exchange
RUN chmod ugo+rw /srv/nbgrader/exchange

EXPOSE 8000
