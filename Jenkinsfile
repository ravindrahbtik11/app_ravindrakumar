pipeline{
    agent any
    environment{
        scannerHome = tool 'sonar_scanner_dotnet'
        username='admin'
        appname='sonar-ravindrakumar'   
        
    }
    options {
        skipDefaultCheckout(true)
    }
    stages{
        stage('Start') {
            steps {
                // Get some code from a GitHub repository sqp_1c72c17192926983467e8beb15cc5bcd1cd19ed4
                echo 'Starting code check out'
                git branch: 'master', url: 'https://github.com/ravindrahbtik11/app_ravindrakumar.git'
                 echo 'Code check out Finished'
            }
        }
    stage('Nuget restore'){
            steps{
                    echo 'Start restoring packages'
                    bat "dotnet restore"
                    echo 'Restore Nuget success'
                }
        }
    stage('Start sonarqube analysis') {
            steps {
                echo 'Start Sonar qube analysis'
                    withSonarQubeEnv('Test_Sonar') {
                    bat "dotnet ${scannerHome}\\SonarScanner.MSBuild.dll begin /k:\"sonar-ravindrakumar\" /d:sonar.login=\"sqp_c18f63960a2505f4912fbde8ae301342d4ef4a84\""
                    }
                echo 'Start Sonar qube analysis'
            }
        }

    stage('Code build'){
            steps {
                echo 'Build solution'
                bat "dotnet build"
                echo 'Build success'
            }
        }

        stage('Test case execution'){
            steps {
                 echo 'test'
                 bat "dotnet test"
            }
        }
        stage('Stop sonarqube analysis') {
                steps {
                echo 'Stopping Sonar Qube analysis'
                  withSonarQubeEnv('Test_Sonar') {
                       bat "dotnet ${scannerHome}\\SonarScanner.MSBuild.dll end /d:sonar.login=\"sqp_c18f63960a2505f4912fbde8ae301342d4ef4a84\""
                    }
                echo 'Stopped Sonar Qube analysis'
                }
            }
        
        stage('Build and Push Docker Image'){
            steps {
                    script{
                         echo 'Start building Docker image'
                          dockerImage = docker.build("ravindrahbtik11/i-ravindrakumar-master:${BUILD_NUMBER}")
                          echo 'Image building done'
                          echo 'Start pushing Docker image'
                          docker.withRegistry( '', 'DockerDetail' ) {
                                 dockerImage.push() 
                            }
                            echo 'Image pushing done'
                        }
                }
         }
       
    }
    post{
        always{
            echo 'I am awsome. I run always'
            //write to logout docker
        }
        success{
            echo 'I run when you are Successful'
        }
        failure{
            echo 'I run when you are fail.'
        }
    //    changed{ squ_dbe138c55e8feccac167c2a053d72b3fe6231deb
    //         echo 'I run when you are fail.'  sqp_c18f63960a2505f4912fbde8ae301342d4ef4a84
    //     }
    }
    
}