# Quick Start

To get up and running, install vagrant and then:

    vagrant box add precise64 http://files.vagrantup.com/precise64.box
    git clone https://github.com/farproc/CyanogenModBuildEnv.git
    cd CyanogenModBuildEnv
    vagrant up

This will create you a VM with all the required packages installed to build CyanogenMod for yourself.

I personally just follow the steps on http://wiki.cyanogenmod.org/ to build for my devices.

Another neat trick so save you faffing around with USB forwarding etc. is to run a ''adb'' server on your host and forward that (over TCP) though to the VM. Its actually pretty simple.

On the VM

    adb kill-server # make sure the server isn't already running

Then on the host

    adb devices # you should see your device
    ssh -nNR127.0.0.1:5037:127.0.0.1:5037 -oExitOnForwardFailure=yes -p 2222 -i ~/.vagrant.d/insecure_private_key -l vagrant localhost # tunnels the adb server into the VM

Now back on the VM you should beable to exec ''adb'' commands :D

