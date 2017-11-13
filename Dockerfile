FROM rocker/binder:3.4.2

# Run install.r if it exists
RUN if [ -f install.R ]; then R --quiet -f install.R; fi

COPY . $HOME

