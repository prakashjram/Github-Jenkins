pipeline {
    agent any
    
    environment {
        EC2_IP = '3.7.45.98'  // Replace with your EC2 instance IP
        EC2_USER = 'ubuntu'    // Replace with your EC2 instance's SSH user
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/prakashjram/Github-Jenkins.git'
            }
        }
        
        stage('Deploy to EC2') {
            steps {
                script {
                    // Use SSH credentials stored in Jenkins
                    withCredentials([sshUserPrivateKey(credentialsId: 'mysshprikey', keyFileVariable: 'SSH_KEY')]) {
                        // SSH into EC2 instance and install LAMP stack and Drupal 10
                        sh '''
                            ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ${EC2_USER}@${EC2_IP} <<EOF
                                # Update the package index
                                sudo apt update -y

                                # Install Apache
                                sudo apt install apache2 -y

                                # Install MySQL (you may be prompted to set a root password)
                                sudo apt install mysql-server -y
                                sudo mysql_secure_installation

                                # Install PHP and required extensions
                                sudo apt install php libapache2-mod-php php-mysql php-xml php-gd php-curl -y

                                # Restart Apache to load PHP module
                                sudo systemctl restart apache2

                                # Download and extract Drupal 10
                                cd /tmp
                                curl -O https://ftp.drupal.org/files/projects/drupal-10.0.0.tar.gz
                                tar -xzvf drupal-10.0.0.tar.gz

                                # Move Drupal files to Apache's root directory
                                sudo mv drupal-10.0.0 /var/www/html/drupal

                                # Set proper permissions
                                sudo chown -R www-data:www-data /var/www/html/drupal
                                sudo chmod -R 755 /var/www/html/drupal

                                # Create a MySQL database and user for Drupal
                                sudo mysql -u root -e "CREATE DATABASE drupal;"
                                sudo mysql -u root -e "CREATE USER 'drupaluser'@'localhost' IDENTIFIED BY '12345';"
                                sudo mysql -u root -e "GRANT ALL ON drupal.* TO 'drupaluser'@'localhost';"
                                sudo mysql -u root -e "FLUSH PRIVILEGES;"

                                echo "LAMP stack and Drupal 10 setup complete."
                            EOF
                        '''
                    }
                }
            }
        }
    }
}
