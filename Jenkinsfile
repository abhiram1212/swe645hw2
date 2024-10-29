

@NonCPS
def generateTag() {
    return new Date().format('yyyyMMdd-HHmmss')
}
// Pipeline Stages
pipeline {
    environment {
        registry = 'abhiram1212'
        registryCredential = 'docker-cred'
        KUBECONFIG = '/home/Jenkins/.kube/config'
    }
    agent any

    stages {
        //  Build Stage
        stage('Build') {
            steps {
                script {
                    checkout scm
                    sh 'rm -rf *.war'
                    sh 'jar -cvf surveyform.war -C src/main/webapp/ . '
                    // sh 'echo ${BUILD TIMESTAMP}'
                    tag = generateTag()
                    sh 'echo $tag'
                }
            }
        }
        stage('Docker Build') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        def customImage = docker.build('abhiram1212/survey645:' + tag)
                    }
                }
            }
        }
        // Push to DockerHub Stage
        stage('Push to Docker Hub') {
            steps {
                script {
                    // sh 'echo ${BUILD_TIMESTAMP}'
                    docker.withRegistry('', registryCredential) {
                        def image = docker.build('abhiram1212/survey645:' + tag, '.')
                        docker.withRegistry('', registryCredential) {
                            image.push()
                        }
                    }
                }
            }
        }
        stage('Kubectl Get All Nodes') {
            steps {
                script {
                    sh 'kubectl get deployments'
                }
            }
        }

        // Deploying Rancher to single node
        stage('Deploying Rancher to single node') {
            steps {
                script {
                	//sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl set image deployment/swe645-deployment -n swe645-namespace container-0=abhiram1212/survey642:' + tag
                }
            }
        }
    }
}
