class nginx {
	file { '/etc/yum.repos.d/nginx.repo':
	  ensure => file,
	  owner  => 'root',
	  group  => 'root',
	  mode   => '0644',
	  source => 'puppet:///modules/nginx/nginx.repo',
	}
	->
	exec { 'install nginx':
	  path => "/usr/bin",
	  command => 'sudo yum install nginx -y',
	  timeout => 750,
	}
	->
	file { '/etc/nginx/nginx.conf':
	  ensure => file,
	  owner  => 'root',
	  group  => 'root',
	  mode   => '0644',
	  source => 'puppet:///modules/nginx/nginx.conf',
	}
	->
	file { '/etc/nginx/conf.d/default.conf':
	  ensure => file,
	  owner  => 'root',
	  group  => 'root',
	  mode   => '0644',
	  source => 'puppet:///modules/nginx/default.conf',
	}
	->
    exec { 'start nginx':
	  path => "/usr/bin",
	  command => 'sudo service nginx start'
	}
	->
	exec {
	    'start nginx on load':
	        command     => 'sudo chkconfig nginx on',
	        logoutput   => on_failure,
	        path   		=> "/usr/bin",
	}
}