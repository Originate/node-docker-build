require! {
  'dockerode': Dockerode
  'fs'
  'node-uuid': uuid
  'tar-stream'
}


class VirtualDockerfile

  ({from, @docker-config}) ->
    @docker-file-commands = ["FROM #{from}"]
    @tarball = tarStream.pack!


  build: ({tag}, done) ->
    @tarball
      ..entry name: 'Dockerfile', @docker-file-commands.join('\n')
      ..finalize!

    new Dockerode(@docker-config).buildImage @tarball, t: tag, (err, response) ->
      return done err if err
      response
        ..on 'data' ->
        ..on 'end' -> done!


  copy: (srcFilePath, destFilePath) ->
    tmpFileName = uuid.v4!
    @tarball.entry name: tmpFileName, fs.readFileSync(srcFilePath)
    @docker-file-commands.push "COPY #{tmpFileName} #{destFilePath}"


  run: (command) ->
    @docker-file-commands.push "RUN #{command}"



module.exports = VirtualDockerfile
