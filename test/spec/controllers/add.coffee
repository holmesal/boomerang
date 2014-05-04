'use strict'

describe 'Controller: AddCtrl', ->

  # load the controller's module
  beforeEach module 'boomerangApp'

  AddCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    AddCtrl = $controller 'AddCtrl', {
      $scope: scope
    }

  it 'should attach a list of awesomeThings to the scope', ->
    expect(scope.awesomeThings.length).toBe 3
