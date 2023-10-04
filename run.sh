#!/bin/bash

# bash ./run.sh -r runAllModules
# bash ./run.sh -r runSpecificModules -m window,math -d physics,graphics
# bash ./run.sh -r runSpecificModules -m window,graphics
# bash ./run.sh -r runSpecificMethod -m graphics -f rectangle
# bash ./run.sh -r runSpecificMethod -m graphics -f rectangle -d window

# what format do we actually want here
# -r runAllTests | runSpecificModules | runSpecificMethod
# -m module1,module2
# -f method1
# -d disable1,disable2

## Disabling Modules
# If you want to disable specific modules when testing you need to use the `run.sh` bash script provided so that the `conf.lua` file can be modified before running it as these can't be disabled during runtime.  
# > Running this script will not reset the `conf.lua` file!  
# > Be sure to turn modules you need back on after
# 
# The bash script has the following flags:  
# `-r all|modules|method` - type of test to run  
# `-l PATH_TO_LOVE` - path to love i.e. `/Applications/love.app/Contents/MacOS/love`  
# `-p PATH_TO_MAIN` - path to test game folder, i.e. `./` if running directly in the root of this repo  
# `-m module1,module2` - specific modules to test if using `-r modules`  
# `-f method` - specific method to test is using `-r method`  
# `-d disable1,disable2` - specific modules to disable while testing  
# 
# Example uses:  
# `bash ./run.sh -l "/Applications/love.app/Contents/MacOS/love" -p "./" -r all`  
# `bash ./run.sh -l "/Applications/love.app/Contents/MacOS/love" -p "./" -r modules -m window,math -d physics,graphics`  
# `bash ./run.sh -l "/Applications/love.app/Contents/MacOS/love" -p "./" -r method -m graphics -f rectangle -d window`

while getopts l:p:r:m:f:d: flag
do
    case "${flag}" in
        l) love_path=${OPTARG};;
        p) file_path=${OPTARG};;
        r) cmd=${OPTARG};;
        m) modules=${OPTARG};;
        d) disable=${OPTARG};;
        f) method=${OPTARG};;
    esac
done
echo "command: $cmd";
echo "modules: $modules";
echo "method: $method";
echo "disable: $disable";

enabled_audio="true"
enabled_data="true"
enabled_event="true"
enabled_filesystem="true"
enabled_font="true"
enabled_graphics="true"
enabled_image="true"
enabled_math="true"
enabled_objects="true"
enabled_physics="true"
enabled_sound="true"
enabled_system="true"
enabled_thread="true"
enabled_timer="true"
enabled_video="true"
enabled_window="true"

if [[ $disable = *"audio"* ]]; then enabled_audio="false"; fi
if [[ $disable = *"data"* ]]; then enabled_data="false"; fi
if [[ $disable = *"event"* ]]; then enabled_event="false"; fi
if [[ $disable = *"filesystem"* ]]; then enabled_filesystem="false"; fi
if [[ $disable = *"font"* ]]; then enabled_font="false"; fi
if [[ $disable = *"graphics"* ]]; then enabled_graphics="false"; fi
if [[ $disable = *"image"* ]]; then enabled_image="false"; fi
if [[ $disable = *"math"* ]]; then enabled_math="false"; fi
if [[ $disable = *"objects"* ]]; then enabled_objects="false"; fi
if [[ $disable = *"physics"* ]]; then enabled_physics="false"; fi
if [[ $disable = *"sound"* ]]; then enabled_sound="false"; fi
if [[ $disable = *"system"* ]]; then enabled_system="false"; fi
if [[ $disable = *"thread"* ]]; then enabled_thread="false"; fi
if [[ $disable = *"timer"* ]]; then enabled_timer="false"; fi
if [[ $disable = *"video"* ]]; then enabled_video="false"; fi
if [[ $disable = *"window"* ]]; then enabled_window="false"; fi

config_audio="t.modules.audio = $enabled_audio"
config_data="t.modules.data = $enabled_data"
config_event="t.modules.event = $enabled_event"
config_filesystem="t.modules.filesystem = $enabled_filesystem"
config_font="t.modules.font = $enabled_font"
config_graphics="t.modules.graphics = $enabled_graphics"
config_image="t.modules.image = $enabled_image"
config_math="t.modules.math = $enabled_math"
config_objects="t.modules.objects = $enabled_objects"
config_physics="t.modules.physics = $enabled_physics"
config_sound="t.modules.sound = $enabled_sound"
config_system="t.modules.system = $enabled_system"
config_thread="t.modules.thread = $enabled_thread"
config_timer="t.modules.timer = $enabled_timer"
config_video="t.modules.video = $enabled_video"
config_window="t.modules.window = $enabled_window"

printf "function love.conf(t)\nt.console = true\nt.window.name = 'love.test'\nt.window.width = 256\nt.window.height = 256\nt.window.resizable = true\n$config_audio\n$config_data\n$config_event\n$config_filesystem\n$config_font\n$config_graphics\n$config_image\n$config_math\n$config_objects\n$config_physics\n$config_sound\n$config_system\n$config_thread\n$config_timer\n$config_video\n$config_window\nend" >| "$file_path/conf.lua"

run_cmd="--runAllTests"
if [[ $cmd = *"all"* ]]; then run_cmd="--runAllTests"; modules=""; method=""; fi
if [[ $cmd = *"modules"* ]]; then run_cmd="--runSpecificModules"; method=""; fi
if [[ $cmd = *"method"* ]]; then run_cmd="--runSpecificMethod"; fi

launch_love="$love_path $file_path $run_cmd $modules --disableModules $disable"

echo $launch_love

$love_path $file_path "$run_cmd" "$modules" "$method" "--disableModules" "$disable"