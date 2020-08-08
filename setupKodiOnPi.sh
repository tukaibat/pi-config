sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt autoremove
sudo apt-get install -y kodi vim deluged deluge-web deluge-console python-mako
sudo echo "color pablo" > ~/.vimrc
sudo cat <<EOT >> /etc/systemd/system/kodi.service
[Unit]
Description = Kodi Media Center

After = systemd-user-sessions.service sound.target

[Service]
User = kodi
Group = kodi
Type = simple
PAMName = login
ExecStart = /usr/bin/xinit /usr/bin/dbus-launch --exit-with-session /usr/bin/kodi-standalone -- :0 -nolisten tcp vt7
Restart = on-abort
RestartSec = 5

[Install]
WantedBy = multi-user.target
EOT
sudo systemctl enable kodi
sudo service kodi start
#sudo systemctl disable kodi
deluged sudo pkill deluged
sudo echo "pi:raspberry:10" >> ~/.config/deluge/auth
deluge-console "config -s allow_remote True"
deluge-web -f
echo "Access the interface here: http://`hostname -I | xargs`:8112"