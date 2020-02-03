pipeline{
    agent {
        label 'k8s-master'
    }
    environment{
        DSSC_SECRET_SEED    = credentials('dssc-secret-seed')
        ACTIVATION_CODE     = credentials('dssc-activation-code')
    }
    stages{
        stage("Clean_Up"){
            steps{
                sh './clean.sh'
            }
        }
        stage("Deploy_DSSC"){
            steps{
                sh './Dssc/deploy.sh'
            }
        }
        stage("Add_ons"){
            steps{
                sh "./Static-service/deploy.sh"
            }
        }
        stage("Scan_Registry"){
            steps{
                echo "====++++executing Scan_Registry++++===="
            }
        }
    }
}
