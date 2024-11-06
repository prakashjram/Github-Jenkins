pipeline {
    agent any
    triggers {
        pollSCM('H/5 * * * *') // Polling every 5 minutes
    }
    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the branch you specified in Jenkins job config
                checkout scm
            }
        }
        stage('Build') {
            steps {
                echo "Building the project..."
                // Add build steps here (e.g., compilation, tests)
            }
        }
        stage('Test') {
            steps {
                echo "Running tests..."
                // Add test steps here
            }
        }
        stage('Deploy') {
            steps {
                echo "Deploying the project..."
                // Add deployment steps here
            }
        }
    }
}
