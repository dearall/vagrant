package com.manning.gia.vm

import org.gradle.api.Project
import org.gradle.api.Task
import org.gradle.testfixtures.ProjectBuilder
import spock.lang.Specification
class VagrantSpec extends Specification {
    static final TASK_NAME = 'vagrantStatus'
    Project project

    def setup() {
        project = ProjectBuilder.builder().build()
    }

    def "Adds vagrantStatus task"() {
        expect:
        project.tasks.findByName(TASK_NAME) == null
        when:
        project.tasks.register(TASK_NAME, Vagrant) {
            commands = ['status']
            dir = project.objects.directoryProperty()
            dir.set(project.file('../standalone/develop/tomcat'))
        }
        then:
        Task task = project.tasks.findByName(TASK_NAME)
        task != null
    }
}
