'use strict'

angular.module('boomerangApp')
.directive 'navbar', ($rootScope, $route) ->
	templateUrl: 'views/navbar.html'
	restrict: 'E'
	link: (scope, element, attrs) ->

		# Grab the current route
		scope.controller = $route.current.$$route.controller

		# Update on route changes
		$rootScope.$on '$routeChangeSuccess', (event, next, current) ->
			scope.controller = next.$$route.controller

		# Watch for changes and set buttons
		scope.$watch 'controller', (controller) ->

			console.log 'changed!'

			switch controller

				when 'LinksCtrl'

					console.log 'links!'
					scope.left = 'add'
					scope.right = 'settings'

				when 'SettingsCtrl'

					console.log 'settings!'
					scope.right = 'save'
					scope.left = ''

				when 'AddCtrl'

					console.log 'add!'
					scope.left = 'links'
					scope.right = 'settings'