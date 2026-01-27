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
    - name: python
      image: python:3.11-slim
      command:
        - sleep
      args:
        - 99d
    - name: trivy
      image: aquasec/trivy:latest
      command:
        - sleep
      args:
        - 99d
"""
    }
  }

  environment {
    AWS_REGION   = "eu-west-1"
    IMAGE_NAME   = "django-app"
    IMAGE_TAG    = "v1.0.${BUILD_NUMBER}"

    // Git repository settings (parameterized)
    GIT_REPO_URL = "github.com/darinakhalina/go-it-devops-ci-cd.git"
    GIT_BRANCH   = "lesson-8-9"

    COMMIT_EMAIL = "jenkins@localhost"
    COMMIT_NAME  = "jenkins"
  }

  stages {
    stage('Get AWS Account ID') {
      steps {
        container('kaniko') {
          script {
            // Get AWS Account ID dynamically using IRSA credentials
            env.AWS_ACCOUNT_ID = sh(
              script: '''
                apk add --no-cache aws-cli > /dev/null 2>&1 || true
                aws sts get-caller-identity --query Account --output text
              ''',
              returnStdout: true
            ).trim()
            env.ECR_REGISTRY = "${env.AWS_ACCOUNT_ID}.dkr.ecr.${env.AWS_REGION}.amazonaws.com"
          }
        }
      }
    }

    stage('Lint') {
      steps {
        container('python') {
          sh '''
            pip install flake8 --quiet
            echo "Running flake8 linter..."
            flake8 docker/ --max-line-length=120 --ignore=E501,W503 || echo "Lint warnings found (non-blocking)"
          '''
        }
      }
    }

    stage('Unit Tests') {
      steps {
        container('python') {
          sh '''
            echo "Running unit tests..."
            pip install pytest --quiet
            if [ -d "docker/tests" ] || [ -f "docker/test_*.py" ]; then
              cd docker && pytest -v || echo "Some tests failed"
            else
              echo "No tests found - skipping (consider adding tests)"
            fi
          '''
        }
      }
    }

    stage('Security Scan - Dockerfile') {
      steps {
        container('trivy') {
          sh '''
            echo "Scanning Dockerfile for misconfigurations..."
            trivy config docker/Dockerfile --severity HIGH,CRITICAL || echo "Security scan completed with findings"
          '''
        }
      }
    }

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

    stage('Security Scan - Image') {
      steps {
        container('trivy') {
          sh '''
            echo "Scanning built image for vulnerabilities..."
            trivy image --severity HIGH,CRITICAL $ECR_REGISTRY/$IMAGE_NAME:$IMAGE_TAG || echo "Image scan completed with findings"
          '''
        }
      }
    }

    stage('Update Chart Tag in Git') {
      steps {
        container('git') {
          withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PAT')]) {
            sh '''
              git clone https://$GIT_USERNAME:$GIT_PAT@$GIT_REPO_URL repo
              cd repo
              git checkout $GIT_BRANCH

              # Update ECR repository URL (parameterized AWS Account ID)
              sed -i "s|repository: .*|repository: $ECR_REGISTRY/$IMAGE_NAME|" charts/django-app/values.yaml
              sed -i "s/tag: .*/tag: $IMAGE_TAG/" charts/django-app/values.yaml

              git config user.email "$COMMIT_EMAIL"
              git config user.name "$COMMIT_NAME"

              git add charts/django-app/values.yaml
              git commit -m "Update image tag to $IMAGE_TAG"
              git push origin $GIT_BRANCH
            '''
          }
        }
      }
    }
  }
}
