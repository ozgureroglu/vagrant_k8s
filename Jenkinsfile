pipeline {
  agent any
  stages {
    stage('teststage') {
      steps {
        sh 'echo teststage'
        sh 'echo step2'
        sh 'echo step3'
      }
    }

    stage('stage2') {
      steps {
        sh 'echo "stage2 step1"'
        sh 'echo "stage2 step2"'
      }
    }

    stage('Steg3') {
      steps {
        sh 'echo "stage3 step1"'
        sh 'echo "stage3 step2"'
      }
    }

  }
}