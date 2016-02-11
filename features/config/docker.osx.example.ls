# Copy this file to features/config/docker.ls before developing on OSX
# The DOCKER_CERT_PATH and DOCKER_HOST need to be updated for your configuration
# These values can be found by running `docker-machine env [MACHINE_NAME]`


MACHINE_NAME = 'default'
DOCKER_HOST = 'tcp://xxx.xxx.xxx.xxx:xxxx'
DOCKER_CERT_PATH = "#{process.env.HOME}/.docker/machine/machines/#{MACHINE_NAME}"
DOCKER_TLS_VERIFY = 1


#################################################################################
# No changes should be needed after this line
#################################################################################

fs = require 'fs'
url = require 'url'

# Export values for dockerode
{hostname, port} = url.parse DOCKER_HOST
module.exports =
  protocol: 'https'
  host: hostname
  port: port
  ca: fs.readFileSync "#{DOCKER_CERT_PATH}/ca.pem"
  cert: fs.readFileSync "#{DOCKER_CERT_PATH}/cert.pem"
  key: fs.readFileSync "#{DOCKER_CERT_PATH}/key.pem"
