class { 'ntp':
  servers    => ['ntp.aliyun.com','cn.ntp.org.cn','127.127.1.0'],
  interfaces => ['127.0.0.1', '192.168.0.2'],
  restrict   => [
      '-4 default notrap nomodify nopeer noquery',
      '-6 default notrap nomodify nopeer noquery',
      '127.0.0.1',
      '-6 ::1',
      #允许这个网段的对时请求
      '192.168.0.0 mask 255.255.255.0 nomodify',

      #允许上层ntp server的所有权限      
      'ntp.aliyun.com',
      'cn.ntp.org.cn'
  ],
}

include localtime
