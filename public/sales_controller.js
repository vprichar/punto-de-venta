app.controller('SalesCtrl', ['$scope','$http', '$filter', function ($scope, $http, $filter) {
    window.scope = $scope;

    $scope.function = function(){

        $sale_id = $("#sale_id").val();

        $http.get('/sales/create_line_item?item_id='+$scope.barcodesearch+'&quantity=1&sale_id='+$sale_id)
            .success(function (data) {
                $("#barcodesearch").val('');
                $( "#barcodesearch" ).focus();

                var ajaxReload = new Function(data);
                ajaxReload();

            })
            .error(function () {
                alert("Producto no encontrado");
                $("#barcodesearch").val('');
                $( "#barcodesearch" ).focus();
            });
    };
}]);



app.controller("myCtrl", function($scope) {
    $scope.firstName = "John";
    $scope.lastName = "Doe";
});







app.controller("customersCtrl", function ($scope,$http,$timeout){

  $scope.reload = function () {
    $http.get("http://0.0.0.0:3000/cash_outs/cortes.json")
    .then(function (response) {$scope.names = response.data;
      });

    $timeout(function(){
      $scope.reload();
    },30)
  };
  $scope.reload();
});


angular.module('myApp', ['ngMaterial'])
.config(function($mdThemingProvider) {
  $mdThemingProvider.theme('default')
    .primaryPalette('orange')
    .accentPalette('orange');
});


