#!/bin/bash
# mrbvrz - https://hasansuryaman.com

# Colours Variables
RESTORE='\033[0m'
RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

# Destination directory
ROOT_UID=0
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/fonts/Microsoft/TrueType/SegoeUI/"
else
  DEST_DIR="$HOME/.local/share/fonts/Microsoft/TrueType/SegoeUI/"
fi
WINE_FONT_DIR="$HOME/.wine/drive_c/windows/Fonts/"

# Check Internet Conection
function cekkoneksi(){
    echo -e "$BLUE [ * ] Checking for internet connection"
    sleep 1
    echo -e "GET http://google.com HTTP/1.0\n\n" | curl google.com > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo -e "$RED [ X ]$BLUE Internet Connection ➜$RED OFFLINE!\n";
        echo -e "$RED Sorry, you really need an internet connection...."
        exit 0
    else
        echo -e "$GREEN [ ✔ ]$BLUE Internet Connection ➜$GREEN CONNECTED!\n";
        sleep 1
    fi
}

function cekwget(){
    echo -e "$BLUE [ * ] Checking for Wget"
    sleep 1
    which wget > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
    echo -e "$GREEN [ ✔ ]$BLUE Wget ➜$GREEN INSTALLED\n"
        sleep 1
    else
        echo -e "$RED [ X ]$BLUE Wget ➜$RED NOT INSTALLED\n"
        continueWget
    fi
}

function cekfont(){
    echo -e "$BLUE [ * ] Checking for Segoe-UI Font"
    sleep 1
    fc-list | grep -i "Segoe UI" >/dev/null 2>&1
    if [ "$?" -eq "0" ]; then
    echo -e "$GREEN [ ✔ ]$BLUE Segoe-UI Font ➜$GREEN INSTALLED\n"
        sleep 1
    else
        echo -e "$RED [ X ]$BLUE Segoe-UI Font ➜$RED NOT INSTALLED\n"
        continueFont
    fi
}

function continueFont(){
    echo -e "$LGREEN Do you want to install Segoe-UI Font? (y)es, (n)o :"
    read  -p ' ' INPUT
    case $INPUT in
    [Yy]* ) fontinstall;;
    [Nn]* ) end;;
    * ) echo -e "$RED\n Sorry, try again."; continueFont;;
  esac
}

function fontinstall(){
    mkdir -p "$DEST_DIR"
    if [ -d font ]; then
        cp font/segoeui.ttf "$DEST_DIR"/segoeui.ttf > /dev/null 2>&1 # regular
        cp font/segoeuib.ttf "$DEST_DIR"/segoeuib.ttf > /dev/null 2>&1 # bold
        cp font/segoeuii.ttf "$DEST_DIR"/segoeuii.ttf > /dev/null 2>&1 # italic
        cp font/segoeuiz.ttf "$DEST_DIR"/segoeuiz.ttf > /dev/null 2>&1 # bold italic
        cp font/segoeuil.ttf "$DEST_DIR"/segoeuil.ttf > /dev/null 2>&1 # light
        cp font/seguili.ttf "$DEST_DIR"/seguili.ttf > /dev/null 2>&1 # light italic
        cp font/segoeuisl.ttf "$DEST_DIR"/segoeuisl.ttf > /dev/null 2>&1 # semilight
        cp font/seguisli.ttf "$DEST_DIR"/seguisli.ttf > /dev/null 2>&1 # semilight italic
        cp font/seguisb.ttf "$DEST_DIR"/seguisb.ttf > /dev/null 2>&1 # semibold
        cp font/seguisbi.ttf "$DEST_DIR"/seguisbi.ttf > /dev/null 2>&1 # semibold italic
        cp font/seguibl.ttf "$DEST_DIR"/seguibl.ttf > /dev/null 2>&1 # bold light
        cp font/seguibli.ttf "$DEST_DIR"/seguibli.ttf > /dev/null 2>&1 # bold light italic
        cp font/seguiemj.ttf "$DEST_DIR"/seguiemj.ttf > /dev/null 2>&1 # emoji
        cp font/seguisym.ttf "$DEST_DIR"/seguisym.ttf > /dev/null 2>&1 # symbol
        cp font/seguihis.ttf "$DEST_DIR"/seguihis.ttf > /dev/null 2>&1 # historic

        if [ -d $WINE_FONT_DIR ]; then
            cp font/segoeui.ttf "$WINE_FONT_DIR"/segoeui.ttf > /dev/null 2>&1 # regular
            cp font/segoeuib.ttf "$WINE_FONT_DIR"/segoeuib.ttf > /dev/null 2>&1 # bold
            cp font/segoeuii.ttf "$WINE_FONT_DIR"/segoeuii.ttf > /dev/null 2>&1 # italic
            cp font/segoeuiz.ttf "$WINE_FONT_DIR"/segoeuiz.ttf > /dev/null 2>&1 # bold italic
            cp font/segoeuil.ttf "$WINE_FONT_DIR"/segoeuil.ttf > /dev/null 2>&1 # light
            cp font/seguili.ttf "$WINE_FONT_DIR"/seguili.ttf > /dev/null 2>&1 # light italic
            cp font/segoeuisl.ttf "$WINE_FONT_DIR"/segoeuisl.ttf > /dev/null 2>&1 # semilight
            cp font/seguisli.ttf "$WINE_FONT_DIR"/seguisli.ttf > /dev/null 2>&1 # semilight italic
            cp font/seguisb.ttf "$WINE_FONT_DIR"/seguisb.ttf > /dev/null 2>&1 # semibold
            cp font/seguisbi.ttf "$WINE_FONT_DIR"/seguisbi.ttf > /dev/null 2>&1 # semibold italic
            cp font/seguibl.ttf "$WINE_FONT_DIR"/seguibl.ttf > /dev/null 2>&1 # bold light
            cp font/seguibli.ttf "$WINE_FONT_DIR"/seguibli.ttf > /dev/null 2>&1 # bold light italic
            cp font/seguiemj.ttf "$WINE_FONT_DIR"/seguiemj.ttf > /dev/null 2>&1 # emoji
            cp font/seguisym.ttf "$WINE_FONT_DIR"/seguisym.ttf > /dev/null 2>&1 # symbol
            cp font/seguihis.ttf "$WINE_FONT_DIR"/seguihis.ttf > /dev/null 2>&1 # historic
            echo -e "$GREEN\n Font installed to WINE $LBLUE'$WINE_FONT_DIR'"
        fi

    else
        # Download font from github static link code
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeui.ttf?raw=true -O "$DEST_DIR"/segoeui.ttf > /dev/null 2>&1 # regular
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuib.ttf?raw=true -O "$DEST_DIR"/segoeuib.ttf > /dev/null 2>&1 # bold
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuii.ttf?raw=true -O "$DEST_DIR"/segoeuii.ttf > /dev/null 2>&1 # italic
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuiz.ttf?raw=true -O "$DEST_DIR"/segoeuiz.ttf > /dev/null 2>&1 # bold italic
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuil.ttf?raw=true -O "$DEST_DIR"/segoeuil.ttf > /dev/null 2>&1 # light
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguili.ttf?raw=true -O "$DEST_DIR"/seguili.ttf > /dev/null 2>&1 # light italic
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuisl.ttf?raw=true -O "$DEST_DIR"/segoeuisl.ttf > /dev/null 2>&1 # semilight
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisli.ttf?raw=true -O "$DEST_DIR"/seguisli.ttf > /dev/null 2>&1 # semilight italic
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisb.ttf?raw=true -O "$DEST_DIR"/seguisb.ttf > /dev/null 2>&1 # semibold
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisbi.ttf?raw=true -O "$DEST_DIR"/seguisbi.ttf > /dev/null 2>&1 # semibold italic
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguibl.ttf?raw=true -O "$DEST_DIR"/seguibl.ttf > /dev/null 2>&1 # bold light
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguibli.ttf?raw=true -O "$DEST_DIR"/seguibli.ttf > /dev/null 2>&1 # bold light italic
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguiemj.ttf?raw=true -O "$DEST_DIR"/seguiemj.ttf > /dev/null 2>&1 # emoji
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisym.ttf?raw=true -O "$DEST_DIR"/seguisym.ttf > /dev/null 2>&1 # symbol
        wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguihis.ttf?raw=true -O "$DEST_DIR"/seguihis.ttf > /dev/null 2>&1 # historic
    fi

    fc-cache -f "$DEST_DIR"
    echo -e "$GREEN\n Font installed on $LBLUE'$DEST_DIR'"
}

function wgetinstall(){   
    sleep 1
    sudo apt update > /dev/null 2>&1
    sudo apt install -y wget > /dev/null 2>&1
}

function end(){
    echo -e "$LPURPLE\n Bye..... ;)"
    exit 0
}

continueWget() {
  echo -e "$LGREEN Do you want to install Wget? (y)es, (n)o :"
  read  -p ' ' INPUT
  case $INPUT in
    [Yy]* ) wgetinstall;;
    [Nn]* ) end;;
    * ) echo -e "$RED\n Sorry, try again."; continueWget;;
  esac
}

function banner(){
    echo -e "$LYELLOW" ""
    echo -e "                                         _    __            _   "
    echo -e "                                        (_)  / _|          | |  "
    echo -e "  ___  ___  __ _  ___   ___        _   _ _  | |_ ___  _ __ | |_ "
    echo -e " / __|/ _ \/ _  |/ _ \ / _ \  __  | | | | | |  _/ _ \|  _ \| __|"
    echo -e " \__ \  __/ (_| | (_) |  __/ (__) | |_| | | | || (_) | | | | |_ "
    echo -e " |___/\___|\__, |\___/ \___|       \__,_|_| |_| \___/|_| |_|\__|"
    echo -e "            __/ |                                               "
    echo -e "           |___/             $LPURPLE mrbvrz$LCYAN -$RED https://hasansuryaman.com        "
    echo ""
    echo -e "$LYELLOW ---------------------------------------------------------------"
    echo ""
}

main(){
    clear
    banner
    cekkoneksi
    cekwget
    cekfont
}

main
