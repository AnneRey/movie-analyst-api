pipeline {
  def app
  agent {
    label 'devops'
  }

  stages {
    
    stage('Preparation') {
        git "https://github.com/AnneRey/movie-analyst-api.git"
        sh "cd movie-analyst-api"
        sh "git checkout developer"
    }
    stage('Build') {
        app = docker.build("localhost:5000/backimage")
    }
    stage('Test') {
        app.inside {
            sh 'node test.js'
        }
    }
    stage('Push image') {
        sh "docker push localhost:5000/backimage"
        sh "curl localhost:5000/v2/_catalog"
    }
    stage('Deploy with ansible: back') {
      steps {
        withCredentials(bindings: [[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
          sh 'echo $AWS_ACCESS_KEY_ID'
          sh 'echo $AWS_SECRET_ACCESS_KEY'
          sh 'pwd'
          sh 'ls'
          sh 'printenv'
          sh 'curl http://localhost:5000/v2/_catalog'
          sh 'ansible-playbook -i inventory/aws.aws_ec2.yml playbook-deploy.yml --private-key /home/ubuntu/aws'
        }
      }
    }
  }
}