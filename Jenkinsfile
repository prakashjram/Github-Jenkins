pipeline {
    agent any
    environment {
        SSH_CREDENTIALS_ID = '75658dfc-bd67-413f-a38d-90dcb5e69c3a'  // Replace with your Jenkins SSH credentials ID
    }
    stages {
        stage('Checkout Code') {
            steps {
                // Checking out code from your Git repository
                git url: 'https://github.com/prakashjram/Github-Jenkins.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                // Add any build steps here if required
                echo 'Building the application...'
                // Example: sh 'mvn clean install'  // Uncomment if using Maven for Java apps
            }
        }
        stage('Deploy to EC2') {
            steps {
                script {
                    // Use SSH credentials to access EC2 instance
                    sshagent([SSH_CREDENTIALS_ID]) {
                        // Connecting to the EC2 instance and executing deployment commands
                        sh '''
                            ssh -o StrictHostKeyChecking=no ubuntu@13.201.168.125 '                           
                                cd /var/www/html  # Adjust the path if your deployment folder is different
                                git pull origin main  # Pulls the latest code from your repository
                                sudo systemctl restart httpd  # Restarts Apache server to apply changes
                            '
                        '''
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'Deployment was successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
