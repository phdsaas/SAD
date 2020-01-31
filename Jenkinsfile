pipeline{
    agent any
    stages{
        stage("Latest_Chart"){
            steps{
                sh './Latest/get.sh'
            }
        }
        stage("Add_NodePort"){
            steps{
                sh 'nodeport.sh'
            }
        }
        stage("Upgrade_DSSC"){
            steps{
                echo "====++++executing A++++===="
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
