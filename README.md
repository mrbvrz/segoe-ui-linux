# Install Segoe-UI Font on Linux (Ubuntu)

```console
$ sudo mkdir -p /usr/share/fonts/truetype/msttcorefonts/
$ cd /usr/share/fonts/truetype/msttcorefonts/
$ sudo wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeui.ttfraw=true -O segoeui.ttf # regular
$ sudo wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuib.ttf?raw=true -O segoeuib.ttf # bold
$ sudo wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuii.ttf?raw=true -O segoeuii.ttf # italic
$ sudo wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuiz.ttf?raw=true -O segoeuiz.ttf # bold italic
$ sudo wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuil.ttf?raw=true -O segoeuil.ttf # light
$ sudo wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguili.ttf?raw=true -O seguili.ttf # light italic
$ sudo wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/segoeuisl.ttf?raw=true -O segoeuisl.ttf # semilight
$ sudo wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisli.ttf?raw=true -O seguisli.ttf # semilight italic
$ sudo wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisb.ttf?raw=true -O seguisb.ttf # semibold
$ sudo wget -q https://github.com/mrbvrz/segoe-ui/raw/master/font/seguisbi.ttf?raw=true -O seguisbi.ttf # semibold italic
$ fc-cache -f /usr/share/fonts/truetype/msttcorefonts/
```
