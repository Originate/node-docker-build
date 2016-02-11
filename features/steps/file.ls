require! {
  'fs'
  'nitroglycerin': N
  'camel-case'
  'path'
  'tmp'
}


module.exports = ->

  @Given /^a directory "([^"]+)" with the files:$/ (dir-name, files, done) ->
    tmp.dir N (tmp-dir-path) ~>
      @run-scope[camel-case "#{dir-name}-path"] = tmp-dir-path
      console.log tmp-dir-path
      for {NAME, CONTENT} in files.hashes!
        fs.writeFileSync path.join(tmp-dir-path, NAME), CONTENT
      done!
