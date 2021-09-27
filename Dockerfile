FROM labshare/polus-bfio-util:2.0.6-tensorflow

COPY VERSION /

ARG EXEC_DIR="/opt/executables"

#Create folders
RUN mkdir -p ${EXEC_DIR}

#Copy executable
COPY src ${EXEC_DIR}/

RUN pip install --upgrade setuptools


# Install open JDK 8
RUN apt-get update && apt-get -y upgrade && \
    apt-get -y install openjdk-8-jdk

RUN apt-get update && \
    pip install --upgrade cython numpy deepcell

RUN pip install -r ${EXEC_DIR}/requirements.txt --no-cache-dir

# RUN apt-get update
RUN apt-get install -y software-properties-common && \
    apt-get install -y gnupg && \
    apt-get install -y wget && \
    apt install -y build-essential && \
    apt-get install -y doxygen libssl-dev git libgl1-mesa-glx build-essential libssl-dev libffi-dev python-dev


ENTRYPOINT [ "python3", "main.py" ]
