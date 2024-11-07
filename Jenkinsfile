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
                        // Add EC2 instance to known hosts and connect
                        sh '''
                            ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ${EC2_USER}@${EC2_IP} "echo 'Connected successfully'"
                            
                            sudo apt update
                            sudo apt install apache2 -y
                            sudo apt install mysql-server -y
                            sudo mysql -u root -p
                            CREATE DATABASE jpdrupal;
                            CREATE USER 'jpdrupal'@'localhost' IDENTIFIED BY '12345';
                            GRANT ALL PRIVILEGES ON jpdrupal.* TO 'jpdrupal'@'localhost';
                            FLUSH PRIVILEGES;
                            
                            
                            sudo apt install php php-mysql php-gd php-xml php-mbstring -y
                            
                            
                            cd /var/www/html
                            sudo wget https://ftp.drupal.org/files/projects/drupal-10.0.0.tar.gz
                            sudo tar -xzvf drupal-10.0.0.tar.gz
                            sudo mv drupal-10.0.0 drupal
                            
                            sudo chown -R www-data:www-data /var/www/html/drupal
                            sudo chmod -R 755 /var/www/html/drupal
                            
                            sudo systemctl restart apache2
                            
                            echo "LAMP stack and Drupal 10 setup complete."
                        
                        '''
                    }
                }
            }
        }
    }
}


