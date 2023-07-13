pipeline {
  agent {
    kubernetes {
      yaml '''
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            jenkins: jenkins-agent
        spec:
          serviceAccountName: jenkins-service-account
          containers:
          - name: jenkins-agent-container
            image: public.ecr.aws/m4u2t0n7/jenkins-agent:latest
            command:
            - cat
            tty: true
            env:
            - name: DOCKER_HOST
              value: 'tcp://localhost:2375'
          - name: dind-daemon
            image: 'docker:18-dind'
            command:
            - dockerd-entrypoint.sh
            tty: true
            securityContext: 
              privileged: true 
        '''
    }
  }
  triggers {
	  // poll repo every 1 minute for changes
	  pollSCM('*/1 * * * *')
  }
  stages {
    stage('Execute on Jenkins agent') {
      steps {
        container('jenkins-agent-container') {
          sh '''
          make run
          make fill-db
          '''
        }
      }
    }
  }
} 