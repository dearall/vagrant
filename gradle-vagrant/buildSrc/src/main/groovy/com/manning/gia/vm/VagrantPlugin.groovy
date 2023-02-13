package com.manning.gia.vm

import org.gradle.api.Plugin
import org.gradle.api.Project

class VagrantPlugin implements Plugin<Project> {

    static final String EXTENSION_NAME = 'vagrant'

    @Override
    void apply(Project project) {
        def extension = project.extensions.create(EXTENSION_NAME, VagrantPluginExtension)
        extension.targetedVagrantProjectDir = project.objects.directoryProperty()

        addTasks(project)
    }

    private void addTasks(Project project) {
        project.tasks.withType(Vagrant).whenTaskAdded { Vagrant task ->
            def extension = project.extensions.findByName(EXTENSION_NAME)

            task.group = 'Vagrant Control'
            task.dir = extension.targetedVagrantProjectDir
        }

        project.tasks.register('vagrantUp', Vagrant) {
            commands = ['up', '--color']
            description = 'starts and provisions the vagrant environment'
        }
        project.tasks.register('vagrantUpNoProvision', Vagrant) {
            commands = ['up', '--color', '--no-provision']
            description = 'starts and no provisions the vagrant environment'
        }
        project.tasks.register('vagrantHalt', Vagrant) {
            commands = ['halt']
            description = 'stops the vagrant machine'
        }
        project.tasks.register('vagrantDestroy', Vagrant) {
            commands = ['destroy', '--force']
            description = 'stops and deletes all traces of the vagrant machine'
        }
        project.tasks.register('vagrantSshConfig', Vagrant) {
            commands = ['ssh-config']
            description = 'outputs OpenSSH valid configuration to connect to the machine'
        }
        project.tasks.register('vagrantStatus', Vagrant) {
            commands = ['status']
            description = 'outputs status of the vagrant machine'
        }
        project.tasks.register('vagrantSuspend', Vagrant) {
            commands = ['suspend']
            description = 'suspends the machine'
        }
        project.tasks.register('vagrantResume', Vagrant) {
            commands = ['resume']
            description = 'resume a suspended vagrant machine'
        }
        project.tasks.register('vagrantReload', Vagrant) {
            commands = ['reload']
            description = 'restarts vagrant machine, loads new Vagrantfile configuration'
        }
        project.tasks.register('vagrantStartTomcat', Vagrant) {
            commands = ['provision', '--provision-with', 'start-tomcat']
            description = 'start remote server tomcat service'
        }
        project.tasks.register('vagrantStopTomcat', Vagrant) {
            commands = ['provision', '--provision-with', 'stop-tomcat']
            description = 'stop remote server tomcat service'
        }
    }
}
