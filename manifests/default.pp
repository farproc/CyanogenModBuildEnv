
class prep-android-build {
    Exec {
        path => [
            '/usr/local/bin',
            '/opt/local/bin',
            '/usr/bin', 
            '/usr/sbin', 
            '/bin',
            '/sbin',
            '/root/bin' ],
        logoutput => false,
    }

    exec { "apt-get update":
	command => "/usr/bin/apt-get update",
    }

    Package {
        ensure => present,
        require => Exec['apt-get update'],
    }

    package { "build-essential": }
    package { "git-core": }
    package { "curl": }
    package { "gnupg": }
    package { "flex": }
    package { "bison": }
    package { "gperf": }
    package { "libsdl1.2-dev": }
    package { "libesd0-dev": }
    package { "libwxgtk2.8-dev": }
    package { "squashfs-tools": }
    package { "zip": }
    package { "libncurses5-dev": }
    package { "zlib1g-dev": }
    package { "openjdk-6-jre": }
    package { "openjdk-6-jdk": }
    package { "pngcrush": }
    package { "schedtool": }
    package { "libxml2": }
    package { "xsltproc": }
    package { "g++-multilib": }
    package { "lib32z1-dev": }
    package { "lib32ncurses5-dev": }
    package { "lib32readline-gplv2-dev": }
    package { "gcc-4.6-multilib": } # would ideally like 4.7
    package { "g++-4.5-multilib": }
    package { "libxml2-utils": }

    exec { 'install repo':
        command => 'mkdir -p /root/bin && curl https://dl-ssl.google.com/dl/googlesource/git-repo/repo > /root/bin/repo && chmod u+x /root/bin/repo',
        creates => '/root/bin/repo',
        require => [ Package['curl'], Package['git-core'] ],
    }

    file { "/root/.gitconfig" :
        source => "/vagrant/gitconfig",
        owner => 'root',
        group => 'root',
    }

    # android SDK (only really needed if you're 'extracting' the proprietary blobs directly from the device
    exec { 'download and install android sdk':
        command => 'mkdir -p /root/sdk && cd /root/sdk && wget http://dl.google.com/android/adt/adt-bundle-linux-x86_64.zip && unzip adt-bundle-linux-x86_64.zip',
        require => Package['zip'],
    }

    exec { 'upload roots path':
        command => 'echo export PATH="${PATH}:~/bin:/root/sdk/adt-bundle-linux-x86_64/sdk/platform-tools" >> /root/.bashrc'
    }

    # repo init/sync:
    # repo init -u git://github.com/CyanogenMod/android.git -b cm-10.1
    # repo sync

    # get prebuilt
    # cd ~/android/system/vendor/cm
    # ./get-prebuilts

}

include prep-android-build

