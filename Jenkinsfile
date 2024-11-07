pipeline { 
    agent any

    environment {
        EC2_IP = '3.7.45.98'
        EC2_USER = 'ubuntu'
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
                    withCredentials([sshUserPrivateKey(credentialsId: 'mysshprikey', keyFileVariable: 'SSH_KEY')]) {
                        sh '''
                            ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ${EC2_USER}@${EC2_IP} <<EOF
                                
                                sudo apt update
                                sudo apt install -y apache2 mysql-server php php-mysql php-gd php-xml php-mbstring
                                
                                # MySQL setup for Drupal
                                sudo mysql -e "
                                    CREATE DATABASE jpdrupal;
                                    CREATE USER 'jpdrupal'@'localhost' IDENTIFIED BY '12345';
                                    GRANT ALL PRIVILEGES ON jpdrupal.* TO 'jpdrupal'@'localhost';
                                    FLUSH PRIVILEGES;
                                "
                                
                                # Download and set up Drupal
                                cd /var/www/html
                                sudo wget https://ftp.drupal.org/files/projects/drupal-10.0.0.tar.gz
                                sudo tar -xzvf drupal-10.0.0.tar.gz
                                sudo mv drupal-10.0.0 drupal
                                sudo chown -R www-data:www-data /var/www/html/drupal
                                sudo chmod -R 755 /var/www/html/drupal

                                # Restart Apache
                                sudo systemctl restart apache2
                                
                                echo "LAMP stack and Drupal 10 setup complete."
                            EOF
                        '''
                    }
                }
            }
        }
    }
}
