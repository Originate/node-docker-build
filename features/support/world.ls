require! {
  '../../config/docker': docker-config
  'dockerode': Dockerode
  'stream-buffers': {WritableStreamBuffer}
}


class World

  ->
    @_docker = new Dockerode dockerConfig


  read-image-file-contents: ({image-id, file-path}, done) ->
    stdout-stream = new WritableStreamBuffer
    @_docker.run(
      image-id
      [\cat, file-path]
      [stdout-stream]
      Tty: no
      (err) ->
        return done err if err
        done null, stdout-stream.get-contents!to-string!
    )


  get-docker-images: (done) ->
    @_docker.list-images done


module.exports = -> @World = World
