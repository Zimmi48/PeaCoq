#!/usr/bin/env bash
set -euv

branch="master"
commit="b90df37951d3782b958687c08352114192525beb"

if [ ! -d coq-serapi/.git ]; then
  git clone https://github.com/ejgallego/coq-serapi.git
fi
cd coq-serapi
git checkout myocamlbuild.ml # undo the effects of sed
git fetch origin $branch
git checkout $commit
# Holy shit, sed on OSX and on Linux are really hard to make work the same...
sed -i.bak "s|/home/egallego/external/coq-git/|$PWD/../coq/|g" myocamlbuild.ml
# Slower:
# make clean && COQBIN="../coq/bin" make
COQBIN="../coq/bin" make
