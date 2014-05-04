'use strict'


angular.module('boomerangApp').classy.controller 

	name: 'AddCtrl'

	inject: ['$scope', '$rootScope', '$firebase', '$location', 'User']

	init: ->

		queueRef = new Firebase "#{@$rootScope.firebaseURL}/linkQueue"
		@queue = @$firebase queueRef

	save: ->

		if @$.link
			# Create a new link object, and add it to firebase
			link = 
				url: @$.link

			# Set this on the user
			prom = @User.$child('links').$add link
			prom.then (ref) =>
				# Add to the queue
				queueLink = 
					url: @$.link
					user: @User.$id
					id: ref.name()

				@queue.$add queueLink

				# Redirect to the links page
				@$location.path '/links'