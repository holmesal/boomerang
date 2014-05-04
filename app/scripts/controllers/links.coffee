'use strict'


angular.module('boomerangApp').classy.controller 

	name: 'LinksCtrl'

	inject: ['$scope', '$rootScope', '$firebase', 'User']

	init: ->
		console.log @User
		@$.user = @User

