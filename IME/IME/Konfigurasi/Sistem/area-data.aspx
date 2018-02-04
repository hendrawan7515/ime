<%@ Page Title="Area Fungsional Input" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="area-data.aspx.vb" Inherits="IME.area_data" %>

<asp:Content ID="Content1" ContentPlaceHolderID="StylePlaceHolder" runat="server">
    <link href="../../Scripts/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
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
                        <div class="row">

                            <div class="form-horizontal">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="areacode" class="col-md-4 align-left">Kode Area</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" id="areacode" placeholder="Kode Area" data-ng-model="inputData.functional_area" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="shortdesc" class="col-md-4 align-left">Deskripsi Singkat</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" id="shortdesc" placeholder="Deskripsi" data-ng-model="inputData.stext" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="fulldesc" class="col-md-4 align-left">Deskripsi Lengkap</label>
                                        <div class="col-md-8">
                                            <input type="text" class="form-control" id="fulldesc" placeholder="Deskripsi"  data-ng-model="inputData.ltext" />
                                        </div>
                                    </div>
                                </div>


                                <%--date time picker--%>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="dtdari" class="col-md-4 control-label aligned-left">Tanggal Berlaku</label>
                                        <div class="col-md-8">
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
                                    <div class="form-group">
                                        <label for="dthingga" class="col-md-4 control-label aligned-left">Tanggal Berakhir</label>
                                        <div class="col-md-8">
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

                                    <%-- end date time picker--%>
                                    
                                    <div class="form-group">
                                        <label for="fulldesc" class="col-md-4 align-left">Deskripsi Lengkap</label>
                                        <div class="col-md-8">
                                           <select class="form-control" data-ng-model="inputData.selected">
                                               <option data-ng-repeat="item in datas" value="{{ item.id }}">{{ item.name }}</option>
                                           </select>
                                        </div>
                                    </div>

                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="container-fluid">
                        <div class="row vert-pad-10px">
                            <div class="col-xs-3 ">
                                <a href="./area.aspx" class="btn btn-primary w100">Kembali <i class="fa fa-reply"></i></a>
                            </div>
                            <div class="col-xs-3 col-xs-offset-3">
                                <button type="button" class="btn btn-primary w100" data-ng-click="resetData()">Reset <i class="fa fa-refresh"></i></button>
                            </div>
                            <div class="col-xs-3 ">
                                <button type="button" class="btn btn-primary w100" data-ng-click="saveData()">Simpan <i class="fa fa-save"></i></button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptPlaceHolder" runat="server">
    <script src="../../../Scripts/bootstrap.min.js"></script>

    <script src="../../../Scripts/bootstrap-datetimepicker/moment/moment.min.js"></script>
    <script src="../../../Scripts/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script src="../../../Scripts/bootstrap-datetimepicker/js/angular-eonasdan-datetimepicker.min.js"></script>
    <script type="text/javascript">
        
        var pagecontrol = function ($scope, $location, $http ) {

            $scope.initializedata = function () {
                $scope.inputData = {
                    'area_id': '',
                    'functional_area': '',
                    'stext': '',
                    'ltext': '',
                    'start_date': moment(),
                    'end_date': moment(),
                    'selected': ''
                };

                var post = $http({
                    method: "POST",
                    url: "./area-data.aspx/InitializeData",
                    dataType: 'json',
                    data: { input: $scope.inputData  },
                    headers: { "Content-Type": "application/json" } 
                }).then(function successCallBack(response) {
                    $scope.inputData = response.data.d;
                    vm.dateFrom = moment($scope.inputData.start_date);
                    vm.dateTo = moment($scope.inputData.end_date);
                    console.log($scope.inputData);
                }, function errorCallBack(response) {
                    console.log(response);
                    alert('save failed');
                });

            }



            //  datetime picker
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
            //  end datetime picker



            // testing
            $scope.datas = [
                { 'id': 1, 'name': 'combo1' },
                { 'id': 2, 'name': 'combo2' },
                { 'id': 3, 'name': 'combo3' },
                { 'id': 4, 'name': 'combo4' }
            ]
            // end test

            $scope.resetData = function () {
                //console.log(vm.dateFrom);
                //console.log(vm.dateFrom._d);

                vm.dateFrom = moment("1/1/2017");
                //vm.dateTo = moment("12/31/9999");
                vm.dateTo = moment(253402189200000);

                $scope.inputData.functional_area = '';
                $scope.inputData.stext = '';
                $scope.inputData.ltext = '';
                
                console.log($scope.inputData);
            };

            $scope.saveData = function () {
                $scope.inputData.start_date = vm.dateFrom._d;
                $scope.inputData.end_date = vm.dateTo._d;
                console.log($scope.inputData);
                
                var post = $http({
                    method: "POST",
                    url: "./area-data.aspx/SaveArea",
                    dataType: 'json',
                    data: { input: $scope.inputData },
                    headers: { "Content-Type": "application/json" }
                }).then(function successCallBack(response) {
                    alert('save success');
                    console.log(response.data);

                }, function errorCallBack(response) {
                    console.log(response);
                    alert('save failed');
                });

            };

        };

        var app = angular.module('myApp', ['ae-datetimepicker']);

        // wajib untuk populate menu
        app.controller('myMenu', myMenu);
        // end populate menu

        app.controller('pagecontrol', pagecontrol)

    </script>
</asp:Content>
