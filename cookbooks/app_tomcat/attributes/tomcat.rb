# == Recommended attributes
#
set_unless[:tomcat][:server_name] = "myserver"  
set_unless[:tomcat][:application_name] = "myapp"

# == Optional attributes
#
set_unless[:tomcat][:code][:repo_type] = "git"
set_unless[:tomcat][:code][:url] = ""
set_unless[:tomcat][:code][:credentials] = ""
set_unless[:tomcat][:code][:svn_username] = ""
set_unless[:tomcat][:code][:svn_password] = ""

set_unless[:tomcat][:code][:branch] = "master"
set_unless[:tomcat][:db_adapter] = "mysql"

# this docroot is currently symlinked from /usr/share/tomcat6/webapps
set[:tomcat][:docroot] = "/srv/tomcat6/webapps"

# == Calculated attributes
#
case platform
when "ubuntu", "debian"
  set[:db_mysql][:socket] = "/var/run/mysqld/mysqld.sock"
when "centos","fedora","suse","redhat"
  if node[:platform_version] =~ /5/
    set[:tomcat][:package_dependencies] = ["eclipse-ecj",\
                                           "tomcat6",\
                                           "tomcat6-admin-webapps",\
                                           "tomcat6-webapps",\
                                           "tomcat-native",\
                                           "mysql-connector-java"]
  else
    set[:tomcat][:package_dependencies] = ["ecj",\
                                           "tomcat6",\
                                           "tomcat-native",\
                                           "mysql-connector-java"]
  end

  set[:tomcat][:module_dependencies] = [ "proxy", "proxy_http" ]
  set_unless[:tomcat][:app_user] = "tomcat"
  set[:db_mysql][:socket] = "/var/lib/mysql/mysql.sock"
end
