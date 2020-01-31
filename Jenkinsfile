pipeline{
    agent {
        label 'k8s-master'
    }
    stages{
        stage("Latest_Chart"){
            steps{
                sh './Latest/get.sh'
            }
        }
        stage("Add_NodePort"){
            steps{
                sh './Latest/nodeport.sh'
            }
        }
        stage("Upgrade_DSSC"){
            steps{
                sh './Dssc/deploy.sh'
            }
        }
        stage("Add_registry"){
            steps{
                echo "====++++executing Add_registry++++===="
            }
        }
        stage("Scan_Registry"){
            steps{
                echo "====++++executing Scan_Registry++++===="
            }
        }
    }
}
