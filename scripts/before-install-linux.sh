#!/usr/bin/env bash
set -euv

(
mkdir -p opam
OPAMINSTALLER="https://raw.github.com/ocaml/opam/master/shell/opam_installer.sh"
wget $OPAMINSTALLER -O - | sh -s $TRAVIS_BUILD_DIR/opam
) || exit 1

export PATH=$TRAVIS_BUILD_DIR/opam:$PATH
opam init --no-setup
opam switch 4.02.3
eval `opam config env`
opam install --yes camlp5 ocamlfind ppx_import cmdliner core_kernel sexplib ppx_sexp_conv

(
git clone https://github.com/coq/coq.git
cd coq
./configure -local
make -j2
make install
) || exit 1

(
git clone https://github.com/ejgallego/coq-serapi.git
cd coq-serapi
sed -i "s|/home/egallego/external/coq-git/|$TRAVIS_BUILD_DIR/coq/|g" myocamlbuild.ml
cat myocamlbuild.ml
make
) || exit 1

# Travis ships a stupid-old version of npm when you don't set nodejs language...
# This is supposed to help bring a not-so-terrible version
curl -s -o $HOME/.nvm/nvm.sh https://raw.githubusercontent.com/creationix/nvm/v0.31.0/nvm.sh
source $HOME/.nvm/nvm.sh
nvm install stable
