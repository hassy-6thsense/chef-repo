#
# Cookbook Name:: apache2
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "apache2" do
	case node[ :platform ]
	when "debian", "ubuntu"
		package_name "apache2"
	when "redhat", "centos", "fedora"
		package_name "httpd"
	end
end


template "index.html" do
	case node[ :platform ]
	when "debian", "ubuntu"
		path "/var/www/index.html"
	when "redhat", "centos", "fedora"
		path "/var/www/html/index.html"
	end

	source "index.html.erb"
	mode 0644
	variables( { :fqdn => node[ :fqdn ] } )
end


service "apache2" do
	case node[ :platform ]
	when "debian", "ubuntu"
		service_name "apache2"
	when "redhat", "centos", "fedora"
		service_name "httpd"
	end
	action [ :enable, :start ]
end
