# FRDM-K64F-baremetal-minimal

Build Host: Linux

Dependencies: GCC-ARM-EMBEDDED, OpenOCD

Compiler: https://launchpad.net/gcc-arm-embedded

Debugger: https://openocd.org

Steps to Build and Flash Project:

1) Download and extract the compiler: 

option A download the prebuilt toolchain from Arm:

  wget https://launchpad.net/gcc-arm-embedded/4.9/4.9-2015-q3-update/+download/gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2

  tar -xvf gcc-arm-none-eabi-4_9-2015q3-20150921-linux.tar.bz2

  mv gcc-arm-none-eabi-4_9-2015q3 /opt

option B check your package manager for the arm-none-eabi related pacakges (gcc, gdb, etc.) and install them

2) Get Openocd

option A you can build it from source:

  wget https://sourceforge.net/projects/openocd/files/openocd/0.10.0/openocd-0.10.0.tar.gz

  tar -xzf openocd-0.10.0.tar.gz

  Then follow build and install instructions in the extracted openocd directory

option B check to see if your package manager has openocd and install

2) Clone the repository

https://github.com/clranc/FRDM-K64F-baremetal-minimal.git

original repo without my flash additions:

  https://github.com/ferlzc/FRDM-K64F-baremetal-minimal.git

3) Build a basic project

cd FRDM-K64F-baremetal-minimal

make

4) flash

make flash


