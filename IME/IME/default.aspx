<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="default.aspx.vb" Inherits="IME._default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login - IME+</title>

    <link rel="apple-touch-icon" sizes="180x180" href="~/favicons/apple-touch-icon.png" />
    <link rel="icon" type="image/png" sizes="32x32" href="~/favicons/favicon-32x32.png" />
    <link rel="icon" type="image/png" sizes="16x16" href="~/favicons/favicon-16x16.png" />
    <link rel="manifest" href="~/favicons/manifest.json" />
    <link rel="mask-icon" href="~/favicons/safari-pinned-tab.svg" color="#5bbad5" />
    <meta name="theme-color" content="#ffffff" />

    <link href="~/Content/bootstrap.min.css" rel="stylesheet" />
    <link href="~/Content/font-awesome.min.css" rel="stylesheet" />
    <link href="~/Assets/css/default.css" rel="stylesheet" />
</head>
<body data-ng-app="loginApps">

    <div class="container" data-ng-controller="login">
        <div class="row main">

            <div class="container">
                <div class="row">
                    <div class="col-md-3 col-md-offset-2 side-logo">
                        <div class="logo">
                            <img class="img-responsive" src="Assets/img/logo.png" alt="logo" />
                        </div>
                        <hr class="w80" />
                        <div class="div-center">
                            <h3>User</h3>
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
                                            <input type="text" class="form-control border-right" name="username" placeholder="ID Pengguna" data-ng-model="userinput.username" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="password" class="cols-sm-2 control-label"></label>
                                    <div class="cols-sm-10">
                                        <div class="input-group">
                                            <span class="input-group-addon border-left"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
                                            <input type="password" class="form-control border-right" name="password" placeholder="Kata Sandi" data-ng-model="userinput.password" />
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group ">
                                    <button type="button" class="btn btn-primary btn-lg btn-block login-button" data-ng-click="loginClick()">Sign in <i class="fa fa-sign-in"></i></button>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
    <script src="../../../Scripts/jquery-3.2.1.min.js"></script>
    <script src="../../../Scripts/angular.min.js"></script>
    <script src="../../../Scripts/AngularUI/angular-animate.min.js"></script>
    <script src="../../../Scripts/AngularUI/angular-sanitize.min.js"></script>
    <script src="../../../Scripts/AngularUI/ui-bootstrap-tpls-2.5.0.min.js"></script>

    <script type="text/javascript">

        var loginApps = angular.module('loginApps', ['ngAnimate', 'ngSanitize', 'ui.bootstrap']);
        
        function login($scope, $uibModal, $log, $document) {
            $scope.animationsEnabled = true;
            $scope.userinput = {username: '', password: ''};
            $scope.popup = { title: '', content: '' };
            $scope.loginClick = function () {
                //  cek kosong
                if ($scope.userinput.username == "" || $scope.userinput.password == "") {
                    $scope.popupConfirm('Error', 'Id Pengguna dan Kata Sandi wajib di isi !');
                } else {
                    // cek acc lock

                    //$scope.checklock();

                    // cek password

                    //$scope.checkpass();

                    // cek first login

                    //$scope.checklock();

                    $scope.open();
                }
            };

            $scope.popupConfirm = function (popupTitle, popupContent) {
                $scope.popup.title = popupTitle;
                $scope.popup.content = popupContent;
                console.log($scope.popup.title);
                console.log($scope.popup.content);
                var popInstance = $uibModal.open({
                    animation: true,
                    ariaLabelledBy: 'modal-title',
                    ariaDescribedBy: 'modal-body',
                    templateUrl: '../../../Template/ModalConfirm.html',
                    controller: 'ModalInstanceCtrl',
                    controllerAs: '$scope',

                    resolve: {
                        items: function () {
                            return $scope.popup;
                        }
                    }
                });

                popInstance.result.then(function () {
                    $log.info('confirm');
                }, function () {
                    $log.info('closed');
                });
            }

            $scope.open = function (size, parentSelector) {
                var parentElem = parentSelector ?
                  angular.element($document[0].querySelector('.modal-demo ' + parentSelector)) : undefined;
                var modalInstance = $uibModal.open({
                    animation: $scope.animationsEnabled,
                    ariaLabelledBy: 'modal-title',
                    ariaDescribedBy: 'modal-body',
                    templateUrl: '../../../Template/ResetPassword.html',
                    controller: 'ModalInstanceCtrl',
                    controllerAs: '$scope',
                    size: size,
                    appendTo: parentElem,
                    resolve: {
                        items: function () {
                            return $scope.userinput;
                        }
                    }
                });

                modalInstance.result.then(function (selectedItem) {
                    $scope.selected = selectedItem;
                }, function () {
                    $log.info('Modal dismissed at: ' + new Date());
                });
            };

        };
        
        // Please note that $uibModalInstance represents a modal window (instance) dependency.
        // It is not the same as the $uibModal service used above.

        var ModalInstanceCtrl = function ($scope, $uibModalInstance, items) {
            $scope.items = items;
            $scope.selected = {
                item: $scope.items[0]
            };

            $scope.ok = function () {
                $uibModalInstance.close($scope.selected.item);
            };

            $scope.cancel = function () {
                $uibModalInstance.dismiss('cancel');
            };

            $scope.confirm = function () {
                $uibModalInstance.close();
            };
        };
        
        loginApps.controller('login', login);
        loginApps.controller('ModalInstanceCtrl', ModalInstanceCtrl);
        //loginApps.controller('PopInstanceCtrl', PopInstanceCtrl);

    </script>
</body>
</html>
