<%@ Page Title="Dashboard" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="dashboard.aspx.vb" Inherits="IME.dashboard" %>

<asp:Content ID="StyleContent" ContentPlaceHolderID="StylePlaceHolder" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="page-header">
                    <h1>Dashboard <small> charts</small></h1>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6" data-ng-controller="myBarControl">
                <div class="panel panel-default">
                    <div class="panel-heading">Bar Chart</div>
                    <div class="panel-body">
                        <canvas id="bar" class="chart chart-bar" data-chart-data="data" data-chart-labels="labels" data-chart-series="series"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6" data-ng-controller="myLineControl">
                <div class="panel panel-default">
                    <div class="panel-heading">Line Chart</div>
                    <div class="panel-body">
                        <canvas id="line" class="chart chart-line" data-chart-data="data" data-chart-labels="labels" data-chart-series="series" data-chart-options="options" data-chart-dataset-override="datasetOverride" data-chart-click="onClick"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6" data-ng-controller="myHoriBarControl">
                <div class="panel panel-default">
                    <div class="panel-heading">Bar Chart</div>
                    <div class="panel-body">
                        <canvas id="hori" class="chart-horizontal-bar" data-chart-data="data" data-chart-labels="labels"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6" data-ng-controller="myBubbleControl">
                <div class="panel panel-default">
                    <div class="panel-heading">Bubble Chart</div>
                    <div class="panel-body">
                        <canvas id="base" class="chart-bubble" data-chart-data="data" data-chart-series="series"></canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptPlaceHolder" runat="server">
    <script src="Scripts/ChartJS/Chart.min.js"></script>
    <script src="Scripts/AngularChart/angular-chart.min.js"></script>

    <script type="text/javascript">
        var myBarControl = function ($scope) {
            $scope.labels = ['2006', '2007', '2008', '2009', '2010', '2011', '2012'];
            $scope.series = ['Series A', 'Series B', 'Series C'];

            $scope.data = [
              [65, 59, 80, 81, 56, 55, 40],
              [43, 23, 45, 89, 34, 16, 93],
              [28, 48, 40, 19, 86, 27, 90]
            ];

        }

        var myLineControl = function ($scope) {
            $scope.labels = ["January", "February", "March", "April", "May", "June", "July"];
            $scope.series = ['Series A', 'Series B'];
            $scope.data = [
              [65, 59, 80, 81, 56, 55, 40],
              [28, 48, 40, 19, 86, 27, 90]
            ];
            $scope.onClick = function (points, evt) {
                console.log(points, evt);
            };
            $scope.datasetOverride = [{ yAxisID: 'y-axis-1' }, { yAxisID: 'y-axis-2' }];
            $scope.options = {
                scales: {
                    yAxes: [
                      {
                          id: 'y-axis-1',
                          type: 'linear',
                          display: true,
                          position: 'left'
                      },
                      {
                          id: 'y-axis-2',
                          type: 'linear',
                          display: true,
                          position: 'right'
                      }
                    ]
                }
            };
        }

        var myHoriBarControl = function ($scope) {
            $scope.labels = ['2006', '2007', '2008', '2009', '2010', '2011', '2012'];
            $scope.series = ['Series A', 'Series B'];

            $scope.data = [
              [65, 59, 80, 81, 56, 55, 40],
              [28, 48, 40, 19, 86, 27, 90]
            ];
        }

        var myBubbleControl = function ($scope, $interval) {

            $scope.options = {
                scales: {
                    xAxes: [{
                        display: false,
                        ticks: {
                            max: 125,
                            min: -125,
                            stepSize: 10
                        }
                    }],
                    yAxes: [{
                        display: false,
                        ticks: {
                            max: 125,
                            min: -125,
                            stepSize: 10
                        }
                    }]
                }
            };

            createChart();
            $interval(createChart, 3000);

            function createChart() {
                $scope.series = [];
                $scope.data = [];
                for (var i = 0; i < 50; i++) {
                    $scope.series.push(`Series ${i}`);
                    $scope.data.push([{
                        x: randomScalingFactor(),
                        y: randomScalingFactor(),
                        r: randomRadius()
                    }]);
                }
            }

            function randomScalingFactor() {
                return (Math.random() > 0.5 ? 1.0 : -1.0) * Math.round(Math.random() * 100);
            }

            function randomRadius() {
                return Math.abs(randomScalingFactor()) / 4;
            }
        }

        var app = angular.module('myApp', ['chart.js']);
        app.controller('myLineControl', myLineControl);
        app.controller('myBarControl', myBarControl);
        app.controller('myHoriBarControl', myHoriBarControl);
        app.controller('myBubbleControl', myBubbleControl);
        app.controller('myMenu', myMenu);
    </script>
</asp:Content>
