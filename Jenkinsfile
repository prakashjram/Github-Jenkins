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
                    withCredentials([sshUserPrivateKey(credentialsId: '	mysshprikey', keyFileVariable: 'SSH_KEY')]) {
                        // Add EC2 instance to known hosts and connect
                        sh '''
                            ssh -i ${SSH_KEY} ubuntu@3.7.45.98 "echo 'Connected successfully'"
                        '''
                    }
                }
            }
        }
    }
}
