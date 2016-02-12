Feature: Building docker images

  As a developer I want to be able to build docker images programmatically
  so that I can build tools that use docker under the hood


  Background:
    Given a new VirtualDockerfile instance called "image"


  Scenario: building an empty image
    When building the image with the tag "my_image_tag"
    Then it creates a docker image with the tag "my_image_tag:latest"


  Scenario: running commands on an image
    When running:
      """
      image.run 'echo -n "bar" > /foo'
      """
    And building the image
    Then the generated docker image contains a file "/foo" with the content "bar"


  Scenario: copying files to an image
    Given a directory "my-dir" with the files:
      | NAME        | CONTENT     |
      | message.txt | hello world |
    When running:
      """
      image.copy "#{my-dir-path}/message.txt", '/announcement.txt'
      """
    And building the image
    Then the generated docker image contains a file "/announcement.txt" with the content "hello world"
