# node-docker-build
Node api to build docker images programmatically


## Usage:
```coffeescript
dockerBuild = require('docker-build');


image = new DockerBuild from: 'node:latest'
image.copy srcDir, '/home/app'
image.run 'npm install'
image.expose 3000
image.cmd 'npm start'

image.build tag: 'my_image_tag', (err) ->
```
