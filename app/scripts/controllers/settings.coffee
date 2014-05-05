'use strict'


angular.module('boomerangApp').classy.controller 

	name: 'SettingsCtrl'

	inject: ['$scope', '$rootScope', '$firebase']

	init: ->

		# Bitcoin price "last" reference is on the $rootScope
		bitcoinRef = new Firebase @$rootScope.firebaseURL

		# Shorthand for @$scope.bitcoin is @$.bitcoin
		@$.bitcoin = @$firebase bitcoinRef

