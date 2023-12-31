#!/bin/bash

_PLANTUML_VERSION=1.2023.11
_install_dir=~/.local/share/plantuml
mkdir -p $_install_dir
_plantuml_jar=plantuml-$_PLANTUML_VERSION.jar

if [ ! -f $_install_dir/$_plantuml_jar ]; then
    pushd $_install_dir
    curl -LO https://github.com/plantuml/plantuml/releases/download/v$_PLANTUML_VERSION/plantuml-$_PLANTUML_VERSION.jar
    popd
fi
