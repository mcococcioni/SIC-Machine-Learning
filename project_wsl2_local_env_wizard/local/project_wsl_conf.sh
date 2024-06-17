#!/bin/bash

echo "-----------------------------------"
echo "system general package updates"
echo "-----------------------------------"

cd
sudo apt update
sudo apt upgrade -y



echo "-----------------------------------"
echo "PIP INSTALLATION"
echo "-----------------------------------"

sudo apt install python3.10
python3 --version
sudo apt install python3-pip -y
pip3 --version


echo "-----------------------------------"
echo "CUDA TOOLKIT 12.1 INSTALLATION"
echo "-----------------------------------"

sudo apt-key del 7fa2af80

wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/12.1.1/local_installers/cuda-repo-wsl-ubuntu-12-1-local_12.1.1-1_amd64.deb
sudo dpkg -i cuda-repo-wsl-ubuntu-12-1-local_12.1.1-1_amd64.deb
sudo cp /var/cuda-repo-wsl-ubuntu-12-1-local/cuda-*-keyring.gpg /usr/share/keyrings/
sudo dpkg -i cuda-repo-wsl-ubuntu-12-1-local_12.1.1-1_amd64.deb
sudo apt-get update
sudo apt-get -y install cuda
cat <<'EOF' >> $HOME/.bashrc
export PATH=/usr/local/cuda/bin:$PATH
EOF
source ~/.bashrc
nvcc --version



echo "-----------------------------------"
echo "TENSORFLOW INSTALLATION"
echo "-----------------------------------"

python3 -m pip install tensorflow[and-cuda]
cat <<'EOF' >> $HOME/.bashrc
export CUDNN_PATH="$HOME/.local/lib/python3.10/site-packages/nvidia/cudnn"
export LD_LIBRARY_PATH="$CUDNN_PATH/lib":"/usr/local/cuda12.1/libnvvp"
export PATH="$PATH":"/usr/local/cuda12.1/bin"
EOF
source ~/.bashrc
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"

echo "correct GPU support if output is similar to: [PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]"




echo "-----------------------------------"
echo "PYTORCH INSTALLATION"
echo "-----------------------------------"

pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121



echo "-----------------------------------"
echo "JAX INSTALLATION"
echo "-----------------------------------"

pip install -U "jax[cuda12_pip]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html



echo "-----------------------------------"
echo "JUPYTER NOTEBOOK INSTALLATION"
echo "-----------------------------------"

sudo apt install jupyter-core -y
pip install --upgrade --force-reinstall --no-cache-dir jupyter
cat <<'EOF' >> $HOME/.bashrc
alias jupyter-notebook="~/.local/bin/jupyter-notebook --no-browser"
export PATH=$PATH:~/.local/bin
EOF
source ~/.bashrc

sudo reboot