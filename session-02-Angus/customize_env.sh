#!/bin/bash

cat >> /root/.profile <<HEREDOC

function exit() {
    echo "Please don't exit the root Katacoda session, you'll lose all your work"
}

HEREDOC