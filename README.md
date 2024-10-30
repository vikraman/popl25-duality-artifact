# Artifact for The Duality of $\lambda$ Abstraction

[![docker](https://github.com/vikraman/popl25-duality-artifact/actions/workflows/docker.yml/badge.svg)](https://github.com/vikraman/popl25-duality-artifact/actions/workflows/docker.yml)
[![docker pulls](https://img.shields.io/docker/pulls/vikraman/popl25-duality-artifact.svg)](https://hub.docker.com/r/vikraman/popl25-duality-artifact)
[![doi](https://zenodo.org/badge/DOI/10.5281/zenodo.13939451.svg)](https://doi.org/10.5281/zenodo.13939451)

This repository contains accompanying formalisation for the paper: The Duality of $\lambda$ Abstraction.

- Main Repository: https://github.com/vikraman/popl25-duality-artifact
- Zenodo: https://doi.org/10.5281/zenodo.13939451

The artifact provides:

- [hs-coexp](https://github.com/vikraman/hs-coexp): a Haskell library for coexponentials using the Cont monad
- [sml-coexp](https://github.com/vikraman/sml-coexp): an SML library for coexpoentials using native continuations
- [descartes](https://github.com/vikraman/descartes): an OCaml interpreter for λλ̃ which implements the operational semantics
- [agda-coexp](https://github.com/vikraman/agda-coexp): an Agda formalisation of the λλ̃, κ/ζ, κ̃/ζ̃ calculi, and their semantics

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

At the time of writing, the artifact has been tested with:

- GHC 9.10.1 and cabal 3.12.1.0
- SML/NJ 110.99.6.1
- OCaml 5.12.0 and dune 3.16.0
- Agda 2.7.0.1 and agda-stdlib 2.1.1

### Option 2: Using our docker image

We also provide a prebuilt docker image with everything installed.
The image is built for the linux/amd64 platform, but will also run on an M1 Mac with Rosetta.

```sh
$ docker pull vikraman/popl25-duality-artifact
$ docker run -it --rm vikraman/popl25-duality-artifact
```

## Evaluation

For specific instructions for each part of the artifact, see the README files in each submodule.

The mapping between the sections of the paper and the Agda formalisation is as follows.

#### Section 2

The syntax of the λλ̃ calculus is formalised in the `Coexp.LamLamBar.Syntax` module.

| Claim     | Formalisation |
| --------- | ------------- |
| Theorem 1 | `wk-tm`       |
|           | `sub-tm`      |

#### Section 3

The categorical structure used in the semantics is defined in the `Coexp.Semantics` module,
using Agda's `Set` as the semantic domain,
and using a fixed result type `R` as a module parameter to get a continuation monad.
These categorical combinators are used in the interpretation in the `Coexp.LamLamBar.Interp` module.

| Claim     | Formalisation      |
| --------- | ------------------ |
| Figure 3  | `evalTm`           |
| Figure 4  | `interpTy`         |
|           | `interpCtx`        |
| Figure 5  | `interpTm`         |
| Figure 6  | `interpIn`         |
|           | `interpWk`         |
| Figure 7  | `interpVal`        |
|           | `interpSub`        |
| Theorem 8 | `interpVal-tm-coh` |
|           | `interpWk-tm-coh`  |
|           | `interpSub-tm-coh` |
| Theorem 9 | `adequacy`         |

#### Section 4

The equational theory is formalised as part of the syntax in the `Coexp.LamLamBar.Syntax` module.
Some evaluation contexts and equations are skipped in the formalisation.

| Claim      | Formalisation |
| ---------- | ------------- |
| Theorem 11 | `interpEq`    |

Note that the theorem in the paper holds for the axiomatic categorical structure,
but the formalisation works directly in Agda's type theory,
hence skipping some tedious coherences which become `refl` in the Agda formalisation.

#### Section 5

The paper develops the syntax of κ/ζ, κ̃/ζ̃ calculi categorically,
and the formalisation implements it concretely, in the respective `Syntax` modules.
Additionally, an intepretation of each calculus is given in the `Interp` modules,
using the categorical structure of the semantics previously defined.

| Claim     | Formalisation           |
| --------- | ----------------------- |
| Figure 10 | `Coexp.Kappa.Syntax`    |
|           | `Coexp.Zeta.Syntax`     |
| Figure 11 | `Coexp.KappaBar.Syntax` |
|           | `Coexp.ZetaBar.Syntax`  |

#### Section 6

The examples are implemented in the SML artifact.

| Claim                     | Implementation                      |
| ------------------------- | ----------------------------------- |
| Functions and Cofunctions | `Examples.ex1`                      |
| Exceptional cofunctions   | `Examples.mult0` - `Examples.mult5` |
| Algebra of cofunctions    | `Classical`                         |
| Implementaion in SML      | `Coexp`                             |

The Haskell implementation is in the Haskell artifact.
Note that the type of `curry`/`uncurry` is swapped in Haskell's prelude,
hence some of the type signatures of the combinators are swapped compared to the paper.

| Claim                     | Implementation               |
| ------------------------- | ---------------------------- |
| Implementation in Haskell | `Data.Coexp`                 |
|                           | `Control.Monad.Control`      |
| Backtracking combinators  | `Data.Coexp.Backtrack`       |
| SAT Solver                | `Examples.SAT.Backtrack`     |
|                           | `Examples.SAT.Guess`         |
| Tree search               | `Examples.TS`                |
| Effect handlers           | `Control.Monad.Free.Control` |
|                           | `Examples.Eff.Toss`          |

The typechecker and interpreter for λλ̃ is implemented in the OCaml artifact.
