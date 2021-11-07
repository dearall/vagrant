# adoptjdk11 定义
java::adopt { 'jdk11' :
    ensure  => 'present',
    version => '11',
    java    => 'jdk',
}
