
Using Carteiro with Vagrant

Requirements:
- Vagrant
	-- https://www.vagrantup.com/downloads.html
- VirtualBox
	-- https://www.virtualbox.org/

Description:
- The Vagrantfile contains the Vagrant configuration
- The folder /static contains two git submodules
 -- carteiro components
 -- windows components

Vagrant Commands:
	vagrant status
	vagrant up [carteiro|wsus|win-client]
	vagrant destroy [carteiro|wsus|win-client]
	vagrant ssh carteiro

VM Access:
	carteiro
		- vagrant ssh carteiro
		- http://localhost:5000
	wsus
		- RDP Connection over localhost:5001
		- Username: vagrant
		- Password: vagrant
	win-client
		- RDP Connection over localhost:5002
		- Username: vagrant
		- Password: vagrant
