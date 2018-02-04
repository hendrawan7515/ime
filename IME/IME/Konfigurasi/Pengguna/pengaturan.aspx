<%@ Page Title="Pengaturan Pengguna" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="pengaturan.aspx.vb" Inherits="IME.pengaturan" %>

<asp:Content ID="StyleContent" ContentPlaceHolderID="StylePlaceHolder" runat="server">
    <link href="../../Scripts/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class="page-header">
                    <h1><i class="fa fa-file-text"></i>
                        <small>Pengaturan Pengguna</small>
                    </h1>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="panel panel-default">
                <div class="panel-body">

                    <div class="container-fluid">
                        
                        <%-- START ACTION + SEARCH  --%>

                        <div class="row vert-pad-10px">
                            <div class="col-md-3">
                                <div class="form-group btn-group">
                                    <a class="btn btn-default"><i class="fa fa-plus "></i></a>
                                    <a class="btn btn-default"><i class="fa fa-trash "></i></a>
                                    <a class="btn btn-default"><i class="fa fa-print "></i></a>
                                    <a class="btn btn-default"><i class="fa fa-upload "></i></a>
                                </div>
                            </div>
                            <div class='col-md-3 col-xs-6'>
                                <div class="form-group">
                                    <div class='input-group date' id='dtfrom'>
                                        <input type='text' class="form-control" />
                                        <span class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class='col-md-3 col-xs-6'>
                                <div class="form-group">
                                    <div class='input-group date' id='dtto'>
                                        <input type='text' class="form-control" />
                                        <span class="input-group-addon">
                                            <i class="fa fa-calendar"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <input type="text" class="form-control inline-block w75" id="searchby" />
                                <button type="button" class="btn btn-default"><i class="fa fa-search"></i></button>
                            </div>
                        </div>
                        
                        <%-- END ACTION + SEARCH --%>

                        <div class="row vert-pad-10px">
                            <div class="col-md-9">
                                <div class="bordered-panel">
                                    <div class="form-horizontal">
                                        <div class="form-group">
                                            <label for="textID" class="col-sm-2 control-label aligned-left">ID</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="textID" placeholder="ID Pengguna" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="textPassword" class="col-sm-2 control-label aligned-left">Kata Sandi</label>
                                            <div class="col-sm-10">
                                                <input type="password" class="form-control" id="textPassword" placeholder="Password" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-2 control-label aligned-left">Berlaku</label>
                                            <div class="col-sm-5">
                                                <div class='input-group date' id='dtdari'>
                                                    <input type='text' class="form-control" />
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class='input-group date' id='dthingga'>
                                                    <input type='text' class="form-control" />
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="textNama" class="col-sm-2 control-label aligned-left">Nama</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="textNama" placeholder="Nama" />
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="textJabatan" class="col-sm-2 control-label aligned-left">Jabatan</label>
                                            <div class="col-sm-10">
                                                <input type="text" class="form-control" id="textJabatan" placeholder="Jabatan" />
                                            </div>
                                        </div>
                                        
                                        <div class="form-group">
                                            <label for="textEmail" class="col-sm-2 control-label aligned-left">Email</label>
                                            <div class="col-sm-10">
                                                <input type="email" class="form-control" id="textEmail" placeholder="Email" />
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="bordered-panel aligned-center">
                                    <img src="../../Assets/img/default-avatar.png" alt="Avatar" class="img-responsive centered-panel max-300" />
                                    <hr class="max-300" />
                                    <button class="btn btn-default max-300">Unggah Foto <i class="fa fa-cloud-upload"></i></button>
                                </div>
                            </div>
                        </div>

                        <div class="row vert-pad-10px">
                            <div class="col-xs-3 col-xs-offset-6">
                                <button class="btn btn-primary w100">Reset <i class="fa fa-refresh"></i></button>
                            </div>
                            <div class="col-xs-3 ">
                                <button class="btn btn-primary w100">Simpan <i class="fa fa-save"></i></button>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>

</asp:Content>
<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptPlaceHolder" runat="server">
    <script src="../../Scripts/bootstrap.min.js"></script>
    <script src="../../Scripts/bootstrap-datetimepicker/moment/moment.min.js"></script>
    <script src="../../Scripts/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript">

        var app = angular.module('myApp', []);
        app.controller('myMenu', myMenu);

        $(function () {
            $('#dtdari').datetimepicker({
                format: 'DD/MM/YYYY'
            });
            $('#dthingga').datetimepicker({
                format: 'DD/MM/YYYY',
                useCurrent: false //Important! See issue #1075
            });
            $('#dtfrom').datetimepicker({
                format: 'DD/MM/YYYY'
            });
            $('#dtto').datetimepicker({
                format: 'DD/MM/YYYY',
                useCurrent: false //Important! See issue #1075
            });
            $("#dtdari").on("dp.change", function (e) {
                $('#dthingga').data("DateTimePicker").minDate(e.date);
            });
            $("#dthingga").on("dp.change", function (e) {
                $('#dtdari').data("DateTimePicker").maxDate(e.date);
            });
            $("#dtfrom").on("dp.change", function (e) {
                $('#dtto').data("DateTimePicker").minDate(e.date);
            });
            $("#dtto").on("dp.change", function (e) {
                $('#dtfrom').data("DateTimePicker").maxDate(e.date);
            });
        });
    </script>
</asp:Content>

