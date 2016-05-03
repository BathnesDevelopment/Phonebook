﻿$(document).ready(function () {


    ///////////////////////////////////////////////////
    // Initialize the ActiveX object that allows for 
    // Lync/Skype integration.
    // If it doesnt work (for whatever reason)
    // nameCtrl will not exist.
    ///////////////////////////////////////////////////
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

    // And set up the event handler for a status change (e.g. change to Busy)
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
    }


    ///////////////////////////////////////////////////
    // GET the phonebook data from the WebMethod in 
    // the code behind (GetDirectory)
    ///////////////////////////////////////////////////
    $.ajax({
        type: "POST",
        url: "Default.aspx/GetDirectory",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {

            $('#tablePhonebook')
                .on('dt.init', function () {
                    console.log('Table initialisation complete: ' + new Date().getTime());
                })
                .DataTable(
                {
                    data: msg.d,
                    "fnInitComplete": function (oSettings, json) {
                        console.log('Table initialisation complete: ' + new Date().getTime());
                    }, // We're expecting displayname, surname, givenname, jobtitle, manager, department, location, telephoneNumber, mobile, mail
                    columns: [
                        {
                            title: "Name",
                            render: function (data, type, full, meta) {
                                return '<div id=piDiv' + meta.row + '>' + data + '</a>'
                            }
                        },
                        //{ title: "Surname" },
                        //{ title: "Given name" },
                        { title: "Job title" },
                        { title: "Manager" },
                        { title: "Department" },
                        { title: "Location" },
                        { title: "Telephone" },
                        { title: "Mobile" },
                        { title: "Email" }
                    ]
                });

            $('#tablePhonebook').on('draw.dt', function () {
                alert('Table redrawn');
            });

            setTimeout(function () {
                $.each(msg.d, function (ind, data) {
                    if (nameCtrl) {
                        // data[7] is the email address - this is passed into the nameCtrl object to watch status 
                        // changes for that email address.
                        var email = data[7];
                        nameCtrl.GetStatus(email, 'piDiv' + ind);
                        var myDiv = document.getElementById('piDiv' + ind);
                        if (myDiv) {
                            myDiv.onmouseover = function () {
                                nameCtrl.ShowOOUI(email, 0, 10, 10);
                            }
                            myDiv.onmouseout = function () {
                                nameCtrl.HideOOUI();
                            }
                        }
                    }
                });
            }, 5000);
        }
    });
});