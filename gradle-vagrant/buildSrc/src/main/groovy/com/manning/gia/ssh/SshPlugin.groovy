package com.manning.gia.ssh

import org.gradle.api.Plugin
import org.gradle.api.Project

class SshPlugin implements Plugin<Project> {
    static final String EXTENSION_NAME = 'ssh'

    @Override
    void apply(Project project) {
        project.configurations {
            jsch
        }
        project.dependencies {
            jsch  'org.apache.ant:ant-jsch:1.10.12'
        }
        project.repositories {
            mavenCentral()
        }
        def extension = project.extensions.create(EXTENSION_NAME, SshPluginExtension)

        extension.sourceFile = project.objects.fileProperty()
        extension.vagrantKeyFile = project.objects.fileProperty()
        extension.remoteTempDir = project.objects.property(String)
        extension.port = project.objects.property(Integer)

        extension.host = project.objects.property(String)
        extension.username = project.objects.property(String)
        extension.command = project.objects.property(String)

        //extension.tomcatRemoteDir = project.objects.property(String)

        addTasks(project)
    }
    private void addTasks(Project project) {
        def extension = project.extensions.findByName(EXTENSION_NAME)

        project.tasks.withType(ScpTask).whenTaskAdded { ScpTask task ->
            task.group = 'SSH Deploy'

            classpath = project.configurations.jsch

            host = extension.host
            port = extension.port

            username = extension.username
            keyFile = extension.vagrantKeyFile
        }
        project.tasks.withType(SshExecTask).whenTaskAdded { SshExecTask task ->
            task.group = 'SSH Deploy'

            classpath = project.configurations.jsch

            host = extension.host
            port = extension.port

            username = extension.username
            keyFile = extension.vagrantKeyFile

            command = extension.command
        }

        project.tasks.register('copyWarToServer', ScpTask) {
            description = 'scp copy war file to remote web server'

            sourceFile = extension.sourceFile
            destination = extension.remoteTempDir
        }

        // ??? ssh ?????????????????? tomcat
        project.tasks.register('shutdownTomcat', SshExecTask) {
//          def tomcatRemoteDir = extension.tomcatRemoteDir.get()
//          command.set("sudo -u tomcat ${extension.tomcatRemoteDir}/bin/shutdown.sh")
            description '??? ssh ?????????????????? tomcat'

            doFirst {
                logger.quiet "Shutting down remote Tomcat."
            }
        }

        //??? vagrant apply puppet ???????????? tomcat
        project.tasks.register('stopTomcat') {
            group 'SSH Deploy'
            description '??? vagrant apply puppet ???????????? tomcat'

            doFirst {
                logger.quiet "stopping remote tomcat."
            }
        }

        project.tasks.register('deleteTomcatWebappsDir', SshExecTask) {
            description "delete war file from tomcat 'webapp' directory"
            //dependsOn(project.tasks.named('shutdownTomcat'))
            //dependsOn(project.tasks.named('stopTomcat'))
//            def tomcatRemoteDir = extension.tomcatRemoteDir.get()
//            command.set("sudo -u tomcat rm -rf ${extension.tomcatRemoteDir}/webapps/todo")
        }
        project.tasks.register('deleteTomcatWorkDir', SshExecTask) {
            description "delete tomcat 'work' directoy"
            //dependsOn(project.tasks.named('shutdownTomcat'))
            //dependsOn(project.tasks.named('stopTomcat'))
        }

        project.tasks.register('deleteOldArtifacts') {
            group = 'SSH Deploy'
            description = 'delete tomcat web appsdir and tomcat work dir'

            dependsOn(project.tasks.named('deleteTomcatWebappsDir'), project.tasks.named('deleteTomcatWorkDir'))
        }

        project.tasks.register('copyWarToWebappsDir', SshExecTask) {
            dependsOn(project.tasks.named('deleteOldArtifacts'))

            doFirst {
                logger.quiet "Deploying WAR file to Tomcat."
            }
        }

        // ??? ssh ?????????????????? tomcat
        project.tasks.register('startupTomcat', SshExecTask) {
            dependsOn(project.tasks.named('copyWarToWebappsDir'))

            description '??? ssh ?????????????????? tomcat'

            doFirst {
                logger.quiet "Starting up remote Tomcat."
            }
        }

        //??? vagrant apply puppet ???????????? tomcat
        project.tasks.register('startTomcat') {
            group 'SSH Deploy'
            description '??? vagrant apply puppet ???????????? tomcat'

            dependsOn(project.tasks.named('copyWarToWebappsDir'))

            doFirst {
                logger.quiet "Starting remote Tomcat."
            }
        }

        project.tasks.register('deployWar') {
            //dependsOn(project.tasks.named('startupTomcat'))
            //dependsOn(project.tasks.named('startTomcat'))

            group = 'SSH Deploy'
            description = 'deploy war file to remote tomcat server'
        }
    }
}
