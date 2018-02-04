<%@ Page Title="Hak Akses Pengguna" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="hak-akses.aspx.vb" Inherits="IME.hak_akses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="StylePlaceHolder" runat="server">
    <link href="../../Scripts/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />

    <style>
        .col-md-4.no-pad .col-sm-6 {
            padding-left: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="page-header">
                    <h1><i class="fa fa-file-text"></i>
                        <small>Hak Akses Pengguna</small>
                    </h1>
                </div>
            </div>
        </div>


        <div class="row" data-ng-controller="pagecontrol as vm">
            <div class="panel panel-default">
                <div class="panel-body">

                    <div class="container-fluid">

                        <%-- START ACTION + SEARCH  --%>

                        <div class="row vert-pad-10px">
                            <div class="col-md-3">
                                <div class="form-group btn-group">
                                    <button type="button" class="btn btn-default" data-ng-click="addData()"><i class="fa fa-plus "></i></button>
                                    <button type="button" class="btn btn-default" data-ng-click="deleteData()"><i class="fa fa-trash "></i></button>
                                    <button type="button" class="btn btn-default" data-ng-click="printData()"><i class="fa fa-print "></i></button>
                                    <button type="button" class="btn btn-default" data-ng-click="uploadData()"><i class="fa fa-upload "></i></button>
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
                                <button type="button" class="btn btn-default"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                        <%-- END ACTION + SEARCH --%>



                        <div class="row vert-pad-10px">

                            <div class="col-md-12">
                                <div class="bordered-panel">

                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label for="textID" class="col-sm-2 control-label aligned-left">ID</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="textID" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-2 control-label aligned-left">Berlaku</label>
                                            <div class="col-sm-5">
                                                <div class="input-group" data-datetimepicker=""
                                                    data-on-change="vm.updatedua(vm.dateDari, vm.dateHingga)"
                                                    data-ng-model="vm.dateDari" data-options="vm.optionsDari">
                                                    <input class="form-control" />
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="input-group" data-datetimepicker=""
                                                    data-on-change="vm.updatedua(vm.dateDari, vm.dateHingga)"
                                                    data-ng-model="vm.dateHingga" data-options="vm.optionsHingga">
                                                    <input class="form-control" />
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--DATA TABLE START--%>
                        <div class="row vert-pad-10px">
                            <div class="col-md-12">
                                <div class="bordered-panel">
                                    <div class="container-fluid no-pad mgn-btm-10px">
                                        <div class="col-md-4 no-pad">

                                            <label class="col-sm-6 control-label aligned-left">Area Fungsional</label>
                                            <div class="col-sm-6">
                                                <select class="form-control inline-block" id="area">
                                                    <option value="" disabled selected hidden>Area</option>
                                                    <option>HR</option>
                                                    <option>FA</option>
                                                </select>
                                            </div>
                                        </div>


                                        <div class="col-md-4 no-pad">

                                            <label class="col-sm-6 control-label aligned-left">Sub Area</label>
                                            <div class="col-sm-6">
                                                <select class="form-control inline-block" id="subarea">
                                                    <option value="" disabled selected hidden>Sub Area</option>
                                                    <option>HR</option>
                                                    <option>FA</option>
                                                </select>
                                            </div>

                                        </div>

                                        <div class="col-md-4 no-pad">

                                            <label class="col-sm-6 control-label aligned-left">Tipe Fungsional</label>
                                            <div class="col-sm-6">
                                                <select class="form-control inline-block" id="type">
                                                    <option value="" disabled selected hidden>Tipe</option>
                                                    <option>HR</option>
                                                    <option>FA</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="table-responsive">
                                        <table class="table table-bordered">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        <input type="checkbox" data-ng-model="all" />
                                                        Action
                                                    </th>
                                                    <th>ID Menu</th>
                                                    <th>Deskripsi</th>
                                                    <th>Start Date</th>
                                                    <th>End Date</th>
                                                    <th>Create</th>
                                                    <th>Edit</th>
                                                    <th>Delete</th>
                                                    <th>Display</th>
                                                    <th>Approve</th>
                                                    <th>Cancel</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr data-ng-repeat="items in access">
                                                    <td>
                                                        <input type="checkbox" data-ng-model="items.checks" data-ng-true-value="'1'" data-ng-false-value="'0'" /></td>
                                                    <td>{{items.id}}</td>
                                                    <td>{{items.deskripsi}}</td>
                                                    <td>{{items.startdate}}</td>
                                                    <td>{{items.enddate}}</td>
                                                    <td>
                                                        <input type="checkbox" data-ng-model="items.create" data-ng-true-value="'1'" data-ng-false-value="'0'" /></td>
                                                    <td>
                                                        <input type="checkbox" data-ng-model="items.edit" data-ng-true-value="'1'" data-ng-false-value="'0'" /></td>
                                                    <td>
                                                        <input type="checkbox" data-ng-model="items.delete" data-ng-true-value="'1'" data-ng-false-value="'0'" /></td>
                                                    <td>
                                                        <input type="checkbox" data-ng-model="items.display" data-ng-true-value="'1'" data-ng-false-value="'0'" /></td>
                                                    <td>
                                                        <input type="checkbox" data-ng-model="items.approve" data-ng-true-value="'1'" data-ng-false-value="'0'" /></td>
                                                    <td>
                                                        <input type="checkbox" data-ng-model="items.cancel" data-ng-true-value="'1'" data-ng-false-value="'0'" /></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <pre>{{ access | json }}</pre>
                                    </div>
                                </div>
                            </div>
                            <%--DATA TABLE END--%>
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

        var pagecontrol = function ($scope, $filter) {
            $scope.transaction = {};

            $scope.addData = function () {
                alert('test add');
            };

            $scope.deleteData = function () {
                //alert('test delete');

                console.log($scope.access);
                // kirim semua, select d code behind

            };

            $scope.printData = function () {
                alert(vm.dateDari);
            };

            $scope.uploadData = function () {
                alert(vm.dateHingga);
            }

            $scope.access = [
                { "checks": "0", "id": "HR0007", "deskripsi": "Parameter SSDM", "startdate": "01.01.2017", "enddate": "31.12.9999", "create": "1", "edit": "0", "delete": "1", "display": "1", "approve": "0", "cancel": "1" },
                { "checks": "1", "id": "HR0008", "deskripsi": "Parameter SDM", "startdate": "01.01.2017", "enddate": "31.12.9999", "create": "0", "edit": "1", "delete": "1", "display": "1", "approve": "1", "cancel": "1" },
                { "checks": "1", "id": "HR0009", "deskripsi": "Parameter SDM", "startdate": "01.01.2017", "enddate": "31.12.9999", "create": "0", "edit": "1", "delete": "1", "display": "1", "approve": "1", "cancel": "1" }
            ];



            var vm = this;

            vm.dateFrom = new Date(moment());
            vm.dateTo = new Date(moment());


            vm.dateDari = new Date(moment());
            vm.dateHingga = new Date(moment());

            vm.optionsFrom = { format: 'DD.MM.YYYY' };
            vm.optionsTo = { format: 'DD.MM.YYYY' };
            vm.optionsDari = { format: 'DD.MM.YYYY' };
            vm.optionsHingga = { format: 'DD.MM.YYYY' };

            vm.update = function (dateFrom, dateTo) {
                vm.optionsFrom.maxDate = dateTo;
                vm.optionsTo.minDate = dateFrom;
            };

            vm.updatedua = function (dateDari, dateHingga) {
                vm.optionsDari.maxDate = dateHingga;
                vm.optionsHingga.minDate = dateDari;
            };

            vm.update(vm.dateFrom, vm.dateTo);
            vm.updatedua(vm.dateDari, vm.dateHingga);

        };

        var app = angular.module('myApp', ['ae-datetimepicker']);

        app.controller('myMenu', myMenu);
        app.controller('pagecontrol', pagecontrol)
    </script>
</asp:Content>
