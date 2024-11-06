pipeline {
    agent any
    
    environment {
        EC2_IP = '13.201.168.125'  // Replace with your EC2 instance IP
        EC2_USER = 'ubuntu'    // Replace with your EC2 instance's SSH user
        SSH_KEY = '/home/ubuntu/.ssh/jpdrpl.pem'  // Path to your SSH private key
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
                    // Run SSH command to deploy directly in EC2
                    sh """
                    ssh -i ${SSH_KEY} ${EC2_USER}@${EC2_IP} << 'EOF'
                    echo "Deployment started on EC2"
                    # Add other deployment commands here as needed
                    EOF
                    """
                }
            }
        }
    }
}
