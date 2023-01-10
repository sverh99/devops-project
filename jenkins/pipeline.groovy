pipelineJob('simple-node-js-react-npm-app') {
  displayName('simple-node-js-react-npm-app')
  logRotator {
    numToKeep(5)
  }
  definition {
    cpsScm {
      scm {
        git {
          remote {
            github('jenkins-docs/simple-node-js-react-npm-app')
          }
          branches('master')
        }
      }
      scriptPath('jenkins/Jenkinsfile')
    }
  }
}