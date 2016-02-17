require! {
  '../..': VirtualDockerfile
  '../../config/docker': docker-config
  'livescript'
  'scope-eval'
}


module.exports = ->

  @Given /^a new VirtualDockerfile instance called "([^"]+)"$/ (@instance-name) ->
    @run-scope[@instance-name] = new VirtualDockerfile {from: 'alpine:latest', docker-config}


  @When /^running:$/ timeout: 50000, (source) ->
    source
    |> livescript.compile
    |> scope-eval _, @run-scope


  @When /^building the image(?: with the tag "([^"]+)")?$/ (tag-name='test_image', done) ->
    @run-scope[@instance-name].build tag: tag-name, done
