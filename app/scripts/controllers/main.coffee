'use strict'


angular.module('boomerangApp').classy.controller 

	name: 'MainCtrl'

	inject: ['$scope', '$rootScope', '$firebase', '$firebaseSimpleLogin', '$location']

	log: (thing) ->
		console.log thing

	watch:
		'auth.user': '_checkUser'

	init: ->
		# Stop trying to change route!
		ref = new Firebase @$rootScope.firebaseURL
		@$.rootRef = @$firebase ref
		@$.auth = @$firebaseSimpleLogin ref

	_checkUser: (authUser) ->
		@log authUser
		@log 'ahh'
		if authUser
			# Grab this authUser from firebase
			 # = new Firebase "/users/#{authUser.uid}"
			@$.user = @$.rootRef.$child "/users/#{authUser.uid}"
			@log @$.user
			if @$.user.vanity
				# User has already been signed up
				@log 'already signed up'
				# Redirect to add
				@gotoAdd()
			else
				@log 'new user'
				# This is a new user, just logged in for the first time
				@$.user.$set
					vanity: authUser.username
				# Also go set the vanity URL
				@$.rootRef.$child("/vanity/#{authUser.username}").$set authUser.uid
				@$.showSignup = true
			# ref.on 'value', (snapshot) ->
			# 	user = snapshot.val()
			# 	console.log user
			# Redirect to add screen
			# @$location.path 'add'



	login: ->
		@$.auth.$login('twitter').then (authUser) =>
			@log 'logged in with twitter'
			@log authUser

	gotoAdd: ->
		@$location.path 'add'



