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
      withSubscription('sandbox') {
        sh 'sudo yum install -y rh-ruby24-ruby-devel'
        sh 'scl enable rh-ruby24 "gem install bundler && export PATH=$PATH:/home/jenkinsssh/bin/; bundle install --path vendor/bundle; cd tests/int; bundle exec kitchen test"'
      }
    }

  }
}
catch (err) {
  throw err
}

