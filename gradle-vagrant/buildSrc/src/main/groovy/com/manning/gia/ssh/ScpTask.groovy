package com.manning.gia.ssh

import org.gradle.api.DefaultTask
import org.gradle.api.file.FileCollection
import org.gradle.api.file.RegularFileProperty
import org.gradle.api.provider.Property
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.InputFile
import org.gradle.api.tasks.InputFiles
import org.gradle.api.tasks.TaskAction

abstract class ScpTask extends DefaultTask {

    @InputFiles
    FileCollection classpath

    @Input
    abstract Property<String> getHost()

    @Input
    abstract Property<Integer> getPort()

    @Input
    abstract Property<String>  getUsername()

    @InputFile
    abstract RegularFileProperty getSourceFile()

    @Input
    abstract Property<String> getDestination()

    @InputFile
    abstract RegularFileProperty getKeyFile()

    @TaskAction
    void runCommand() {
        logger.quiet "scp file '${sourceFile.getAsFile().get().getAbsolutePath()}' to server"
        logger.quiet "scp file todir: '${destination.get()}'"
        logger.quiet "scp file host: '${host.get()}'"
        logger.quiet "scp file port: '${port.get()}'"
        logger.quiet "scp file username: '${username.get()}'"
        logger.quiet "scp file keyfile: '${keyFile.getAsFile().get().getAbsolutePath()}'"

        ant.taskdef(name: 'jschScp', classname: 'org.apache.tools.ant.taskdefs.optional.ssh.Scp', classpath: classpath.asPath)
        ant.jschScp(
                host: host.get(),
                port: port.get(),
                username: username.get(),
                keyfile: keyFile.getAsFile().get().getAbsolutePath(),
                file: sourceFile.getAsFile().get().getAbsolutePath(),
                todir: destination.get(),
                trust: true)
    }
}