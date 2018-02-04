<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TestDialog.aspx.vb" Inherits="IME.TestDialog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Test Dialog AngularJS</title>
    <%--<link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.0/css/bootstrap-combined.min.css" rel="stylesheet" />--%>
    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <link href="~/Content/font-awesome.min.css" rel="stylesheet" />
    <link href="Assets/css/site.css" rel="stylesheet" />
    <link href="~/Assets/css/default.css" rel="stylesheet" />
    
</head>
<body ng-app="plunker">
        <div ng-controller="ListCtrl">

            <div class="container">
                <div class="row main">

                    <div class="container">
                        <div class="row">
                            <div class="col-md-3 col-md-offset-2 side-logo">
                                <div class="logo">
                                    <img class="img-responsive" src="Assets/img/logo.png" alt="logo" />
                                </div>
                                <hr class="w80" />
                                <div class="div-center">
                                    <h3>User{{ 1 + 1 }}</h3>
                                    <h1>Login</h1>
                                </div>

                            </div>

                            <div class="col-md-5">
                                <div class="main-login main-center">
                                    <div class="avatar"></div>
                                    <form class="form-horizontal" runat="server" id="loginForm">
                                        <div class="form-group">
                                            <label for="username" class="cols-sm-2 control-label"></label>
                                            <div class="cols-sm-10">
                                                <div class="input-group">
                                                    <span class="input-group-addon border-left"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                                                    <asp:TextBox runat="server" type="text" class="form-control border-right" name="username" ID="username" placeholder="ID Pengguna" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="password" class="cols-sm-2 control-label"></label>
                                            <div class="cols-sm-10">
                                                <div class="input-group">
                                                    <span class="input-group-addon border-left"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                                                    <asp:TextBox runat="server" type="password" class="form-control border-right" name="password" ID="password" placeholder="Kata Sandi" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group ">
                                            <button type="button" class="btn btn-primary btn-lg btn-block login-button" data-ng-click="resetPassword(dsa)">Sign in <i class="fa fa-sign-in"></i></button>
                                        </div>
                                    </form>

                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Value</th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr ng-repeat="item in items">
                                                <td>{{item.name}}</td>
                                                <td>{{item.value}}</td>
                                                <td>
                                                    <button type="button" class="btn btn-small" ng-click="edit(item)">Edit</button></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
            
    <script src="Scripts/jquery-3.2.1.min.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.0.5/angular.js"></script>
    <script src="http://angular-ui.github.com/bootstrap/ui-bootstrap-tpls-0.1.0.js"></script>
    <script type="text/javascript">
        angular.module('plunker', ['ui.bootstrap']);

        function ListCtrl($scope, $dialog) {

            $scope.items = [
              { name: 'foo', value: 'foo value' },
              { name: 'bar', value: 'bar value' },
              { name: 'baz', value: 'baz value' }
            ];

            var dialogOptions = {
                controller: 'EditCtrl',
                templateUrl: 'ResetPassword.html'
            };

            $scope.edit = function (item) {

                var itemToEdit = item;

                $dialog.dialog(angular.extend(dialogOptions, { resolve: { item: angular.copy(itemToEdit) } }))
                  .open()
                  .then(function (result) {
                      if (result) {
                          angular.copy(result, itemToEdit);
                      }
                      itemToEdit = undefined;
                  });
            };
        }
        // the dialog is injected in the specified controller
        function EditCtrl($scope, item, dialog) {

            $scope.item = item;

            $scope.save = function () {
                dialog.close($scope.item);
            };

            $scope.close = function () {
                dialog.close(undefined);
            };
        }
    </script>
</body>

</html>
