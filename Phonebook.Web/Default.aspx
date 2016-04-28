<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="scripts/html5shiv.min.js"></script>
      <script src="scripts/respond.min.js"></script>
    <![endif]-->
    <title>Title | Bath and North East Somerset Council</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/internal.css" rel="stylesheet">
    <link href="//cdn.datatables.net/1.10.11/css/jquery.dataTables.min.css" rel="stylesheet">
    
</head>
<body>
    <div class="container">
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="/">
                        <img src="/images/logo.svg" />
                    </a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav"></ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="mailto:IT_Helpdesk@bathnes.gov.uk">Report Issue</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>
    <!-- Option Jumbotron - remove if not wanted. -->
    <div class="jumbotron">
        <div class="container">
            <h1>Phonebook</h1>
            <p>B&NES Council phonebook</p>
        </div>
    </div>
    <!-- End optional Jumbotron-->
    <div class="container">
        <!-- Page content goes in here -->
        
        <table class="table" id="tablePhonebook">
            <thead>
                <tr>
                    <td>Name</td>
                    <td>Department</td>
                    <td>Phone number</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>Dave</td>
                    <td>IT</td>
                    <td>7356</td>
                </tr>
            </tbody>
        </table>



        <!-- End page content -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <ul class="list-unstyled">
                        <li class="pull-right"><a href="#top">Back to top</a></li>
                    </ul>
                </div>
            </div>
        </footer>
    </div>
    <script src="scripts/jquery.min.js"></script>
    <script src="scripts/bootstrap.min.js" type="text/javascript"></script>
    <script src="//cdn.datatables.net/1.10.11/js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script>
        $(document).ready(function () {
            $('#tablePhonebook').DataTable();
        });
    </script>
</body>
</html>