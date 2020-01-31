pipeline{
    agent any
    stages{
        stage("Latest_Chart"){
            steps{
                sh ./Latest/deploy.sh
            }
        }
        stage("Add_NodePort"){
            steps{
                echo "====++++executing A++++===="
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
