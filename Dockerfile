FROM ubuntu:16.04
VOLUME /code
WORKDIR /root
RUN apt-get update -yq && apt-get install -yqq software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get update -yqq && apt-get install -yqq python-dev wget git lib32stdc++6 libcups2-dev libsmbclient-dev python-distutils-extra libapt-pkg-dev python-apt libssl-dev gcc python3-dev nano net-tools oracle-java8-installer libffi-dev
RUN apt-get dist-upgrade -yqq
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install -U libusb1==1.5.3 numpy subprocess32 python-dateutil pyserial pexpect matplotlib python-debian psutil paramiko androidviewclient twisted pytesseract selenium pyusb jsonpath-rw
RUN wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN tar xzf android-sdk_r24.4.1-linux.tgz
