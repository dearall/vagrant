// using '-Pvm=standalone'
// 通过环境变量 vm 指定 Vagrant project directory name, values:puppetserver, dnsmasq, standalone
environments {
    puppetserver {
        targetedVagrantProjectDirname = 'puppetserver'
    }
    dnsmasq {
        targetedVagrantProjectDirname = 'dnsmasq'
    }
    standalone {
        targetedVagrantProjectDirname = 'standalone'
    }
}
