FROM ubuntu:16.04
VOLUME /code
WORKDIR /root
RUN apt-get update -yq
RUN apt-get dist-upgrade -yqq
RUN apt-get install -y git wget python python3 bash-completion libicu-dev build-essential python-dev python3-dev libglib2.0-0 tesseract-ocr tesseract-ocr-eng tesseract-ocr-spa tesseract-ocr-fra tesseract-ocr-deu tesseract-ocr-ita tesseract-ocr-por tesseract-ocr-ces tesseract-ocr-jpn xvfb android-tools-adb locales
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN pip install virtualenv
RUN virtualenv env
RUN git config --global http.sslverify false
