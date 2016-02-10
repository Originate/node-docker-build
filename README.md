# node-docker-build
Node api to build docker images programmatically


## Usage:
```coffeescript
dockerBuild = require('docker-build');


dockerBuild {
  context:
    # Optional: base directory to use for the context
    dir: '/path/to/context/dir'
    
    # Optional: add or overwrite files in the context dir
    files:
      foo: 'some file content',
      Dockerfile: '''
        FROM alpine:latest
        COPY foo /bar
      '''


  # Optional: Connection options passed directly to the constructor of dockerode
  # See https://github.com/apocas/dockerode
  dockerodeArgs: {socketPath: '/var/run/docker.sock'},
  
  # Optional: tag to use for built docker container
  tag: 'my_image_tag'
  
}, (err) ->
  # Called when build is finished with any errors
```
