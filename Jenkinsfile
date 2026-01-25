// TODO: Jenkins CI/CD Pipeline
// This file will contain the pipeline for:
// 1. Building Docker image with Kaniko
// 2. Pushing to ECR
// 3. Updating Helm chart tag in Git

pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: jenkins-kaniko
spec:
  serviceAccountName: jenkins-sa
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.16.0-debug
      imagePullPolicy: Always
      command:
        - sleep
      args:
        - 99d
    - name: git
      image: alpine/git
      command:
        - sleep
      args:
        - 99d
"""
    }
  }

  environment {
    // TODO: Update with your ECR registry URL
    ECR_REGISTRY = "YOUR_ACCOUNT_ID.dkr.ecr.eu-west-1.amazonaws.com"
    IMAGE_NAME   = "django-app"
    IMAGE_TAG    = "v1.0.${BUILD_NUMBER}"

    COMMIT_EMAIL = "jenkins@localhost"
    COMMIT_NAME  = "jenkins"
  }

  stages {
    stage('Build & Push Docker Image') {
      steps {
        container('kaniko') {
          sh '''
            /kaniko/executor \
              --context `pwd`/docker \
              --dockerfile `pwd`/docker/Dockerfile \
              --destination=$ECR_REGISTRY/$IMAGE_NAME:$IMAGE_TAG \
              --cache=true
          '''
        }
      }
    }

    stage('Update Chart Tag in Git') {
      steps {
        container('git') {
          withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PAT')]) {
            sh '''
              # TODO: Update with your repo URL
              git clone https://$GIT_USERNAME:$GIT_PAT@github.com/$GIT_USERNAME/go-it-devops-ci-cd.git repo
              cd repo
              git checkout lesson-8-9

              sed -i "s/tag: .*/tag: $IMAGE_TAG/" charts/django-app/values.yaml

              git config user.email "$COMMIT_EMAIL"
              git config user.name "$COMMIT_NAME"

              git add charts/django-app/values.yaml
              git commit -m "Update image tag to $IMAGE_TAG"
              git push origin lesson-8-9
            '''
          }
        }
      }
    }
  }
}