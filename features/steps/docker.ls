require! {
  'chai': {expect}
  'nitroglycerin': N
}


module.exports = ->

  @Then /^it creates a docker image with the tag "([^"]+)"$/ (tag, done) ->
    @get-docker-images N (images) ->
      tags = [].concat ...(images.map (.RepoTags))
      expect(tags).to.contain tag
      done!


  @Then /^the generated docker image contains a file "([^"]+)" with the content "([^"]+)"$/ (file-path, expected-contents, done) ->
    @read-image-file-contents {image-id: 'test_image', file-path} N (contents) ->
      expect(contents).to.equal expected-contents
      done!
