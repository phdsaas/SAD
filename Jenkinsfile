pipeline{
    agent {
        label 'k8s-master'
    }
    stages{
        stage("Clean_Up"){
            steps{
                sh './clean.sh'
            }
        }
        stage("Deploy_DSSC"){
            environment{
                DSSC_SECRET_SEED    = credentials('dssc-secret-seed')
                ACTIVATION_CODE     = credentials('dssc-activation-code')
            }
            steps{
                sh './Dssc/deploy.sh'
                script{
                    env.DSSC_PASS = sh returnStdout: true, script: '''kubectl get secrets -o jsonpath='{ .data.password }' deepsecurity-smartcheck-auth | base64 --decode'''
                }
            }
        }
        stage("Add_ons"){
            steps{
                sh "./Static-service/deploy.sh"
            }
        } 
        stage("Add_Registry"){
            environment{
                DSSC_USER   = credentials('dssc-username')
                AWS_REGION  = credentials('aws-region')
                AWS_AK      = credentials('aws-access-key')
                AWS_SK      = credentials('aws-secret-key')
                AWS_ACCOUNT_ID  = credentials('aws-account-id')
                DSSC_PASS_NEW   = credentials('strong-password')
            }
            steps{
                sh "./API/api.sh"
            }
        }
    }
}
