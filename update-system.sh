#!/bin/bash
# rwe

DIR=/dev/null

if ! ping -c 4 8.8.8.8 > $DIR 2>&1 
then
	echo "Sem conexão com a internet"
	exit 1 
else 
	USER=$(whoami)
	if [ $USER != 'root' ]
	then 
		sudo apt upgrade -y > $DIR 2>&1 
		sudo apt update -y > $DIR 2>&1
		sudo apt dist-upgrade > $DIR 2>&1 
		if [ $? -eq 0 ]
		then	
			read -p "Atualizações concluídas reiniciar agora [y/n]" OPTION
			case $OPTION in
				[yY])
					reboot
					;;
				[nN])
					exit 0
					;;
				*)
					echo "Opção inválida" 
					;;
			esac 
		else
			echo "Aconteceu algum erro no processo de atualização" 
			exit 4 
		fi
	else
		apt upgrade > $DIR 2>&1
		apt update > $DIR 2>&1
		apt dist-upgrade > $DIR 2>&1
		
		if [ $? -eq 0 ]
		then
			read -p "Atualizações concluídas reiniciar agora [y/n]" OPTION
			case $OPTION in
				[yY])
					reboot
					;;
				[nN])
					exit 0
					;;
				*)
					echo "Opção inválida" 
					exit 1
					;;
			esac
		else
			echo "Aconteceu algum erro no processo de atualização" 
			exit 4
		fi
	fi
fi

exit 0	
