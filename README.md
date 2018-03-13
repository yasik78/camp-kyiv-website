## Docker injection instructions

#### PREREQUIREMENTS.
- System: Ubuntu 16.04 or 14.04
- Docker engine should be already installed on your machine. If you dont have it, run this commands:
  - $ wget -qO- https://get.docker.com/ | sh
  - $ sudo usermod -aG docker "$(whoami)"
  - $ sudo reboot
  
#### How to use.
- Clone this repo to your local machine
- Remove .git dir
- CD to the folder that contains cloned repo
- Create folder for your project, using name "docroot"
- Place your drupal files in to created dir ("docroot")
- Enter your settings to the [`settings.sh`](settings.sh) . In most cases you are interested in "User configuration section" that includes only 2 variables you need to define value for. "User configuration section" section located at the top of the file 'settings.sh' (first ~10 lines). If you are advanced user, or a maintainer of this project - than you can make changes at "Advanced configuration section" if you need. All code at the "Advanced configuration section" is commented, but remember - you do changes for your own risk. Well here is 2 variables that you need to set value:
  - PROJECT_NAME - enter your project name. Use names WITHOUT spaces. 'my_project' as default value
  - PHP_VERSION= php version you'd like to use. Only 5.6 and 7.0 allowed. 5.6 as default value

- run in the Terminal sh inject_docker.sh . It will asks your sudo password once at the begining
- go drink some coffee

#### What's going on.
- inject_docker.sh  will port your project to docker environment according to settings at settings.sh . It will reinstall your project in its own database, so you will get project from the scratch and you ll need to import all your config in your new db.

#### Troubleshooting.
- In some cases, cause of unknown reasons, you can get error during installation. Just re-run inject_docker.sh It will fix anything.
