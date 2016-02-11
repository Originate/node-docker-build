Feature: Building docker images

  As a developer I want to be able to build docker images programmatically
  so that I can build tools that use docker under the hood


  Scenario: building an empty image
    When I run
      """
      image = new DockerBuild from: 'alpine:latest'
      image.build tag: 'my_image_tag', done
      """
    Then a docker image with the tag "my_image_tag:latest" is successfully created


  Scenario: running commands on an image
    When I run on an image
      """
      image.run 'echo -n "bar" > /foo'
      """
    Then my docker image has a file "/foo" with the content "bar"


  Scenario: copying files to an image
    Given I have a file on my filesystem with contents "buzz"
    When I run on an image
      """
      image.copy myFilePath, '/fizz'
      """
    Then my docker image has a file "/fizz" with the content "buzz"
