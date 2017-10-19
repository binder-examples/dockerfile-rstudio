FROM rocker/tidyverse:3.4.2

RUN apt-get update && \
    apt-get -y install python3-pip && \
    pip3 install --no-cache-dir \
         notebook==5.2 \
         git+https://github.com/jupyterhub/nbrsessionproxy.git@6eefeac11cbe82432d026f41a3341525a22d6a0b \
         git+https://github.com/jupyterhub/nbserverproxy.git@5508a182b2144d29824652d8977b32302517c8bc && \
    apt-get purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV NB_USER rstudio
ENV NB_UID 1000
ENV HOME /home/rstudio
WORKDIR ${HOME}

USER ${NB_USER}

# Set up R Kernel for Jupyter
RUN R --quiet -e "install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))"
RUN R --quiet -e "devtools::install_github('IRkernel/IRkernel')"
RUN R --quiet -e "IRkernel::installspec()"

RUN jupyter serverextension enable --user --py nbserverproxy
RUN jupyter serverextension enable --user --py nbrsessionproxy
RUN jupyter nbextension install    --user --py nbrsessionproxy
RUN jupyter nbextension enable     --user --py nbrsessionproxy

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID}:${NB_UID} ${HOME}
USER ${NB_USER}

# Run install.r if it exists
RUN if [ -f install.r ]; then R --quiet -f install.r; fi

ENV LD_LIBRARY_PATH /usr/local/lib/R/lib
