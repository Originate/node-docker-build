async = require 'async'
{expect} = require 'chai'


module.exports = ->

  @Given /^I have no docker images$/ (done) ->
    @getDockerImages (err, images) ~>
      return done err if err
      async.each (images.map (.Id)), @removeImage, done


  @Then /^a docker image with the tag "([^"]+)" is successfully created$/ (tag, done) ->
    @getDockerImages (err, images) ->
      return done err if err
      tags = [].concat ...(images.map (.RepoTags))
      expect(tags).to.contain tag
      done()


  @Then /^my docker image has a file "([^"]+)" with the content "([^"]+)"$/ (filePath, expectedContents, done) ->
    @readImageFileContents {imageId: 'test_image', filePath} (err, contents) ->
      return done err if err
      expect(contents).to.equal expectedContents
      done()
