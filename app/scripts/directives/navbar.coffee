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
			console.log next.$$route.navbar

			console.log $rootScope.user

			if next.$$route.navbar
			
				scope.right = prepButton next.$$route.navbar.right
				# scope.controller = next.$$route.controller
				scope.left = prepButton next.$$route.navbar.left

			else
				scope.left = scope.right = null

			console.log scope.left
			console.log scope.right

		prepButton = (name) ->

			button = switch

				when name is 'links'
					path: "#/@#{$rootScope.user.$id}"

				when name is 'add'
					path: '#/add'

				when name is 'settings'
					path: '#/settings'

				when name is 'check'
					path: "#/@#{$rootScope.user.$id}"

				else
					path: null

			button.name = name
			return button




		# # Watch for changes and set buttons
		# scope.$watch 'controller', (controller) ->

		# 	console.log 'changed!'

		# 	switch controller

		# 		when 'LinksCtrl'

		# 			console.log 'links!'
		# 			scope.left = 'add'
		# 			scope.right = 'settings'

		# 		when 'SettingsCtrl'

		# 			console.log 'settings!'
		# 			scope.right = 'save'
		# 			scope.left = ''

		# 		when 'AddCtrl'

		# 			console.log 'add!'
		# 			scope.left = 'links'
		# 			scope.right = 'settings'