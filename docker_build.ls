require! {
  'dockerode': Dockerode
  'fs'
  'node-uuid': uuid
  'tar-stream'
}


class DockerBuild

  (opts) ->
    @docker-file-commands = ["FROM #{opts.from}"]
    @tarball = tarStream.pack!


  build: ({tag}, done) ->
    @tarball
      ..entry name: 'Dockerfile', @docker-file-commands.join('\n')
      ..finalize!

    new Dockerode!.buildImage @tarball, t: tag, (err, response) ->
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



module.exports = DockerBuild
