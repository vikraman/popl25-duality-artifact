# Artifact for The Duality of Abstraction

[![docker](https://github.com/vikraman/popl25-duality-artifact/actions/workflows/docker.yml/badge.svg)](https://hub.docker.com/r/vikraman/popl25-duality-artifact)
[![docker pulls](https://img.shields.io/docker/pulls/vikraman/popl25-duality-artifact.svg)](https://hub.docker.com/r/vikraman/popl25-duality-artifact)
[![doi](https://zenodo.org/badge/R_kgDONAhn-A.svg)](https://zenodo.org/badge/latestdoi/R_kgDONAhn-A)

This repository contains accompanying formalisation for the paper "The Duality of Abstraction". (the title is not finalised yet)

- Main Repository: https://github.com/vikraman/popl25-duality-artifact
- Zenodo: pending

The artifact provides:

- hs-coexp: a Haskell library for coexponentials using the Cont monad
- sml-coexp: an SML library for coexpoentials using native continuations
- descartes: an OCaml interpreter for λλ̃ which implements the operational semantics
- agda-coexp: an Agda formalisation of the λλ̃, κ/ζ, κ̃/ζ̃ calculi, and their semantics

## Installation

This repository includes submodules linking to the repository for each artifact, so it needs to be cloned recursively.

### Option 1: Native installation

Each part of the artifact is packaged using the standard packaging mechanism for the corresponding language ecosystem.

- Haskell, using [cabal](https://www.haskell.org/cabal/)
- SML/NJ, using official packages:
  - Ubuntu: `apt install smlnj`
  - MacOS:  `brew install --cask smlnj`
  - Windows: using the official installer https://smlnj.org/dist/working/110.96/smlnj-110.96.msi
- OCaml, using [opam](https://ocaml.org/install) and [dune](https://dune.build/install)
- Agda and agda-stdlib: https://agda.readthedocs.io/en/v2.7.0.1/getting-started/installation.html

The repositories are also continuously built and checked using the GitHub Actions CI.

### Option 2: Using our docker image

We also provide a prebuilt docker image with everything installed.
The image is built for the linux/amd64 platform, but will also run on an M1 Mac with Rosetta.

```sh
$ docker pull vikraman/popl25-duality-artifact
$ docker run -it --rm vikraman/popl25-duality-artifact
```

## Evaluation

See the README files in each submodule.
