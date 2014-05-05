'use strict'


angular.module('boomerangApp').classy.controller 

	name: 'AddCtrl'

	inject: ['$scope', '$rootScope', '$firebase', '$firebaseSimpleLogin', '$location', 'user', 'authUser']

	init: ->

		# Put the user on the scope
		console.log @user
		@$.user = @user

		queueRef = new Firebase "#{@$rootScope.firebaseURL}/linkQueue"
		@queue = @$firebase queueRef

	save: ->

		if @$.link
			# Create a new link object, and add it to firebase
			link = 
				url: @$.link

			# Set this on the user
			prom = @user.$child('links').$add link
			prom.then (ref) =>
				# Timestamp it
				ts = ref.child 'timestamp'
				ts.set Firebase.ServerValue.TIMESTAMP
				# Add to the queue
				queueLink = 
					url: @$.link
					user: @user.$id
					id: ref.name()

				@queue.$add queueLink

				# Redirect to the links page
				@$location.path "/@#{@user.$id}"

	logout: ->
		ref = new Firebase @$rootScope.firebaseURL
		@$.rootRef = @$firebase ref
		@$.auth = @$firebaseSimpleLogin ref
		@$.auth.$logout()
		@$location.path '/'