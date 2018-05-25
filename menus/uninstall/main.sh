
 #!/bin/bash

whiptail --title "Uninstaller Information" --msgbox "The UnInstaller will remove all services, nuke file directories and accumlated files, uninstall docker, and remove all containers; but will prompt you if you want to keep your program (APPDATA)." 13 76


if dialog --stdout --title "PG UnInstaller" \
        --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
        --yesno "\nDo you WANT TO STOP THE UNINSTALL & BACKOUT!?" 7 50; then
            dialog --infobox "Nothing Has Been Uninstalled!" 3 45
            sleep 3 
    else
         dialog --infobox "UnInstalling PlexGuide!\n\nMay the Force Be With You - PlexGuide Never Dies!" 0 0
         sleep 4
         dialog --infobox "Removing Services" 3 45
         sleep 1
         ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags unservices
         dialog --infobox "Removing Files & Folders" 3 45
         sleep 1
         ansible-playbook /opt/plexguide/ansible/plexguide.yml --tags unfiles
         dialog --infobox "Uninstall Docker & Removing Containers" 3 45
         sleep 1
         clear
         rm -r /etc/docker 1>/dev/null 2>&1
         apt-get purge docker-ce -y
         rm -rf /var/lib/docker 1>/dev/null 2>&1

         dialog --infobox "Program Data Removed - Not Ready" 0 0
         sleep 1

         if dialog --stdout --title "Program (AppData)" \
        --backtitle "Visit https://PlexGuide.com - Automations Made Simple" \
        --yesno "\nDo you WANT to keep your Program Configs (Appdata)?" 7 60; then
          dialog --infobox "Your Data will remain under /opt/appdata" 3 50
        else
         dialog --infobox "Deleting Your Data Forever!" 3 45
         sleep 1
         rm -r /opt/appdata 1>/dev/null 2>&1
         dialog --infobox "I'm here, I'm there, wait... I'm your DATA! Poof! I'm gone!" 3 60
        fi
         dialog --infobox "A REBOOT of your Server will Commence in 3 SECONDS!" 0 0
         sleep 3
         dialog --infobox "GoodBye!" 0 0
         sleep 1
         reboot
fi