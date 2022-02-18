package com.manning.gia.ssh

import org.gradle.api.file.FileCollection
import org.gradle.api.file.RegularFileProperty
import org.gradle.api.provider.Property

class SshPluginExtension {
    RegularFileProperty sourceFile
    Property<String>    remoteTempDir
    RegularFileProperty vagrantKeyFile
    Property<Integer>   port

    Property<String>    host
    Property<String>    username
    Property<String>    command

    SshPluginExtension(){

    }
}
