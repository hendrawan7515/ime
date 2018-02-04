<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="test.aspx.vb" Inherits="IME.test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <title>angular-eonasdan-datetimepicker</title>
    
    <!-- bower:css -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <link rel="stylesheet"
          href="https://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/4.17.37/build/css/bootstrap-datetimepicker.min.css">
    <!-- endinject -->
</head>
<body ng-app="plunker">
    <form id="form1" runat="server">

        <div ng-controller="controller as vm">

    <div class="well">
        <h3>Angular-eonasdan-datetimepicker</h3>
        <a href="https://github.com/atais/angular-eonasdan-datetimepicker"><p style="margin: -10px 0 0 0;">
            https://github.com/atais/angular-eonasdan-datetimepicker</p></a>
        <br>

        <div class="row">
            <div class="col-md-3">
                <div class="form-group">
                    <div class="input-group" datetimepicker
                         on-change="vm.update(vm.dateFrom, vm.dateTo)"
                         ng-model="vm.dateFrom" options="vm.optionsFrom">
                        <input class="form-control"/>
                        <span class="input-group-addon">
                            <i class="fa fa-calendar"></i>
                        </span>
                    </div>
                </div>
                <br>
                <p><b>Input date:</b> {{vm.dateFrom.format() | date: 'yyyy/MM/dd'}}</p>
                <p><b>Options:</b> {{vm.optionsFrom}}</p>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <div class="input-group" datetimepicker
                         on-change="vm.update(vm.dateFrom, vm.dateTo)"
                         ng-model="vm.dateTo" options="vm.optionsTo">
                        <input class="form-control"/>
                        <span class="input-group-addon">
                            <i class="fa fa-calendar"></i>
                        </span>
                    </div>
                </div>
                <br>
                <p><b>Input date:</b> {{vm.dateTo.format() | date: 'yyyy/MM/dd'}}</p>
                <p><b>Options:</b> {{vm.optionsTo}}</p>
            </div>
        </div>

        <button type="button" class="btn btn-default" ng-click="vm.print()">What's up?</button>
    </div>
</div>

        <%--<div data-ng-app="MyApp" data-ng-controller="MyController">
            Name:
    <input type="text" data-ng-model="Name" />
            <br />
            <br />
            <input type="button" value="Submit" data-ng-click="ButtonClick()" />
        </div>--%>
    </form>

    <%--<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.9/angular.min.js"></script>--%>



    <!-- bower:js -->
    <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.13.0/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.5.6/angular.min.js"></script>
    <script src="https://cdn.rawgit.com/Eonasdan/bootstrap-datetimepicker/4.17.37/build/js/bootstrap-datetimepicker.min.js"></script>
    <!-- endinject -->
    <script src="https://rawgit.com/atais/angular-eonasdan-datetimepicker/0.3.8/dist/angular-eonasdan-datetimepicker.min.js"></script>

    <script type="text/javascript">
        var controller = function ($scope) {
            var vm = this;

            vm.dateFrom = moment().add(-1, 'd');
            vm.dateTo = moment();

            vm.optionsFrom = { format: 'DD.MM.YYYY' };
            vm.optionsTo = { format: 'DD.MM.YYYY' };

            vm.update = function (dateFrom, dateTo) {
                vm.optionsFrom.maxDate = dateTo;
                vm.optionsTo.minDate = dateFrom;
            };
            vm.update(vm.dateFrom, vm.dateTo);

            vm.print = function () {
                console.log('vm.dateTo: ' + vm.dateTo.format('YYYY/MM/DD'));
                console.log('vm.optionsTo: ' + angular.toJson(vm.optionsTo));
                console.log('vm.dateFrom: ' + vm.dateFrom.format('YYYY/MM/DD'));
                console.log('vm.optionsFrom: ' + angular.toJson(vm.optionsFrom));
            };
        }

        var app = angular.module('plunker', ['ae-datetimepicker']);
        app.controller('controller', controller)

        //(function () {
        //    'use strict';

        //    angular.module('plunker', ['ae-datetimepicker'])
        //        .controller('controller', function () {
        //            var vm = this;

        //            vm.dateFrom = moment().add(-1, 'd');
        //            vm.dateTo = moment();

        //            vm.optionsFrom = { format: 'DD.MM.YYYY' };
        //            vm.optionsTo = { format: 'DD.MM.YYYY' };

        //            vm.update = function (dateFrom, dateTo) {
        //                vm.optionsFrom.maxDate = dateTo;
        //                vm.optionsTo.minDate = dateFrom;
        //            };
        //            vm.update(vm.dateFrom, vm.dateTo);

        //            vm.print = function () {
        //                console.log('vm.dateTo: ' + vm.dateTo.format('YYYY/MM/DD'));
        //                console.log('vm.optionsTo: ' + angular.toJson(vm.optionsTo));
        //                console.log('vm.dateFrom: ' + vm.dateFrom.format('YYYY/MM/DD'));
        //                console.log('vm.optionsFrom: ' + angular.toJson(vm.optionsFrom));
        //            };

        //        });
        //})();


        //var app = angular.module('MyApp', [])
        //app.controller('MyController', function ($scope, $http, $window) {
        //    $scope.ButtonClick = function () {
        //        var post = $http({
        //            method: "POST",
        //            url: "WebMethod.aspx/test",
        //            dataType: 'json',
        //            data: { name: $scope.Name },
        //            headers: { "Content-Type": "application/json" }
        //        });

        //        post.success(function (data, status) {
        //            $window.alert(data.d);
        //        });

        //        post.error(function (data, status) {
        //            $window.alert(data.Message);
        //        });
        //    }
        //});
    </script>
</body>
</html>
