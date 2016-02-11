tmp = require 'tmp'
fs = require 'fs'


module.exports = ->

  @Given /^I have a file on my filesystem with contents "([^"]+)"$/ (fileContents, done) ->
    tmp.file (err, @myFilePath, fd) ~>
      return done err if err
      fs.write fd, fileContents, done
