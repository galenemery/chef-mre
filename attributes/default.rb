# Common Attributes
default['chef-mre']['ssh-key'] = ['C:/users/Chef/.ssh/galen-sa-east.pem', 'galen-sa-east.pem', 'galen-sa-east']
default['chef-mre']['domain_prefix'] = ''
default['chef-mre']['domain'] = 'offline'
default['chef-mre']['admin-user'] = 'ec2-user'

# Chef Server Attributes
default['chef-mre']['chef-server']['hostname'] = 'chef-server'
default['chef-mre']['chef-server']['ip'] = '172.31.10.152'

# Supermarket Server Attributes
default['chef-mre']['supermarket']['hostname'] = 'supermarket'
default['chef-mre']['supermarket']['ip'] = '172.31.10.87'

#Compliance Server Attributes
default['chef-mre']['compliance']['hostname'] = 'compliance'
default['chef-mre']['compliance']['ip'] = '172.31.10.90'

#Delivery Server Attributes
default['chef-mre']['delivery']['hostname'] = 'delivery'
default['chef-mre']['delivery']['ip'] = '172.31.10.89'