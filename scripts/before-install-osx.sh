#!/usr/bin/env bash
set -euv

PKGMGR="brew"

$PKGMGR update

# Haskell server
$PKGMGR install cabal-install ghc
#export PATH=/opt/ghc/$GHCVER/bin:/opt/cabal/$CABALVER/bin:$PATH
cabal update
cabal install alex happy
#export PATH=/opt/alex/$ALEXVER/bin:/opt/happy/$HAPPYVER/bin:$PATH

# Coq and OCaml plugin
$PKGMGR install coq ocaml camlp5

# Frontend
$PKGMGR install node