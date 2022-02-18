binaryRepository {
    baseUrl = 'http://localhost:8081/repository'
    releaseUrl = "${baseUrl}/demo"
}

environments {
    develop {
        server {
            hostname = 'tomcat.sansovo.org'
            sshPort = 22
            username = 'vagrant'
        }
        tomcat {
            hostname = 'tomcat.sansovo.org'
            port = 8080
            context = 'todo'
        }
    }
    test {
        server {
            hostname = 'tomcat-test.sansovo.org'
            sshPort = 22
            username = 'vagrant'
        }
        tomcat {
            hostname = 'tomcat-test.sansovo.org'
            port = 8080
            context = 'todo'
        }
    }
    uat {
        server {
            hostname = 'tomcat-uat.sansovo.org'
            sshPort = 22
            username = 'vagrant'
        }
        tomcat {
            hostname = 'tomcat-uat.sansovo.org'
            port = 8080
            context = 'todo'
        }
    }
    production {
        server {
            hostname = 'tomcat-production.sansovo.org'
            sshPort = 22
            username = 'vagrant'
        }
        tomcat {
            hostname = 'tomcat-production.sansovo.org'
            port = 8080
            context = 'todo'
        }
    }
}