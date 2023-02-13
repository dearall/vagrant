package com.manning.gia.ssh


import org.gradle.api.file.RegularFileProperty
import org.gradle.api.provider.Property

class SshPluginExtension {

    RegularFileProperty sourceFile
    Property<String>    remoteTempDir

    Property<String>    host
    Property<Integer>   port
    RegularFileProperty vagrantKeyFile
    Property<String>    username

    Property<String>    command
}
