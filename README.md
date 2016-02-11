# node-docker-build
Node api to build docker images programmatically


## Usage:
```coffeescript
DockerBuild = require('docker-build');

image = new DockerBuild from: 'ubuntu:latest'
image.run 'apt-get install ruby'
image.copy '/file/on/my/local/system', '/destination/in/docker/image'

image.build tag: 'my_image_tag', (err) ->
```
