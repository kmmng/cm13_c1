#!/bin/bash
# Stage 3 - compile CyanogenMod
if [ ! "$C1MODEL" ]; then
C1MODEL=c1lgt
fi
if [ "$C1MODEL" = "c1lgt" ]; then
C1VAR=L
elif [ "$C1MODEL" = "c1skt" ]; then
C1VAR=S
elif [ "$C1MODEL" = "c1ktt" ]; then
C1VAR=K
else
echo Unknown device model, C1MODEL should be c1lgt/c1skt/c1ktt
exit
fi
echo Building CM13 for SHV-E210$C1VAR, this may take a long time...
sleep 5
cd ~/android/system
if grep -q Microsoft /proc/version; then
cd build
git checkout -f
# Try to disable unsupported commands on WSL, Unfortunately, it doesn't help too much as the build hangs later anyway.
sed -i 's/mk_timer schedtool -B -n 1 -e ionice -n 1 //g' envsetup.sh
cd ..
fi
source build/envsetup.sh
# Enable ccache
export USE_CCACHE=1
prebuilts/misc/linux-x86/ccache/ccache -M 50G
# Compile
brunch $C1MODEL
