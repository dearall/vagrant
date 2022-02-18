package com.manning.gia.ssh

import org.gradle.api.DefaultTask
import org.gradle.api.GradleException
import org.gradle.api.provider.Property
import org.gradle.api.file.FileCollection
import org.gradle.api.file.RegularFileProperty
import org.gradle.api.tasks.*

abstract class ScpTask extends DefaultTask {
    @InputFiles
    FileCollection classpath

    @InputFile
    abstract RegularFileProperty getSourceFile()

    @Input
    abstract Property<String> getDestination()

    @InputFile
    abstract RegularFileProperty getKeyFile()

    @Input
    abstract Property<Integer> getPort()

    @TaskAction
    void runCommand() {
        logger.quiet "Copying file '${sourceFile.getAsFile().get().getAbsolutePath()}' to server."

        ant.taskdef(name: 'jschScp', classname: 'org.apache.tools.ant.taskdefs.optional.ssh.Scp', classpath: classpath.asPath)
        ant.jschScp(file: sourceFile.getAsFile().get().getAbsolutePath(),
                todir: destination.get(),
                keyfile: keyFile.getAsFile().get().getAbsolutePath(),
                port: port.get(), trust: true)
    }
}