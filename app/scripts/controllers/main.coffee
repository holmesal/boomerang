'use strict'


angular.module('boomerangApp').classy.controller 

	name: 'MainCtrl'

	inject: ['$scope', '$rootScope', '$firebase', '$firebaseSimpleLogin', '$location', 'user']

	log: (thing) ->
		console.log thing

	watch:
		'auth.user': '_checkUser'

	init: ->
		# Store this user
		# @logout()
		@$.user = @user
		@log 'starting user:'
		@log @user
		# If logged in, go to the add page
		if @user
			@gotoAdd()
		else
			# Wait for a login, then change route
			ref = new Firebase @$rootScope.firebaseURL
			@$.rootRef = @$firebase ref
			@$.auth = @$firebaseSimpleLogin ref

	_checkUser: (authUser) ->
		@log 'got authUser: '
		@log authUser
		if authUser
			# Grab this authUser from firebase
			@$.user = @$.rootRef.$child "/users/#{authUser.username}"
			@log 'got user from firebase'
			@log @$.user

			# If they've got a name, this isn't the first login
			if @$.user.name
				@firstTime = false
			else
				@firstTime = true

			# Update all the properties we use
			@$.user.$update
				name: authUser.thirdPartyUserData.name
				image: authUser.thirdPartyUserData.profile_image_url
				minInterval:
					seconds: 15778500
					human: "Six Months"
			.then =>
				# If it's their first time, send them to the welcome screen
				if @firstTime
					@gotoAdd()
				else
					@gotoAdd()

			# if @$.user.name
			# 	# User has already been signed up
			# 	@log 'already signed up'
			# 	# Redirect to add
			# 	@gotoAdd()
			# else
			# 	@log 'new user'
			# 	# This is a new user, just logged in for the first time
			# 	@$.user.$set
			# 		name: authUser.thirdPartyUserData.name
			# 		image: authUser.thirdPartyUserData.profile_image_url
			# 	# Also go set the vanity URL
			# 	@$.rootRef.$child("/vanity/#{authUser.username}").$set authUser.uid
			# 	@$.showSignup = true
			# ref.on 'value', (snapshot) ->
			# 	user = snapshot.val()
			# 	console.log user
			# Redirect to add screen
			# @$location.path 'add'



	login: ->
		@$.auth.$login('twitter').then (authUser) =>
			@log 'logged in with twitter'
			@log authUser

	logout: ->
		ref = new Firebase @$rootScope.firebaseURL
		@$.rootRef = @$firebase ref
		@$.auth = @$firebaseSimpleLogin ref
		@$.auth.$logout()

	gotoAdd: ->
		@$location.path 'add'



