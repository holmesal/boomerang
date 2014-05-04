'use strict'

describe 'Controller: LinksCtrl', ->

  # load the controller's module
  beforeEach module 'boomerangApp'

  LinksCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    LinksCtrl = $controller 'LinksCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
