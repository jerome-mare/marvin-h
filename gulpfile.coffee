istanbul   = require 'gulp-coffee-istanbul'
gulp       = require 'gulp'
mocha      = require 'gulp-mocha'
clean      = require 'gulp-clean'
watch      = require 'gulp-watch'
coffeelint = require 'gulp-coffeelint'
coveralls  = require 'gulp-coveralls'

jsFiles = []
specFiles = ['test/*.spec.coffee']
coffeeFiles = ['scripts/*.coffee']
coverageFiles = ['coverage/lcov.info']

gulp.task 'test', ->
  gulp.src jsFiles.concat(coffeeFiles)
  .pipe istanbul({includeUntested: true}) # Covering files
  .pipe istanbul.hookRequire()
  .on 'finish', ->
    gulp.src specFiles
    .pipe mocha reporter: 'spec'
    .pipe istanbul.writeReports() # Creating the reports after tests run
    gulp.src coverageFiles
    .pipe coveralls();
