'use strict'


angular.module('boomerangApp').classy.controller 

	name: 'LinksCtrl'

	inject: ['$scope', '$rootScope', '$firebase', '$location', 'user', 'owner']

	init: ->

		console.log @user
		console.log @owner

		# Is this user the owner?
		if @user?.$id is @owner?.$id
			@$.isOwner = true
		else
			@$.isOwner = false

		# Set on the scope
		@$.owner = @owner


	remove: (key) ->
		# Use the key to remove the link
		link = @$.user.$child "links/#{key}"
		link.$remove()

	loadArticle: (url) ->
		window.location = url

