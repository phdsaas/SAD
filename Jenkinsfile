pipeline{
    agent{
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
        stage("Scan_Registry"){
            parallel{
                stage("fake-image"){
                    steps{
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE'){
                            withCredentials([
                                usernamePassword([
                                    credentialsId: "ecr-auth",
                                    usernameVariable: "ACCESS_KEY_ID",
                                    passwordVariable: "SECRET_ACCESS_KEY",
                                ])
                            ]){
                                smartcheckScan([
                                    imageName: "143631420864.dkr.ecr.us-east-2.amazonaws.com/fake-image:latest",
                                    smartcheckHost: "smartcheck.jayveev.tmi:30443",
                                    smartcheckCredentialsId: "smartcheck-auth",
                                    insecureSkipTLSVerify: true,
                                    insecureSkipRegistryTLSVerify: true,
                                    resultsFile: "fake-image.json",
                                    imagePullAuth: new groovy.json.JsonBuilder([
                                        aws: [
                                            region: "us-east-2",
                                            accessKeyID: ACCESS_KEY_ID,
                                            secretAccessKey: SECRET_ACCESS_KEY,
                                        ]
                                    ]).toString(),
                                ])
                            }
                        }
                    }
                }
                stage("alpine-clean"){
                    steps{
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE'){
                            withCredentials([
                                usernamePassword([
                                    credentialsId: "ecr-auth",
                                    usernameVariable: "ACCESS_KEY_ID",
                                    passwordVariable: "SECRET_ACCESS_KEY",
                                ])
                            ]){
                                smartcheckScan([
                                    imageName: "143631420864.dkr.ecr.us-east-2.amazonaws.com/alpine-clean:latest",
                                    smartcheckHost: "smartcheck.jayveev.tmi:30443",
                                    smartcheckCredentialsId: "smartcheck-auth",
                                    insecureSkipTLSVerify: true,
                                    insecureSkipRegistryTLSVerify: true,
                                    resultsFile: "alpine-clean.json",
                                    imagePullAuth: new groovy.json.JsonBuilder([
                                        aws: [
                                            region: "us-east-2",
                                            accessKeyID: ACCESS_KEY_ID,
                                            secretAccessKey: SECRET_ACCESS_KEY,
                                        ]
                                    ]).toString(),
                                ])
                            }
                        }
                    }
                }
            }
        } 
        stage("Diagnostic_Logs"){
            steps{
                sh "./diagnostic.sh"
            }
        }
    }
}
