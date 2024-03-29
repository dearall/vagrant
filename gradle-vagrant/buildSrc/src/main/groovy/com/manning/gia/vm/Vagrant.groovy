package com.manning.gia.vm

import org.gradle.api.DefaultTask
import org.gradle.api.GradleException
import org.gradle.api.file.DirectoryProperty
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.InputDirectory
import org.gradle.api.tasks.TaskAction

abstract class Vagrant extends DefaultTask {

    static final String VAGRANT_EXECUTABLE = 'vagrant'

    @Input
    List<String> commands

    @InputDirectory
    abstract DirectoryProperty getDir()

    @TaskAction
    void runCommand() {
        commands.add(0, VAGRANT_EXECUTABLE)
        logger.quiet "Executing Vagrant command: '${commands.join(' ')}'"
        logger.quiet "Vagrant project dir: ${dir.get().asFile}"

        def process = commands.execute(null, dir.get().asFile)
        process.consumeProcessOutput(System.out, System.err)
        process.waitFor()

        if (process.exitValue() != 0) {
            throw new GradleException()
        }
    }
}