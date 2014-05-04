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
    .when '/add',
      templateUrl: 'views/add.html'
      controller: 'AddCtrl'
      resolve: 
        User: (Firesolver) -> Firesolver.getUser()
    .when '/links',
      templateUrl: 'views/links.html'
      controller: 'LinksCtrl'
      resolve: 
        User: (Firesolver) -> Firesolver.getUser()
    .otherwise
      redirectTo: '/'


  .run ($rootScope, $location) ->

    # Set the firebase URL
    $rootScope.firebaseURL = 'https://boomerangrang.firebaseio.com'

    # Log any route change errors
    $rootScope.$on '$routeChangeError', (event, current, previous, rejection) ->
      console.error 'failed to change route'
      console.error rejection
      $location.path '/'
