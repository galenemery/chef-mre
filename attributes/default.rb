# Common Attributes
default['chef-mre']['ssh-key'] = ['C:/users/Chef/.ssh/galen-sa-east.pem', 'galen-sa-east.pem', 'galen-sa-east']
default['chef-mre']['domain_prefix'] = ''
default['chef-mre']['domain'] = 'offline'
default['chef-mre']['admin-user'] = 'ec2-user'

#What platform/version are you deploying to?

default["chef-mre"]["server_platform"]["name"] = 'el'
default["chef-mre"]["server_platform"]["version"] = '7'
default["chef-mre"]["server_platform"]["architecture"] = 'x86_64'

default["chef-mre"]["automate_version"] = :latest
default["chef-mre"]["chef-server_version"] = :latest
default["chef-mre"]["compliance_version"] = :latest
default["chef-mre"]["manage_version"] = :latest
default["chef-mre"]["supermarket_version"] = :latest
default["chef-mre"]["products"] = [
  "automate",
  "chef-server",
  "compliance",
  "manage",
  "supermarket",
]

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