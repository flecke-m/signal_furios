#!/bin/bash

export GDK_SCALE=2  
export GTK_IM_MODULE=Maliit 
export GTK_IM_MODULE_FILE=/home/furios/.config/signalut.furios/immodules.cache 
export GDK_BACKEND=x11 
export DISABLE_WAYLAND=1 
export DCONF_PROFILE=/nonexistent
export XDG_CONFIG_HOME=/home/furios/.config/signalut.furios/
export XDG_DATA_HOME=/home/furios/.local/share/signalut.furios/
export XDG_DESKTOP_DIR=/home/furios/.config/signalut.furios/
export LD_LIBRARY_PATH=$PWD/lib/aarch64-linux-gnu/

utils/mkdir.sh /home/furios/.config/signalut.furios/
echo "\"$PWD/lib/aarch64-linux-gnu/gtk-3.0/3.0.0/immodules/im-maliit.so\""  > /home/furios/.config/signalut.furios/immodules.cache 
echo  "\"Maliit\" \"Maliit Input Method\" \"maliit\" \"\" \"en:ja:ko:zh:*\""  >> /home/furios/.config/signalut.furios/immodules.cache 

echo 'XDG_DESKTOP_DIR="/home/furios/.cache/signalut.furios/downloads/"'> /home/furios/.config/signalut.furios/user-dirs.dirs

if [ "$DISPLAY" = "" ]; then
    i=0
    while [ -e "/tmp/.X11-unix/X$i" ] ; do 
        i=$(( i + 1 ))
    done
    i=$(( i - 1 ))
    display=":$i"
    export DISPLAY=$display
fi

export PATH=$PWD/bin:$PATH
utils/mkdir.sh /home/furios/.cache/signalut.furios/

#Read micstate in conf
while read p; do
  if [[ "$p" == *"micState="* ]]; then  micstate=$p; fi
done <  /home/furios/.config/signalut.furios/signalut.furios/signalut.furios.conf 


    if [[ "$micstate" != *"micState=1"* ]]&& [[ "$micstate" != *"micState=4"* ]]; then
        xdotool sleep 2;
        qmlscene utils/mic-permission-requester/Main.qml -I utils/mic-permission-requester/ &
        xdotool sleep 5;
        while true; do
            xdotool sleep 1;
            while read p; do
                if [[ "$p" == *"micState="* ]]; then  micstate=$p; fi
            done <  /home/furios/.config/signalut.furios/signalut.furios/signalut.furios.conf 
            echo "$micstate"
            if  [ "$micstate" == "micState=1" ]||  [ "$micstate" == "micState=2" ]; then
                break;
            fi
            if  [ "$micstate" == "micState=4" ]; then
                    break;
            fi
        done
    fi

    
utils/rm.sh /home/furios/.local/share/signalut.furios/recently-used.xbel

for file in /home/furios/.cache/signalut.furios/downloads/* ; do
    utils/rm.sh $file
done


scale=$(./utils/get-scale.sh 2>/dev/null )

dpioptions="--high-dpi-support=1 --force-device-scale-factor=$scale --grid-unit-px=$GRID_UNIT_PX"
sandboxoptions="--no-sandbox"
gpuoptions="--use-gl=egl --enable-gpu-rasterization --enable-zero-copy --ignore-gpu-blocklist --enable-features=UseSkiaRenderer,VaapiVideoDecoder --disable-frame-rate-limit --disable-gpu-vsync --enable-oop-rasterization"

#Open a dummy qt gui app to realease lomiri from its waiting
( utils/sleep.sh; $PWD/bin/xdg-open )&
( utils/filedialog-deamon.sh $$ )&

initpwd=$PWD
utils/mkdir.sh /home/furios/.cache/signalut.furios/downloads/
cd /home/furios/.cache/signalut.furios/downloads/
exec $initpwd/opt/Signal/signal-desktop $dpioptions $sandboxoptions $gpuoptions
