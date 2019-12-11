# Sample Dockerfile

# Indicates that the windowsservercore image will be used as the base image.
# https://hub.docker.com/_/microsoft-windows-servercore
# Install Windows Images file (4.81GB)
# FROM mcr.microsoft.com/windows/servercore:ltsc2019
FROM mcr.microsoft.com/windows/servercore:ltsc2019-amd64

# Install .NetFramework v4.8 (size 7.55GB)
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8
FROM mcr.microsoft.com/dotnet/core/sdk:2.1
FROM mcr.microsoft.com/dotnet/core/runtime:2.1

# Install Python
FROM python:3.7.5

# AWS CLI Settings
ARG pip_installer="https://bootstrap.pypa.io/get-pip.py"
# RUN wget https://bootstrap.pypa.io/get-pip.py
# RUN python get-pip.py
# ARG awscli_version="1.16.76"

# Upgrade pip
RUN pip install --upgrade pip

# Install awscli
# RUN pip install --user awscli==${awscli_version}
RUN pip3 install --user --upgrade awscli

# Install sam
# RUN pip install --user aws-sam-cli

# Metadata indicating an image maintainer.
LABEL maintainer="susu-susu@github.com"

# Uses dism.exe to install the IIS role.
RUN dism.exe /online /enable-feature /all /featurename:iis-webserver /NoRestart

# AWS CLI PATH Settings
ENV PATH $PATH:C:/Program Files/Amazon/AWSCLI/bin

RUN powershell -Command Add-WindowsFeature Web-Server
# SHELL ["powershell", "-command"]

# Sets a command or process that will run each time a container is run from the new image.
CMD [ "cmd" ]

