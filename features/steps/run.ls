DockerBuild = require '../../docker_build'
docker-config = require '../config/docker'
livescript = require 'livescript'
scope-eval = require 'scope-eval'


module.exports = ->
  @When /^I run$/ timeout: 50000, (source, done) ->
    source
    |> livescript.compile
    |> scope-eval _, {DockerBuild, done}


  @When /^I run on an image$/ timeout: 50000, (source, done) ->
    image = new DockerBuild from: 'alpine:latest'
    source
    |> livescript.compile
    |> scope-eval _, {image, @myFilePath}
    image.build tag: 'test_image', done
