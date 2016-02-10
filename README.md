# node-docker-build
Node api to build docker images programmatically


## Usage:
```javascript
dockerBuild = require('docker-build');


dockerBuild.build({
  // Optional: Connection options passed directly to the constructor of dockerode
  // See https://github.com/apocas/dockerode
  docker: {socketPath: '/var/run/docker.sock'},
  
  // Optional: Use an existing directory for context
  contextDir: '/path/to/context/dir',
  
  // Optional: tag to use for built docker container
  tag: 'my_image_tag',
  
  // Hash of files to be added dynamically to the context
  dynamicFiles: {
    foo: 'some file content',
    Dockerfile: 'FROM alpine:latest\nCOPY foo /bar'
  }
}, function(err) {
  // Called when build is finished with any errors
});
```
