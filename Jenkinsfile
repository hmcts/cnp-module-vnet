#!groovy
@Library('Infrastructure') _
import uk.gov.hmcts.contino.Testing
import uk.gov.hmcts.contino.Tagging

GITHUB_REPO = "github.com:contino/moj-module-vnet.git"

try {
  node {
    platformSetup {

      stage('Checkout') {
        deleteDir()
        checkout scm
      }

      terraform.ini(this)
      stage('Terraform Linting Checks') {
        terraform.lint()
      }

      testLib = new Testing(this)
      stage('Terraform Unit Testing') {
        testLib.unitTest()
      }

      stage('Terraform Integration Testing') {
        testLib.moduleIntegrationTests()
      }

      stage('Tagging') {
        def tag = new Tagging(this)
        printf tag.applyTag(tag.nextTag())
      }
    }
  }
}
catch (err) {
  slackSend(
    channel: '#cnp-build-status',
    color: 'danger',
    message: "${env.JOB_NAME}: <${env.BUILD_URL}console|Build ${env.BUILD_DISPLAY_NAME}> has FAILED")
  throw err
}
