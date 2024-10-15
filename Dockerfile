FROM --platform=linux/amd64 haskell:9.10-bullseye
LABEL authors="Vikraman Choudhury"

RUN cabal update && \
    cabal install Agda-2.7.0.1
RUN curl -sSL -o agda-stdlib.tar.gz https://github.com/agda/agda-stdlib/archive/v2.1.1.tar.gz && \
    mkdir -p /root/agda-stdlib && \
    tar -xzvf agda-stdlib.tar.gz -C /root/agda-stdlib --strip-components 1 && \
    cd /root/agda-stdlib && \
    cabal install

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y rlwrap smlnj ocaml-nox opam dune emacs-nox

COPY vendor/dot-emacs /root/.emacs
COPY vendor/agda-libraries /root/.agda/libraries
COPY vendor/agda-defaults /root/.agda/defaults

VOLUME   /artifact/
COPY   . /artifact/
WORKDIR  /artifact/

ENTRYPOINT [ "bash" ]
