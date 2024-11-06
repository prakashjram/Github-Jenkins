pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                // Clone your repository from GitHub
                git url: 'https://github.com/prakashjram/Github-Jenkins.git', branch: 'main'
            }
        }
        
        stage('Install Apache and Deploy') {
            steps {
                sshagent(['75658dfc-bd67-413f-a38d-90dcb5e69c3a']) {
                    sh '''
                    # SSH into EC2 instance and install Apache (httpd)
                    ssh -o StrictHostKeyChecking=no ubuntu@13.201.168.125 << EOF
                        # Step 1: Update and install Apache (httpd)
                        echo "Updating packages and installing Apache..."
                        sudo apt update -y
                        sudo apt install apache2 -y
                        
                        # Step 2: Check if /var/www/html exists
                        if [ ! -d /var/www/html ]; then
                            echo "/var/www/html does not exist, creating it..."
                            sudo mkdir -p /var/www/html
                        fi

                        # Step 3: Ensure the repo is initialized in /var/www/html
                        cd /var/www/html || exit 1
                        if [ ! -d .git ]; then
                            echo "Initializing Git repository in /var/www/html..."
                            sudo git init
                            sudo git remote add origin https://github.com/prakashjram/Github-Jenkins.git
                        fi

                        # Step 4: Pull latest code from GitHub
                        echo "Pulling latest code from GitHub..."
                        sudo git pull origin main
                        
                        # Step 5: Restart Apache to apply changes
                        echo "Restarting Apache service..."
                        sudo systemctl restart apache2

                        echo "Deployment complete!"
                    EOF
                    '''
                }
            }
        }
    }
    post {
        failure {
            echo 'Deployment failed.'
        }
        success {
            echo 'Deployment was successful!'
        }
    }
}
