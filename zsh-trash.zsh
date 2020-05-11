#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install trash for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#

TRASH_PACKAGE_NAME='trash-cli'

function trash::validation {
    if ! type -p node > /dev/null; then
        message_warning "Is neccesary install node"
        return
    fi
    trash::dependences
}

function trash::install {
    message_info "Installing Trash"
    trash::validation
    yarn global add "${TRASH_PACKAGE_NAME}"
}

function trash::upgrade {
    message_info "upgrade Trash"
    yarn global upgrade "${TRASH_PACKAGE_NAME}"
}

function trash::dependences {
    if type -p yarn > /dev/null; then
        message_info "Installing yarn"
        curl -o- -L https://yarnpkg.com/install.sh | bash
    fi
}

function trash::load {
    if type -p trash > /dev/null; then
        alias rm='trash'
    fi
}

trash::load

if ! type -p trash > /dev/null; then
    trash::install
fi
