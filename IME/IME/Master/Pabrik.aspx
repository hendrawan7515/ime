<%@ Page Title="Master Pabrik" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Pabrik.aspx.vb" Inherits="IME.Pabrik" %>

<asp:Content ID="StyleContent" ContentPlaceHolderID="StylePlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="container-fluid" data-ng-controller="myControl">
        <div class="row">
            <div class="col-md-12">
                <div class="page-header">
                    <h1>Master <small>pabrik</small></h1>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading" id="label1">label1</div>
                    <div class="panel-body">
                        Panel content
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title" id="label2">label2</h3>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" class="form-control" id="exampleInputEmail1" placeholder="Email" data-ng-model="firstname" />
                        </div>

                        <div>
                            Name:
                            <input data-ng-model="firstname" />
                            <h1>{{firstname}}</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <table class="table table-striped table-bordered">
                    <thead>
                        <tr>
                            <th>userid</th>
                            <th>id</th>
                            <th>title</th>
                            <th>action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr data-ng-repeat="data in resdata">
                            <td>{{ data.userId }}</td>
                            <td>{{ data.id }}</td>
                            <td>{{ data.title }}</td>
                            <td><a data-ng-style="{{ 1==1 ? color:red }}" href="#{{ data.id }}"><i class="fa fa-2x fa-edit"></i></a> <i class="fa fa-remove fa-2x"></i></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>


        <div class="row">
            <div class="col-md-6">
                <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default lang-en">English</button>
                    <button type="button" class="btn btn-default lang-bi">Bahasa</button>
                    <button type="button" class="btn btn-default lang-ru">Russia</button>
                </div>
            </div>
            <div class="col-md-6">
                <%--<pre>{{ resdata | json }}</pre>--%>
            </div>
        </div>

    </div>
</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptPlaceHolder" runat="server">
    <script type="text/javascript">
        $("#label1").text("Master Pabrik");

        var lang = 'en';

        myControl = function ($scope, $http) {
            $scope.angular = "Wow";
            $scope.firstname = "John";
            $scope.resdata = [];

            $http({
                method: 'GET',
                url: 'https://jsonplaceholder.typicode.com/posts'
            }).then(function successCallback(response) {
                // this callback will be called asynchronously
                // when the response is available
                $scope.resdata = response.data;
            }, function errorCallback(response) {
                // called asynchronously if an error occurs
                // or server returns response with an error status.
            });
        };

        myApp.controller('myControl', myControl);

        UpdateLang = function () {
            if (lang == 'en') {
                $("#label1").text("Mill Master");
                $("#label2").text("List Master Data");
            } else if (lang == 'bi') {
                $("#label1").text("Master Pabrik");
                $("#label2").text("Daftar Master Data");
            } else {
                $("#label1").text("Мастер мельницы");
                $("#label2").text("Список основных данных");
            };
        }

        $('.lang-en').click(function () {
            lang = 'en';
            UpdateLang();
        });

        $('.lang-bi').click(function () {
            lang = 'bi';
            UpdateLang();
        });

        $('.lang-ru').click(function () {
            lang = 'ru';
            UpdateLang();
        });

    </script>
</asp:Content>
