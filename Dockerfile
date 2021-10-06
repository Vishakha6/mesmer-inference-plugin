# Get Linux
FROM tensorflow/tensorflow:2.5.1-gpu

# Polus platform file extension
ENV POLUS_EXT=".ome.tif"

# Container log level
ENV POLUS_LOG="INFO"

# Data and code directories
ENV EXEC_DIR="/opt/executables"
ENV DATA_DIR="/data"

RUN mkdir ${EXEC_DIR} && \
    mkdir ${DATA_DIR}}

RUN pip3 install --upgrade pip --no-cache-dir

# Install bfio and requirements
RUN pip3 install bfio[all]==2.1.9 --no-cache-dir --no-dependencies && \
    rm -rf /usr/local/lib/python3.6/site-packages/bfio/jars

COPY VERSION ${EXEC_DIR}
COPY src ${EXEC_DIR}/


RUN apt-get install -y libgl1-mesa-glx

RUN pip3 install -r ${EXEC_DIR}/requirements.txt --no-cache-dir
    
WORKDIR ${EXEC_DIR}

# Default command. Additional arguments are provided through the command line
ENTRYPOINT ["python3", "main.py"]
