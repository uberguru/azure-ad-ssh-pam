# aad-login

Allows Linux user authentication to Azure AD via pam_exec
Origal from: https://github.com/bureado/aad-login  <-- props to you :)

Changed the module a bit as the current setup did not work for me... issues with authentication
Also added an install script to make life a bit easier, cheers

PS only tested on ubuntu 14.04


## Prerequisites

* An Azure AD directory has been created, and some users exist
* A directory application has been created (native client type) and you have the Client ID
* Your PAM distribution has pam_exec.so


## Installing


./install.sh [NAME of YOUR AZURE ACTIVE DIRECTORY] [APP CLIENT ID]
