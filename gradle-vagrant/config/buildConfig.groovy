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
            catalina_home = '/opt/tomcat9'
            catalina_base = '/opt/tomcat9'
            JAVA_HOME='/usr/lib/jvm/jdk-11.0.13+8'
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
            catalina_home = '/opt/tomcat9'
            catalina_base = '/opt/tomcat9'
            JAVA_HOME='/usr/lib/jvm/jdk-11.0.13+8'
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
            catalina_home = '/opt/tomcat9'
            catalina_base = '/opt/tomcat9_base'
            JAVA_HOME='/usr/lib/jvm/jdk-11.0.13+8'
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
            catalina_home = '/opt/tomcat9'
            catalina_base = '/opt/tomcat9_base'
            JAVA_HOME='/usr/lib/jvm/jdk-11.0.13+8'
        }
    }
}