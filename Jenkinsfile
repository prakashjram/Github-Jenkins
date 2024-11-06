pipeline {
    agent any
    environment {
        EC2_INSTANCE_IP = '13.201.168.125'
        SSH_CREDENTIALS_ID = '75658dfc-bd67-413f-a38d-90dcb5e69c3a'  // Use the credential ID you set up in Jenkins
        REMOTE_PATH = '/var/www/html'      // Path on EC2 where the app code should be deployed
    }
    stages {
        stage('Checkout Code') {
            steps {
                // Check out the latest code from your Git repository
                checkout scm
            }
        }
        stage('Deploy to EC2') {
            steps {
                sshagent(credentials: [SSH_CREDENTIALS_ID]) {
                    sh """
                    # Copy the code from Jenkins workspace to the EC2 instance
                    scp -o StrictHostKeyChecking=no -r * ec2-user@${EC2_INSTANCE_IP}:${REMOTE_PATH}
                    
                    # Connect to EC2 and restart any required services
                    ssh -o StrictHostKeyChecking=no ec2-user@${EC2_INSTANCE_IP} << EOF
                    sudo systemctl restart httpd   # Restart Apache (adjust if using Nginx or other service)
                    EOF
                    """
                }
            }
        }
    }
}
