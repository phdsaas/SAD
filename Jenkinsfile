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
            }
        }
        stage("Add_ons"){
            steps{
                sh "./Static-service/deploy.sh"
            }
        }
        stage("Import_Auth"){
            steps{
                script{
                    env.DSSC_PASS = sh returnStdout: true, script: '''kubectl get secrets -o jsonpath='{ .data.password }' deepsecurity-smartcheck-auth | base64 --decode'''
                }
                echo env.DSSC_PASS
            }
        }
        stage("Scan_Registry"){
            steps{
                echo "====++++executing Scan_Registry++++===="
            }
        }
    }
}
