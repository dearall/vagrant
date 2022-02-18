package com.manning.gia.vm

import com.manning.gia.vm.VagrantPlugin
import org.gradle.api.Project
import org.gradle.testfixtures.ProjectBuilder
import spock.lang.Specification

class VagrantPluginSpec extends Specification{
    static final TASK_NAME = 'vagrantStatus'
    Project project

    def setup() {
        project = ProjectBuilder.builder().build()
    }
    def "Applies plugin and sets extension values"() {
        expect:
        project.tasks.findByName(TASK_NAME) == null

        when:
        project.apply plugin: 'com.manning.gia.vagrant-plugin'

        project.vagrant {
            targetedVagrantProjectDir = file('../standalone/develop/tomcat')
        }
        then:
        project.plugins.hasPlugin(VagrantPlugin)
        project.extensions.findByName(VagrantPlugin.EXTENSION_NAME) != null
    }
}
