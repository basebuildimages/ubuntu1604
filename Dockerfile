FROM ubuntu:16.04
VOLUME /code
WORKDIR /root
RUN apt-get update -yq && apt-get install -yqq software-properties-common
RUN add-apt-repository ppa:webupd8team/java
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get update -yqq && apt-get install -yqq python-dev wget git lib32stdc++6 libcups2-dev libsmbclient-dev python-distutils-extra libapt-pkg-dev python-apt libssl-dev gcc python3-dev nano net-tools oracle-java8-installer libffi-dev  libswt-gtk-3-jni libswt-gtk-3-java ant unzip acl tesseract-ocr libtesseract-dev libleptonica-dev
RUN apt-get dist-upgrade -yqq
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py
RUN pip install -U libusb1==1.5.3 numpy subprocess32 python-dateutil pyserial pexpect matplotlib python-debian psutil paramiko androidviewclient twisted pytesseract selenium pyusb jsonpath-rw
RUN wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN tar xzf android-sdk_r24.4.1-linux.tgz
RUN /root/android-sdk-linux/tools/android list sdk|egrep 'SDK Tools|SDK Build-tools|SDK Platform-tools|Android 5.0.1, API 21'|awk -F- '{print $1 ","}'|sed -e ':a' -e 'N' -e '$!ba' -e 's/[\n ]//g' > /root/and_in
RUN (while sleep 3; do echo "y"; done) | /root/android-sdk-linux/tools/android update sdk -s --no-ui --filter `cat /root/and_in`
RUN rm /root/and_in
RUN rm /root/android-sdk_r24.4.1-linux.tgz
RUN echo export ANDROID_HOME=/root/android-sdk-linux >> /root/.bashrc
RUN echo export PATH=/root/android-sdk-linux/tools:/root/android-sdk-linux/platform-tools:/root/android-sdk-linux/build-tools:$HOME/.local/bin:\$PATH >> /root/.bashrc
RUN echo 'alias initp="touch __init__.py"' >> /root/.bash_aliases
RUN echo 'alias proxy="export http_proxy=http://127.0.0.1:8080;export https_proxy=http://127.0.0.1:8080"' >> /root/.bash_aliases
RUN echo 'alias dproxy="unset http_proxy;unset https_proxy"' >> /root/.bash_aliases
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
WORKDIR /root/android-sdk-linux
RUN test -n "$(ls /root/android-sdk-linux/tools)" || unzip /root/android-sdk-linux/temp/tools*.zip 2>&1 > /dev/null
