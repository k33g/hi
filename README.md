#Hi

    .__    .__                       ._.
    |  |__ |__|   _____ _____    ____| |
    |  |  \|  |  /     \\__  \  /    \ |
    |   Y  \  | |  Y Y  \/ __ \|   |  \|
    |___|  /__| |__|_|  (____  /___|  /_
         \/           \/     \/     \/\/
    HI Generator (c) 2014-2015 @k33g_org

**Hi** is like **Yeoman**, it's an application and code generator.

Generators are located to `generators` directory. **Hi** is provided with 2 samples generators :

- **emapp** : it generates an express application and load dependencies (mongoose, bootstrap, jquery, underscore, backbone). **Warn**: you have to install **npm** and **bower** before.
- **test** : it generates a sample of Backbone model

To run **emapp** :

    mkdir myapp
    cd myapp
    hi emapp

To run **test** :

    mkdir myapp
    cd myapp
    hi test

##Install Hi

###Linux

    # 1- clone hi repository in a directory
    git clone https://github.com/k33g/hi.git

    # 2- edit .bashrc
    pico ~/.bashrc

    # 3- Then :
    export PATH=$PATH:$HOME/directory/hi

###OSX

    # 1- clone hi repository in a directory
    git clone https://github.com/k33g/hi.git

    # 2- edit .bash_profile
    sudo pico ~/.bash_profile

    # 3- Then :
    HI_HOME=/directory/hi
    export HI_HOME
    export PATH=$PATH:$HI_HOME

###Windows

  Set System Variables in Configuration Panel.

##Write, install and publish hi-generators

    hi newgen

**W.I.P.**

