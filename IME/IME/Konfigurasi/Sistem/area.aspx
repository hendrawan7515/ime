<%@ Page Title="Area Fungsional" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="area.aspx.vb" Inherits="IME.area" %>

<asp:Content ID="Content1" ContentPlaceHolderID="StylePlaceHolder" runat="server">
    <link href="../../Scripts/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="page-header">
                    <h1><i class="fa fa-file-text"></i>
                        <small>Area Fungsional</small>
                    </h1>
                </div>
            </div>
        </div>


        <div class="row" data-ng-controller="pagecontrol as vm" data-ng-init="initializedata()">
            <div class="panel panel-default">
                <div class="panel-body">

                    <div class="container-fluid">

                        <%-- START ACTION + SEARCH  --%>

                        <div class="row vert-pad-10px">
                            <div class="col-md-3">
                                <div class="form-group btn-group">
                                    <a href="./area-data.aspx" class="btn btn-default"><i class="fa fa-plus "></i></a>
                                    <a href="#" class="btn btn-default"><i class="fa fa-trash "></i></a>
                                    <a href="#" class="btn btn-default"><i class="fa fa-print "></i></a>
                                    <a href="#" class="btn btn-default"><i class="fa fa-upload "></i></a>
                                    <%--<button type="button" class="btn btn-default" data-ng-click="addData()"><i class="fa fa-plus "></i></button>
                                    <button type="button" class="btn btn-default" data-ng-click="deleteData()"><i class="fa fa-trash "></i></button>
                                    <button type="button" class="btn btn-default" data-ng-click="printData()"><i class="fa fa-print "></i></button>
                                    <button type="button" class="btn btn-default" data-ng-click="uploadData()"><i class="fa fa-upload "></i></button>--%>
                                </div>
                            </div>
                            <div class='col-md-3 col-xs-6'>
                                <div class="form-group">
                                    <div class="input-group" data-datetimepicker=""
                                        data-on-change="vm.update(vm.dateFrom, vm.dateTo)"
                                        data-ng-model="vm.dateFrom" data-options="vm.optionsFrom">
                                        <input class="form-control" />
                                        <span class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class='col-md-3 col-xs-6'>
                                <div class="form-group">
                                    <div class="input-group" data-datetimepicker=""
                                        data-on-change="vm.update(vm.dateFrom, vm.dateTo)"
                                        data-ng-model="vm.dateTo" data-options="vm.optionsTo">
                                        <input class="form-control" />
                                        <span class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <input type="text" class="form-control inline-block w75" id="searchby" data-ng-model="searchcrit" />
                                <button type="button" class="btn btn-default" data-ng-click="searchid()"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                        <%-- END ACTION + SEARCH --%>


                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Action</th>
                                        <th>Id</th>
                                        <th>Tanggal Berlaku</th>
                                        <th>Tanggal Berakhir</th>
                                        <th>Kode Area</th>
                                        <th>Dekripsi Singkat</th>
                                        <th>Deskripsi Lengkap</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr data-ng-repeat="item in items">
                                        <td>
                                            <input type="checkbox" />
                                            <a href="area-data.aspx?id={{ item.area_id }}"><i class="fa fa-edit" ></i></a>
                                        </td>
                                        <td>{{ item.area_id }}</td>
                                        <td>{{ item.start_date.replace('/Date(','').replace(')/','') | date: 'dd.MM.yyyy' }}</td>
                                        <td>{{ item.end_date.replace('/Date(','').replace(')/','') | date:'dd.MM.yyyy' }}</td>
                                        <td>{{ item.functional_area }}</td>
                                        <td>{{ item.stext }}</td>
                                        <td>{{ item.ltext }}</td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="server">
    <script src="../../Scripts/bootstrap.min.js"></script>
    <script src="../../Scripts/bootstrap-datetimepicker/moment/moment.min.js"></script>
    <script src="../../Scripts/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../../Scripts/bootstrap-datetimepicker/js/angular-eonasdan-datetimepicker.min.js"></script>
    <script type="text/javascript">
        
        var pagecontrol = function ($scope, $filter, $window, $http) {

            var vm = this;

            vm.dateFrom = new Date(moment());
            vm.dateTo = new Date(moment());

            vm.optionsFrom = { format: 'DD.MM.YYYY' };
            vm.optionsTo = { format: 'DD.MM.YYYY' };

            vm.update = function (dateFrom, dateTo) {
                vm.optionsFrom.maxDate = dateTo;
                vm.optionsTo.minDate = dateFrom;
            };

            vm.update(vm.dateFrom, vm.dateTo);

            $scope.searchcrit = '';
            $scope.items = { };

            $scope.initializedata = function () {
                var post = $http({
                    method: "POST",
                    url: "./area.aspx/InitializeData",
                    dataType: 'json',
                    data: { },
                    headers: { "Content-Type": "application/json" }
                }).then(function successCallBack(response) {
                    $scope.items = response.data.d;
                    console.log($scope.items);
                }, function errorCallBack(response) {
                    console.log(response);
                    alert('error occured');
                });
            }

            $scope.searchid = function () {
                var post = $http({
                    method: "POST",
                    url: "./area.aspx/SearchData",
                    dataType: 'json',
                    data: { id: $scope.searchcrit },
                    headers: { "Content-Type": "application/json" }
                }).then(function successCallBack(response) {
                    $scope.items = response.data.d;
                    console.log($scope.items);
                }, function errorCallBack(response) {
                    console.log(response);
                    alert('error occured');
                });
            }

        };

        var app = angular.module('myApp', ['ae-datetimepicker']);
        app.controller('myMenu', myMenu);
        app.controller('pagecontrol', pagecontrol)

    </script>
</asp:Content>
