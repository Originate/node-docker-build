# node-docker-build
Node api to build docker images programmatically


## Usage:
```coffeescript
dockerBuild = require('docker-build');


image = new DockerBuild from: 'ubuntu:latest'
image.copy path.join(__dirname, 'file.txt'), '/root/file.txt'
image.run 'touch other_file'
image.expose 3000

image.build tag: 'my_image_tag', (err) ->
```
