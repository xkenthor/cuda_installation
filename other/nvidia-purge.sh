for version in $version 460 418 450
do
  LC_MESSAGES=C dpkg-divert --list "*nvidia-$version*" | sed -nre 's/^diversion of (.*) to .*/\1/p' | xargs -rd'\n' -n1 -- sudo dpkg-divert --remove
  sudo dpkg --force-all -P "nvidia-$version" nvidia-compute-utils-$version nvidia-dkms-$version nvidia-prime nvidia-settings nvidia-opencl-icd-$version nvidia-opencl-icd-384 nvidia-kernel-source-$version nvidia-kernel-common-$version libnvidia-cfg1-$version libnvidia-common-$version libnvidia-compute-$version libnvidia-decode-$version libnvidia-encode-$version  libnvidia-fbc1-$version libnvidia-ifr1-$version
done

sudo apt purge --autoremove '*nvidia*'
sudo apt-get update
sudo apt-get upgrade

sudo apt-get autoremove
sudo apt-get --fix-broken install
