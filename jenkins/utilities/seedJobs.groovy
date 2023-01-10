def gitType = System.getenv('ENVIRONMENT') == 'prod' ? 'PT_TAG' : 'PT_BRANCH_TAG'



freeStyleJob('seedJobs') {
  label('seed-job')
  displayName('Seed Jobs - Global')
  description('Seed jobs available to Jenkins')
  logRotator {
    numToKeep(5)
    artifactNumToKeep(1)
  }
  triggers {
    hudsonStartupTrigger {
      quietPeriod('5')
      runOnChoice('ON_CONNECT')
      label('bult-in')
      nodeParameterName('')
    }
  }
  scm {
    git {
      remote {
        github('sverh99/devops-project', 'https')
      }
      branches('main')
    }
  }
  steps {
    action = System.getenv('ENVIRONMENT') == 'test' ? 'IGNORE' : 'DELETE'
    dsl {
      external('/jenkins/pipeline.groovy')
      removeAction(action)
      removeViewAction(action)
    }
  }
}