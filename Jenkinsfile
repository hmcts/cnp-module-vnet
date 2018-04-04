#!groovy
@Library('Infrastructure') _

try {
  node {
    env.PATH = "$env.PATH:/usr/local/bin"

    stage('Checkout') {
      deleteDir()
      checkout scm
    }

    stage('Moodule Testing') {
       infraModuleTesting()
    }

  }
}
catch (err) {
  throw err
}

