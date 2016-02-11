Docker = require 'dockerode'
fs = require 'fs'
tar = require 'tar-stream'
uuid = require 'node-uuid'


class DockerBuild

  (opts) ->
    @dockerFileCommands = ["FROM #{opts.from}"]
    @tarball = tar.pack()


  build: ({tag}, done) ->
    @tarball.entry name: 'Dockerfile', @dockerFileCommands.join('\n')
    @tarball.finalize()

    docker = new Docker
    docker.buildImage @tarball, t: tag, (err, response) ->
      return done err if err
      response.on 'data' ->
      response.on 'end' -> done()


  copy: (srcFilePath, destFilePath) ->
    tmpFileName = uuid.v4()
    @tarball.entry name: tmpFileName, fs.readFileSync(srcFilePath)
    @dockerFileCommands.push "COPY #{tmpFileName} #{destFilePath}"


  run: (command) ->
    @dockerFileCommands.push "RUN #{command}"



module.exports = DockerBuild
