'use strict'

angular
  .module('boomerangApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngRoute',
    'firebase',
    'holmesal.firesolver',
    'classy'
  ])
  .config ($routeProvider) ->
    $routeProvider
    .when '/',
      templateUrl: 'views/main.html'
      controller: 'MainCtrl'
      resolve: 
        user: (Firesolver) -> Firesolver.currentUser()
    .when '/add',
      templateUrl: 'views/add.html'
      controller: 'AddCtrl'
      resolve: 
        authUser: (Firesolver) -> Firesolver.authenticate()
        user: (Firesolver) -> Firesolver.currentUser()
      navbar:
        left: 'links'
        right: 'settings'
    .when '/@:handle',
      templateUrl: 'views/links.html'
      controller: 'LinksCtrl'
      resolve: 
        user: (Firesolver) -> Firesolver.currentUser()
        owner: (Firesolver, $route) ->
          Firesolver.get "users/#{$route.current.params.handle}"
      navbar:
        left: 'add'
        right: 'settings'
    .when '/settings',
      templateUrl: 'views/settings.html'
      controller: 'SettingsCtrl'
      resolve: 
        authUser: (Firesolver) -> Firesolver.authenticate()
        user: (Firesolver) -> Firesolver.currentUser()
      navbar:
        right: 'check'
    .otherwise
      redirectTo: '/'


  .run ($rootScope, $location) ->

    # Set the firebase URL
    $rootScope.firebaseURL = 'https://boomerangrang.firebaseio.com'

    # Log any route change errors
    $rootScope.$on '$routeChangeError', (event, current, previous, rejection) ->
      console.error 'failed to change route'
      console.error "to route #{current}"
      console.error rejection
      $location.path '/'
