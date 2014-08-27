#!/usr/bin/env ruby
require 'rhoconnect/application/init'

# secret is generated along with the app
Rhoconnect::Server.set     :secret,      '5554e682bf0c5a6fe670ad67111453417d629ca1de51c089a686fd602988c731f3bdba5b219627ca1c3da9d2c03cce329230bdd1ca08790f86c51317a07a5447'

# !!! Add your custom initializers and overrides here !!!
# For example, uncomment the following line to enable Stats
#Rhoconnect::Server.enable  :stats
# uncomment the following line to disable Resque Front-end console
#Rhoconnect.disable_resque_console = true
# uncomment the following line to disable Rhoconnect Front-end console
#Rhoconnect.disable_rc_console = true

# run RhoConnect Application
run Rhoconnect.app
