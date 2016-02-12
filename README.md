# node-virtual-dockerfile [![Circle CI](https://circleci.com/gh/Originate/node-virtual-dockerfile/tree/master.svg?style=svg)](https://circleci.com/gh/Originate/node-virtual-dockerfile/tree/master)
Node api to build docker images programmatically


## Usage:
```coffeescript
VirtualDockerfile = require('virtual-dockerfile');

image = new VirtualDockerfile from: 'ubuntu:latest'
image.run 'apt-get install ruby'
image.copy '/file/on/my/local/system', '/destination/in/docker/image'

image.build tag: 'my_image_tag', (err) ->
```
