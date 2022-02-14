binaryRepository {
    baseUrl = 'http://localhost:8081/repository'
    releaseUrl = "${baseUrl}/demo"
}

environments {
    local {
        server {
            hostname = 'localhost'
            sshPort = 2222
            username = 'vagrant'
        }
        tomcat {
            hostname = 'localhost'
            port = 8080
            context = 'todo'
        }
    }
    uat {
        server {
            hostname = 'localhost'
            sshPort = 2223
            username = 'vagrant'
        }
        tomcat {
            hostname = 'localhost'
            port = 8080
            context = 'todo'
        }
    }
    production {
        server {
            hostname = 'localhost'
            sshPort = 2224
            username = 'vagrant'
        }
        tomcat {
            hostname = 'localhost'
            port = 8080
            context = 'todo'
        }
    }
}