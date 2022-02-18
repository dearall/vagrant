package com.manning.gia.ssh

import org.gradle.api.DefaultTask
import org.gradle.api.GradleException
import org.gradle.api.file.FileCollection
import org.gradle.api.file.RegularFileProperty
import org.gradle.api.provider.Property
import org.gradle.api.tasks.*

abstract class SshExecTask extends DefaultTask {
    @InputFiles
    FileCollection classpath

    @Input
    abstract Property<String> getHost()

    @Input
    abstract Property<String>  getUsername()

    @Input
    abstract Property<String>  getCommand()

    @InputFile
    abstract RegularFileProperty getKeyFile()

    @Input
    abstract Property<Integer>   getPort()

    @TaskAction
    void runCommand() {
        logger.quiet "Executing SSH command '${command.get()}'."

        ant.taskdef(name: 'jschSshExec', classname: 'org.apache.tools.ant.taskdefs.optional.ssh.SSHExec', classpath: classpath.asPath)
        ant.jschSshExec(host: host.get(),
                username: username.get(),
                command: command.get(),
                port: port.get(),
                keyfile: keyFile.getAsFile().get().getAbsolutePath(),
                trust: true)
    }
}