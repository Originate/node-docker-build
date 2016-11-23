require! {
  'dockerode': Dockerode
  'fs'
  'uuid': uuid
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

    @docker = new Dockerode @docker-config
      ..build-image @tarball, t: tag, (err, response) ~>
        return done err if err
        @docker.modem.follow-progress response, (err) ->
          return done Error(err) if err?
          done!


  copy: (srcFilePath, destFilePath) ->
    tmpFileName = uuid.v4!
    @tarball.entry name: tmpFileName, fs.readFileSync(srcFilePath)
    @docker-file-commands.push "COPY #{tmpFileName} #{destFilePath}"


  run: (command) ->
    @docker-file-commands.push "RUN #{command}"



module.exports = VirtualDockerfile
