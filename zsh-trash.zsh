#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install trash for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#

LIGHT_GREEN='\033[1;32m'
CLEAR='\033[0m'

PACKAGE_NAME='trash-cli'
PACKAGE='trash'

function trash::validation {
    if [ ! -x "$(command which node)" ]; then
        echo -e "${CLEAR}${LIGHT_GREEN}is Neccesary Node${CLEAR}"
    else
        trash::dependences
    fi
}

function trash::install {
    echo -e "${CLEAR}${LIGHT_GREEN}Installing Trash${CLEAR}"
    trash::validation
    yarn global add ${PACKAGE_NAME}
}

function trash::upgrade {
    echo -e "${CLEAR}${LIGHT_GREEN}upgrade Trash${CLEAR}"
    yarn global upgrade ${PACKAGE_NAME}
}

function trash::dependences {
    if [ ! -x "$(command which yarn)" ]; then
        echo -e "${CLEAR}${LIGHT_GREEN}Installing yarn${CLEAR}"
        curl -o- -L https://yarnpkg.com/install.sh | bash
    fi
}

function trash::load {
    if [ -x "$(command which trash)" ]; then
        local package:="${PACKAGE}"
        alias rm='$package'
    fi
}

trash::load

if [ ! -x "$(command which trash)" ]; then
    trash::install
fi
