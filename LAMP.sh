                        sudo apt update
                        sudo apt install -y apache2
                        
                        sudo apt install -y mysql-server
                        
                        sudo apt install -y php libapache2-mod-php php-mysql php-gd php-xml php-curl
                        
                        sudo mysql -e "CREATE DATABASE jpdrupal;"
                        sudo mysql -e "CREATE USER 'jpdrupal'@'localhost' IDENTIFIED BY '12345';"
                        sudo mysql -e "GRANT ALL PRIVILEGES ON jpdrupal.* TO 'jpdrupal'@'localhost';"
                        sudo mysql -e "FLUSH PRIVILEGES;"
                        
                        cd /var/www/html
                        sudo wget https://ftp.drupal.org/files/projects/drupal-10.0.0.tar.gz
                        sudo tar -xzvf drupal-10.0.0.tar.gz
                        sudo mv drupal-10.0.0 drupal

                        
                        sudo chown -R www-data:www-data /var/www/html/drupal
                        sudo chmod -R 755 /var/www/html/drupal
                        
                        sudo systemctl restart apache2

