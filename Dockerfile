FROM --platform=linux/amd64 haskell:9.10-bullseye
LABEL authors="Vikraman Choudhury"

# Install Agda and agda-stdlib
RUN cabal update && \
    cabal install Agda-2.7.0.1
RUN curl -sSL -o /root/agda-stdlib.tar.gz https://github.com/agda/agda-stdlib/archive/v2.1.1.tar.gz && \
    mkdir -p /root/agda-stdlib && \
    tar -xzvf /root/agda-stdlib.tar.gz -C /root/agda-stdlib --strip-components 1 && \
    cd /root/agda-stdlib && \
    cabal install

# Install SML/NJ
RUN curl -sSL -o /root/smlnj.tar.gz https://smlnj.org/dist/working/110.99.6/config.tgz && \
    mkdir -p /root/smlnj && \
    tar -xzvf /root/smlnj.tar.gz -C /root/smlnj && \
    cd /root/smlnj && \
    config/install.sh -default 64
ENV PATH="/root/smlnj/bin:${PATH}"

# Install OCaml, Dune, and tools
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && \
    apt install -y ocaml-nox opam dune rlwrap emacs-nox

# Copy configuration files
COPY vendor/dot-emacs /root/.emacs
COPY vendor/agda-libraries /root/.agda/libraries
COPY vendor/agda-defaults /root/.agda/defaults

# Copy artifacts
VOLUME   /artifact/
COPY   . /artifact/
WORKDIR  /artifact/

# Build each artifact
RUN cd agda-coexp && \
    agda index.agda
RUN cd hs-coexp && \
    cabal build && \
    cabal test
RUN cd sml-coexp && \
    echo 'CM.make "coexp.cm";' | sml
RUN cd descartes && \
    opam init --disable-sandboxing --auto-setup && \
    opam install . --deps-only --with-test --yes && \
    opam exec -- dune build && \
    opam exec -- dune runtest

ENTRYPOINT [ "bash" ]
