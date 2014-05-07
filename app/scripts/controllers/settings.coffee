'use strict'


angular.module('boomerangApp').classy.controller 

	name: 'SettingsCtrl'

	inject: ['$scope', '$rootScope', '$firebase', '$firebaseSimpleLogin', 'authUser', 'user']

	watch: 
		'user.minInterval': '_updateMinInterval'
		'minInterval': '_setMinInterval'
		'user.email': -> @$.user.$save('email') if @$.user.email

	init: ->

		# Bind the user
		@$.user = @user

		# Set up the options
		@$.options = [
				seconds: 2628000
				human: "One Month"
			, 
				seconds: 5256000
				human: "Two Months"
			, 
				seconds: 15778500
				human: "Six Months"
			, 
				seconds: 31557000
				human: "One Year"
		]

	_updateMinInterval: (inter) ->
		console.log 'updated from firebase!'
		if inter
			console.log inter
			# Find in options
			option = (option for option in @$.options when option.seconds is inter.seconds)[0]
			# Set on scope
			@$.minInterval = option


	_setMinInterval: (inter) ->
		if inter
			console.log "interval will be set!"
			console.log inter
			@$.user.$update
				minInterval: inter

	logout: ->
		ref = new Firebase @$rootScope.firebaseURL
		@$.rootRef = @$firebase ref
		@$.auth = @$firebaseSimpleLogin ref
		@$.auth.$logout()
		@$location.path '/'
