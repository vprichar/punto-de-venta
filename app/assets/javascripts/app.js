//var app = angular.module('apps', [ 'ngRoute' ]); 

var app = angular.module('estilista', ['ngRoute']).run(['$rootScope', function($rootScope) {
    $rootScope.isEmpty = function(collection) {
        if (collection.length)
            return collection.length == 0;
        for (var item in collection)
            return false;
        return true;
    };
}]);
window.pzt = {};
app.config(function ($httpProvider) {
	$httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');
    $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';
    $httpProvider.defaults.headers.common["Accept"] = '*/*;q=0.5, text/javascript, application/javascript, application/ecmascript, application/x-ecmascript';
});
