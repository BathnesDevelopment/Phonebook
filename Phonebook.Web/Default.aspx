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
    <style>
        .status-available {
            border-left: 3px solid #5DD255;
            padding-left: 5px;
        }

        .status-offline {
            border-left: 3px solid #B6CFD8;
            padding-left: 5px;
        }

        .status-away {
            border-left: 3px solid #FFD200;
            padding-left: 5px;
        }

        .status-inacall {
            border-left: 3px solid red;
            padding-left: 5px;
        }
    </style>
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
        <table class="table" id="tablePhonebook"></table>
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
            $.ajax({
                type: "POST",
                url: "Default.aspx/GetDirectory",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {

                    if (window.ActiveXObject) {
                        nameCtrl = new ActiveXObject("Name.NameCtrl");
                    } else {
                        try {
                            nameCtrl = new ActiveXObject("Name.NameCtrl");
                        } catch (e) {
                            nameCtrl = (function (b) {
                                var c = null;
                                try {
                                    c = document.getElementById(b);
                                    if (!Boolean(c) && (Boolean(navigator.mimeTypes) && navigator.mimeTypes[b] && navigator.mimeTypes[b].enabledPlugin)) {
                                        var a = document.createElement("object");
                                        a.id = b;
                                        a.type = b;
                                        a.width = "0";
                                        a.height = "0";
                                        a.style.setProperty("visibility", "hidden", "");
                                        document.body.appendChild(a);
                                        c = document.getElementById(b)
                                    }
                                } catch (d) {
                                    c = null
                                }
                                return c
                            })("application/x-sharepoint-uc");
                        }
                    }

                    if (nameCtrl && nameCtrl.PresenceEnabled) {

                        nameCtrl.OnStatusChange = function (userName, status, id) {
                            var div = document.getElementById(id);

                            if (div) {
                                div.classList.remove("status-available", "status-offline", "status-away", "status-inacall", "status-outofoffice", "status-busy", "status-donotdisturb");
                                switch (status) {
                                    case 0:
                                        //available
                                        document.getElementById(id).classList.add('status-available');
                                        break;
                                    case 1:
                                        // offline
                                        document.getElementById(id).classList.add('status-offline');
                                        break;
                                    case 2:
                                    case 4:
                                    case 16:
                                        //away
                                        document.getElementById(id).classList.add('status-away');
                                        break;
                                    case 3:
                                    case 5:
                                        //inacall
                                        document.getElementById(id).classList.add('status-inacall');
                                        break;
                                    case 6:
                                    case 7:
                                    case 8:
                                        document.getElementById(id).classList.add('status-outofoffice');
                                        break;
                                    case 10:
                                        //busy
                                        document.getElementById(id).classList.add('status-busy');
                                        break;
                                    case 9:
                                    case 15:
                                        //donotdisturb
                                        document.getElementById(id).classList.add('status-donotdisturb');
                                        break;
                                }
                            }
                        };

                        $('#tablePhonebook').DataTable(
                        {
                            data: msg.d,
                            "fnInitComplete": function (oSettings, json) {

                            }, // We're expecting displayname, surname, givenname, jobtitle, manager, department, location, telephoneNumber, mobile, mail
                            columns: [
                                {
                                    title: "Name",
                                    render: function (data, type, full, meta) {
                                        return '<div id=piDiv' + meta.row + '>' + data + '</a>'
                                    }
                                },
                                { title: "Surname" },
                                { title: "Given name" },
                                { title: "Job title" },
                                { title: "Manager" },
                                { title: "Department" },
                                { title: "Location" },
                                { title: "Telephone" },
                                { title: "Mobile" },
                                { title: "Email" }
                            ]
                        });

                        setTimeout(function () {
                            $.each(msg.d, function (ind, data) {
                                nameCtrl.GetStatus(data[9], 'piDiv' + ind);

                                var myDiv = document.getElementById('piDiv' + ind);
                                if (myDiv) {
                                    myDiv.onmouseover = function () {
                                        nameCtrl.ShowOOUI(data[9], 0, 10, 10);
                                    }
                                    myDiv.onmouseout = function () {
                                        nameCtrl.HideOOUI();
                                    }
                                }
                            });
                        }, 5000);
                    }
                }
            });
        });
    </script>
</body>
</html>