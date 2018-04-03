#!groovy
@Library('Infrastructure') _

try {
  node {
    env.PATH = "$env.PATH:/usr/local/bin"

    stage('Checkout') {
      deleteDir()
      checkout scm
    }

    stage('Terraform init') {
      sh 'terraform init'
    }

    stage('Terraform Linting Checks') {
      sh 'terraform validate -check-variables=false -no-color'
    }

    stage('Integration tests') {
      sh 'scl enable rh-ruby24 "gem environment && pwd && ls -l"'
      sh 'scl enable rh-ruby24 "gem install bundler && PATH=$PATH:/home/jenkinsssh/bin/ bundle install --path vendor/bundle"'
      sh 'scl enable rh-ruby24 "gem environment"'
    }

  }
}
catch (err) {
  throw err
}

