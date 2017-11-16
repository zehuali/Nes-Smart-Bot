# Install torch 7

## Update ubuntu package list

    sudo apt-get update

## install git and fceux

    sudo apt-get install git fceux

## install torch

    git clone https://github.com/torch/distro.git ~/torch --recursive
    cd ~/torch; sudo bash install-deps;
    ./install.sh

## install DeepQNetwork

    git clone https://github.com/ehrenbrav/DeepQNetwork.git
    cd DeepQNetwork/
    ./install_dependencies.sh
    cp ./torch/* ~/torch/install/

## Run train model
Before run the game, we have to download the rom to ~/DeepQNetwork/roms/

    ./train_cpu <game-name>