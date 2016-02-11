Docker = require 'dockerode'
dockerConfig = require '../config/docker'
{WritableStreamBuffer} = require 'stream-buffers'


class World
  ->
    @_docker = new Docker dockerConfig


  readImageFileContents: ({imageId, filePath}, done) ->
    stdOutStream = new WritableStreamBuffer
    @_docker.run(
      imageId
      [\cat, filePath]
      [stdOutStream]
      Tty: no
      (err) ->
        return done err if err
        done null, stdOutStream.getContents().toString()
    )


  getDockerImages: (done) ->
    @_docker.listImages (err, images) ~>
      return done err if err
      done null, images


  runImage: (imageId, command, done) ->
    @_docker.run imageId, command, done


module.exports = -> @World = World
