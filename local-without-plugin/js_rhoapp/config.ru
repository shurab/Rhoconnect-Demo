#!/usr/bin/env ruby
require 'rhoconnect/application/init'

# secret is generated along with the app
Rhoconnect::Server.set     :secret,      '962a550af5ffa4e269faa520684dd0195b78836f69930630107183130d1137341382be4b6336126d844a1ec622546af6d4561da4faed398444b2947be019e5a9'

# !!! Add your custom initializers and overrides here !!!
# For example, uncomment the following line to enable Stats
#Rhoconnect::Server.enable  :stats
# uncomment the following line to disable Resque Front-end console
#Rhoconnect.disable_resque_console = true
# uncomment the following line to disable Rhoconnect Front-end console
#Rhoconnect.disable_rc_console = true

# Rhoconnect::Server.set :use_async_model, false

# run RhoConnect Application
run Rhoconnect.app
