(function(){"use strict";angular.module("boomerangApp",["ngCookies","ngResource","ngSanitize","ngRoute","firebase","holmesal.firesolver","classy","ngAnimate"]).config(["$routeProvider",function(a){return a.when("/",{templateUrl:"views/main.html",controller:"MainCtrl",resolve:{user:["Firesolver",function(a){return a.currentUser()}]}}).when("/add",{templateUrl:"views/add.html",controller:"AddCtrl",resolve:{authUser:["Firesolver",function(a){return a.authenticate()}],user:["Firesolver",function(a){return a.currentUser()}]},navbar:{left:"links",right:"settings"}}).when("/@:handle",{templateUrl:"views/links.html",controller:"LinksCtrl",resolve:{user:["Firesolver",function(a){return a.currentUser()}],owner:["Firesolver","$route",function(a,b){return a.get("users/"+b.current.params.handle)}]},navbar:{left:"add",right:"settings"}}).when("/settings",{templateUrl:"views/settings.html",controller:"SettingsCtrl",resolve:{authUser:["Firesolver",function(a){return a.authenticate()}],user:["Firesolver",function(a){return a.currentUser()}]},navbar:{right:"check"}}).otherwise({redirectTo:"/"})}]).run(["$rootScope","$location",function(a,b){return FastClick.attach(document.body),a.firebaseURL="https://boomerangrang.firebaseio.com",a.$on("$routeChangeError",function(a,c,d,e){return console.error("failed to change route"),console.error("to route "+c),console.error(e),b.path("/")})}])}).call(this),function(){"use strict";angular.module("boomerangApp").classy.controller({name:"MainCtrl",inject:["$scope","$rootScope","$firebase","$firebaseSimpleLogin","$location","user"],log:function(a){return console.log(a)},watch:{"auth.user":"_checkUser"},init:function(){var a;return this.$.user=this.user,this.log("starting user:"),this.log(this.user),this.user?this.gotoAdd():(a=new Firebase(this.$rootScope.firebaseURL),this.$.rootRef=this.$firebase(a),this.$.auth=this.$firebaseSimpleLogin(a))},_checkUser:function(a){var b=this;return this.log("got authUser: "),this.log(a),a?(this.$.user=this.$.rootRef.$child("/users/"+a.username),this.log("got user from firebase"),this.log(this.$.user),this.firstTime=this.$.user.name?!1:!0,this.$.user.$update({name:a.thirdPartyUserData.name,image:a.thirdPartyUserData.profile_image_url,minInterval:{seconds:15778500,human:"Six Months"}}).then(function(){return b.firstTime,b.gotoAdd()})):void 0},login:function(){var a=this;return this.$.auth.$login("twitter").then(function(b){return a.log("logged in with twitter"),a.log(b)})},logout:function(){var a;return a=new Firebase(this.$rootScope.firebaseURL),this.$.rootRef=this.$firebase(a),this.$.auth=this.$firebaseSimpleLogin(a),this.$.auth.$logout()},gotoAdd:function(){return this.$location.path("add")}})}.call(this),function(){"use strict";angular.module("boomerangApp").classy.controller({name:"AddCtrl",inject:["$scope","$rootScope","$firebase","$location","user","authUser"],init:function(){var a;return console.log(this.user),this.$.user=this.user,a=new Firebase(""+this.$rootScope.firebaseURL+"/linkQueue"),this.queue=this.$firebase(a)},save:function(){var a,b,c=this;return this.$.link?(a={url:this.$.link},b=this.user.$child("links").$add(a),b.then(function(a){var b,d;return d=a.child("timestamp"),d.set(Firebase.ServerValue.TIMESTAMP),b={url:c.$.link,user:c.user.$id,id:a.name()},c.queue.$add(b),c.$location.path("/@"+c.user.$id)})):this.$location.path("/@"+this.user.$id)}})}.call(this),function(){"use strict";angular.module("boomerangApp").classy.controller({name:"LinksCtrl",inject:["$scope","$rootScope","$firebase","$location","user","owner"],init:function(){var a,b;return console.log(this.user),console.log(this.owner),this.$.isOwner=(null!=(a=this.user)?a.$id:void 0)===(null!=(b=this.owner)?b.$id:void 0)?!0:!1,this.$.owner=this.owner},remove:function(a){var b;return b=this.$.user.$child("links/"+a),b.$remove()},loadArticle:function(a){return window.location=a}})}.call(this),function(){"use strict";angular.module("boomerangApp").directive("navbar",["$rootScope","$route",function(a,b){return{templateUrl:"views/navbar.html",restrict:"E",link:function(c){var d;return c.controller=b.current.$$route.controller,a.$on("$routeChangeSuccess",function(b,e){return console.log(e.$$route.navbar),console.log(a.user),e.$$route.navbar?(c.right=d(e.$$route.navbar.right),c.left=d(e.$$route.navbar.left)):c.left=c.right=null,console.log(c.left),console.log(c.right)}),d=function(b){var c;return c=function(){switch(!1){case"links"!==b:return{path:"#/@"+a.user.$id};case"add"!==b:return{path:"#/add"};case"settings"!==b:return{path:"#/settings"};case"check"!==b:return{path:"#/@"+a.user.$id};default:return{path:null}}}(),c.name=b,c}}}}])}.call(this),function(){"use strict";angular.module("boomerangApp").classy.controller({name:"SettingsCtrl",inject:["$scope","$rootScope","$firebase","$firebaseSimpleLogin","authUser","user"],watch:{"user.minInterval":"_updateMinInterval",minInterval:"_setMinInterval","user.email":function(){return this.$.user.email?this.$.user.$save("email"):void 0}},init:function(){return this.$.user=this.user,this.$.options=[{seconds:2628e3,human:"One Month"},{seconds:5256e3,human:"Two Months"},{seconds:15778500,human:"Six Months"},{seconds:31557e3,human:"One Year"}]},_updateMinInterval:function(a){var b;return console.log("updated from firebase!"),a?(console.log(a),b=function(){var c,d,e,f;for(e=this.$.options,f=[],c=0,d=e.length;d>c;c++)b=e[c],b.seconds===a.seconds&&f.push(b);return f}.call(this)[0],this.$.minInterval=b):void 0},_setMinInterval:function(a){return a?(console.log("interval will be set!"),console.log(a),this.$.user.$update({minInterval:a})):void 0},logout:function(){var a;return a=new Firebase(this.$rootScope.firebaseURL),this.$.rootRef=this.$firebase(a),this.$.auth=this.$firebaseSimpleLogin(a),this.$.auth.$logout(),this.$location.path("/")}})}.call(this);