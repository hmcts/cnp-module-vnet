#!groovy
@Library('Infrastructure') _

try {
  node {
    env.PATH = "$env.PATH:/usr/local/bin"

    stage('Checkout') {
      deleteDir()
      checkout scm
    }

    stage('Module Testing') {
       infraModuleTesting()
    }

  }
}
catch (err) {
  throw err
}

