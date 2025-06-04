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
LBLACK='\033[01;90m'
LIGHTGRAY='\033[00;37m'
LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

# Cursor Movement
MOVE_CURSOR_UP='\033[1A'

# Erase content
ERASER='\r                                                                                                    \r'

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
    # For this function, I'm using carriage returning (\r) to erase
    # an already printed line

    # print section title
    echo -ne " ${WHITE}[ .... ] Checking ${LBLACK}for internet connection...${RESTORE}"
    sleep 1

    # List all network interfaces
    interfaces=$(ip -o link show | awk -F': ' '{print $2}')

    # Flag to track internet connection status
    internet_connected=0

    # Iterate over each network interface and check internet connectivity
    for interface in $interfaces; do
        # erase section title
        echo -ne "${ERASER}"
        echo -ne " ${WHITE}[ .... ] Checking \`${LCYAN}$interface${WHITE}\`${LBLACK} interface${RESTORE}"
        sleep 0.5
        if ping -c 1 -w 2 -I  $interface google.com &> /dev/null; then
            echo -ne "${ERASER}"
            echo -e " ${WHITE}[${GREEN}  OK  ${WHITE}] Interface \`${LCYAN}$interface${WHITE}\`${LBLACK} is connected${RESTORE}"
            internet_connected=1
            break  # If connected on any interface, no need to continue testing
        # This block is no longer necessary. The fail alert will be overwrited by the connection error bellow vvv
        # else
        #    echo -ne "\r ${WHITE}[${RED}  FAIL  ${WHITE}] Interface${LBLACK} \`${LRED}$interface${LBLACK}\` isn't connected"
        fi
    done

    # Check overall connection status
    if [ $internet_connected -eq 0 ]; then
        echo -e " ${WHITE}[${RED} FAIL ${WHITE}] Internet connection is required to proceed with"
        echo -e "          this scripts...${RESTORE}\n"
        exit 0
    fi
}

function cekwget(){
    # print section title
    echo -ne " ${WHITE}[ .... ] Checking${LBLACK} for Wget...${RESTORE}"
    sleep 1.5
    which wget > /dev/null 2>&1
    status=$?

    echo -ne "${ERASER}"

    if [ "$status" -eq "0" ]; then
        echo -e " ${WHITE}[${GREEN}  OK  ${WHITE}] Program \`${LCYAN}wget${WHITE}\`${LBLACK} was found${RESTORE}"
    else
        echo -e " ${WHITE}[${LYELLOW} WARN ${WHITE}]${RESTORE} The \`${LCYAN}wget${RESTORE}\` program may be necessary to proceed"
        echo -e "          with the script!";
        continueWget
    fi
}

function cekfont(){
    echo -ne " ${WHITE}[ .... ] Checking${LBLACK} for Segoe UI font${RESTORE}"
    sleep 1
    fc-list | grep -i "Segoe UI" >/dev/null 2>&1
    status=$?
    echo -ne "${ERASER}";
    if [ "$status" -eq "0" ]; then
        echo -e " ${WHITE}[  ${LGREEN}OK${WHITE}  ] Segoe-UI Font ${LBLACK}is already installed${RESTORE}\n"
    else
        echo -e " ${WHITE}[ ${LYELLOW}WARN${WHITE} ] Segoe-UI Font ${LBLACK}isn't installed${RESTORE}"
        continueFont
    fi
}

function continueFont(){
    echo -ne "          Do you want to install Segoe-UI Font? [(y)es/(n)o]"
    read  -p ' ' INPUT
    case $INPUT in
    [Yy]* ) echo -ne "${ERASER}${MOVE_CURSOR_UP}${ERASER}${MOVE_CURSOR_UP}${ERASER}"; fontinstall;;
    [Nn]* ) end;;
    * ) echo -ne "${MOVE_CURSOR_UP}${ERASER}"; continueFont;;
  esac
}

function fontinstall(){
    echo -ne " ${WHITE}[ .... ] Checking ${LBLACK}all necessary fonts${RESTORE}"
    sleep 1
    missing=false
    font_files=(        \
        "segoeui.ttf"   \
        "segoeuib.ttf"  \
        "segoeuii.ttf"  \
        "segoeuiz.ttf"  \
        "segoeuil.ttf"  \
        "seguili.ttf"   \
        "segoeuisl.ttf" \
        "seguisli.ttf"  \
        "seguisb.ttf"   \
        "seguisbi.ttf"  \
        "seguibl.ttf"   \
        "seguibli.ttf"  \
        "seguiemj.ttf"  \
        "seguisym.ttf"  \
    )

    # Check if all fonts (static, no problem here) exists
    for fnt in "${font_files[@]}"; do
        if [ ! -f "./font/$fnt" ]; then
            missing=true
        break
        fi
    done

    echo -ne "${ERASER}"

    # print missing status
    if [ "$missing" == "true" ]; then
        echo -e " ${WHITE}[ ${LYELLOW}WARN ${WHITE}] Some fonts ${LBLACK}are missing."
        echo -ne " ${WHITE}         They'll be pulled from the ${LCYAN}official repo${RESTORE}."
    else
        echo -e " ${WHITE}[  ${LGREEN}OK  ${WHITE}] No fonts ${LBLACK}missing."
        echo -ne " ${WHITE}         They'll be copied from the '${LCYAN}fonts${WHITE}' dir${RESTORE}."
    fi
    sleep 4

    mkdir -p "$DEST_DIR"
    echo -ne "${ERASER}${MOVE_CURSOR_UP}"
    url_link="https://github.com/mrbvrz/segoe-ui/raw/master/font"

    # for each font in our list
    for i in "${!font_files[@]}"; do
        # if missing, get from github link
        if [ "$missing" == "true" ]; then
            wget -q "$url/${font_files[i]}?raw=true" -O "$DEST_DIR/${font_files[i]}" > /dev/null 2>&1
            echo -ne "${ERASER} ${WHITE}[ ${LCYAN}PULL ${WHITE}] Pulling font${LBLACK} with ${LGREEN}wget ${LBLACK}($((i+1))/${#font_files[@]})${RESTORE}"
        else
            # else, copy + wine if enable
            cp "font/${font_files[i]}" "$DEST_DIR/${font_files[i]}" > /dev/null 2>&1
            if [ -d $WINE_FONT_DIR ]; then
                cp "font/${font_files[i]}" "$WINE_FONT_DIR/${font_files[i]}" > /dev/null 2>&1
            fi
            echo -ne "${ERASER} ${WHITE}[ ${LCYAN}COPY ${WHITE}] Copying '${LGREEN}${font_files[i]}${WHITE}' ${LBLACK}font ($((i+1))/${#font_files[@]})${RESTORE}"
        fi
        sleep 0.2
    done
    # print final status + cache fonts
    echo -ne "\n ${WHITE}[  ${LGREEN}OK  ${WHITE}] Fonts successfully${LBLACK} copied/pulled.${RESTORE}"
    sleep 2.5
    echo -ne "${ERASER} ${WHITE}[ .... ] Caching ${LBLACK}the added fonts.${RESTORE}"
    sleep 0.5
    fc-cache -f "$DEST_DIR"
    echo -e "\n ${WHITE}[ ${LGREEN}DONE ${WHITE}] Fonts installed on ${LCYAN}${DEST_DIR}${RESTORE}\n"
}

function wgetinstall(){
    echo -ne " ${WHITE}[ .... ] Installing \`${LCYAN}wget${WHITE}\` ${LBLACK}with ${LGREEN}apt ${LBLACK}package manager${RESTORE}"
    sleep 1.5
    echo -ne "${ERASER}"
    if [ ! "$UID" -eq "$ROOT_UID" ]; then
        echo -e " ${WHITE}[ ${LRED}FAIL${WHITE} ] You need to run as ${LGREEN}sudo${WHITE} to install \`${LCYAN}wget${WHITE}\`."
        echo -e "          Consider using \`${LGREEN}sudo ./install.sh${WHITE}\`${RESTORE}\n"
        exit 0
    fi
    # use 'and' operator (better approach). Install wget only if the 'apt update' returns success
    apt update > /dev/null 2>&1 && apt install -y wget > /dev/null 2>&1
    if [ ! $? -eq 0 ]; then
        echo -e " ${WHITE}[ ${LRED}FAIL${WHITE} ] Couldn't run ${LGREEN}apt update ${WHITE}+ ${LGREEN}apt install -y wget${WHITE}."
        echo -e "          Consider installing \`${LCYAN}wget${WHITE}\` manually by your OS"
        echo -e "          package manager!${RESTORE}\n"
        exit 0
    fi
}

function end(){
    echo -e "\n${LPURPLE}          Bye....   ;)${RESTORE}\n"
    exit 0
}

continueWget() {
  echo -ne "\r          Do you want to install Wget? [(y)es/(n)o]"
  read  -p ' ' INPUT
  case $INPUT in
    [Yy]* ) echo -ne "${ERASER}${MOVE_CURSOR_UP}${ERASER}${MOVE_CURSOR_UP}${ERASER}${MOVE_CURSOR_UP}${ERASER}"; wgetinstall;;
    [Nn]* ) end;;
    # Move the cursor 1 row up, overwrite the line and call the question again
    * ) echo -ne "${MOVE_CURSOR_UP}${ERASER}"; continueWget;;
  esac
}

function banner(){
    echo -e "$LYELLOW"
    echo    "                                         _    __            _   "
    echo    "                                        (_)  / _|          | |  "
    echo    "  ___  ___  __ _  ___   ___        _   _ _  | |_ ___  _ __ | |_ "
    echo    " / __|/ _ \/ _  |/ _ \ / _ \  __  | | | | | |  _/ _ \|  _ \| __|"
    echo    " \__ \  __/ (_| | (_) |  __/ (__) | |_| | | | || (_) | | | | |_ "
    echo    " |___/\___|\__, |\___/ \___|       \__,_|_| |_| \___/|_| |_|\__|"
    echo    "            __/ |                                               "
    echo -e "           |___/             $LPURPLE mrbvrz$WHITE -$LRED https://hasansuryaman.com"
    echo    ""
    echo -e "$WHITE ---------------------------------------------------------------"
    echo -e "$RESTORE"
}

main(){
    clear
    banner
    cekkoneksi
    cekwget
    cekfont
}

main
