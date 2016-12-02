$(document).ready(function () {

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
                div.classList.remove("status");
                div.classList.remove("status-available");
                div.classList.remove("status-offline");
                div.classList.remove("status-away");
                div.classList.remove("status-inacall");
                div.classList.remove("status-inameeting");
                div.classList.remove("status-outofoffice");
                div.classList.remove("status-busy");
                div.classList.remove("status-donotdisturb");

                document.getElementById(id).classList.add('status');
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
                        //inameeting
                        document.getElementById(id).classList.add('status-inameeting');
                        break;
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
        async: true,
        success: function (msg) {

            // Set a row ID
            $.each(msg.d, function (i,x) {
                x['DT_RowId'] = 'tr' + i;
            });

            $('.loading').hide();
            var attachToSkype = function () {
                var divs = $('div[id^="piDiv"]');
                $.each(divs, function (ind, div) {
                    if (nameCtrl && !div.skypeAttached) {

                        // The div id will look somethign like piDiv1123
                        var index = parseInt(div.id.substring(5));

                        // data[7] is the email address - this is passed into the nameCtrl object to watch status 
                        // changes for that email address.
                        var email = msg.d[index][7];
                        nameCtrl.GetStatus(email, div.id);

                        if (div) {
                            div.onmouseover = function () {
                                nameCtrl.ShowOOUI(email, 0, 10, 10);
                            }
                            div.onmouseout = function () {
                                nameCtrl.HideOOUI();
                            }
                        }
                        // Attach a flag on the DIV to show we've done it.
                        div.skypeAttached = true;
                    }
                });
            };

            $('#tablePhonebook')
                .on('init.dt', function () {
                    attachToSkype();
                })
                .DataTable( 
                {                    
                    processing: true,
                    caseSensitive: false,
                    dom: 'Bfrtip',

                    select: {
                        items: 'cells',
                       // info: false
                    },

                    //buttons: [
                    //    {
                    //        extend: 'print',
                    //        text: 'Print',
                    //        className: ''

                    //    },
                    //    {
                    //        extend: 'excelHtml5',
                    //        text: 'Export Excel',
                    //        className: ''

                    //    }
                    //],
                    deferRender: true,
                    data: msg.d,
                    // We're expecting displayname, surname, givenname, jobtitle, department, location, telephoneNumber, groupNumber, mobile, mail
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
                        //{ title: "Manager", visible: true },
                        { title: "Department" },
                        { title: "Office" },
                        { title: "Telephone" },
                        { title: "Dept Number" },
                        { title: "Mobile", visible: true },
                        { title: "Email", visible: true }
                    ],
                        
                    order: [[0, 'asc']],                   
                    /**
                    
                    JW - Removed the grouping by dept as no longer required

                    drawCallback: function (settings) {
                        var api = this.api();
                        var rows = api.rows({ page: 'current' }).nodes();
                        var last = null;
                        
                                                   
                        //api.column(2, { page: 'current' }).data().each(function (group, i) {
                        api.column(2, { page: 'current' }).data().each(function (group, i) {
                           if (group != '' && last !== group) {                                
                                $(rows).eq(i).before(
                                    //'<tr class="grouping"><td colspan="5">Manager: ' + group + '</td></tr>'
                                    '<tr class="grouping"><td colspan="6">Department: ' + group + '</td></tr>'
                                );
                                last = group;
                            }
                        });                     
                    },
**/

                    // Change the serach label to Search Filter
                    "oLanguage": {
                        "sSearch": "Search Filter:"
                    }

                });
                      
            $('#tablePhonebook').on('draw.dt', function () {
                attachToSkype();

            });

            // MS - 3.6.16
            // Setup - add a text input to each footer cell            
            $('#tablePhonebook tfoot th').each(function (i) {
                var title = $('#tablePhonebook thead th').eq($(this).index()).text();
                $(this).html('<input type="text" placeholder="Filter ' + title + '" data-index="' + i + '" style="height: 30px;"/>');
            });

            // DataTable
            var table = $('#tablePhonebook').DataTable();
            // Hide columns
            //table.columns([2, 6, 7]).visible(false, false); //Manager, Mobile, Email
            //table.columns([3, 6, 7]).visible(false, false); //Department, Mobile, Email
            table.columns([6, 7]).visible(false, false); //Mobile, Email
            table.columns.adjust().draw(false); // adjust column sizing and redraw
            
            //JW - Added the ability to click on a cell which results in a filter being applied to that column only based on the contents of the cell.
 
            $('#tablePhonebook tbody').on('click', 'td', function () {
              
                table
                    .search("");

                var data = table.cell(this).data();
                var col = table.column($(this).index());
                var title = $('#tablePhonebook thead th').eq($(this).index()).text();

                var foot = document.getElementsByTagName("tfoot")[0];
                foot.getElementsByTagName("th")[col[0]].innerHTML = '<input type="text" placeholder="Filter ' + title + '" data-index="' + col[0] + '" value="' + data + '"></input';

                table
                    .column($(this).index() + ':visIdx')
                    .search('"' + data + '"')
                    .draw();
                                
            });

            //JW - Button added that will clear all filters and re-draw the table
 
            $('#clearFilterBtn').on('click', function () {
                
                var head = document.getElementsByTagName("thead")[0];
                var foot = document.getElementsByTagName("tfoot")[0];

                for (i = 0; i < 6; i++) {
                    var headValue = head.getElementsByTagName("th")[i];
                    foot.getElementsByTagName("th")[i].innerHTML = '<input type="text" placeholder="Filter ' + headValue.outerText + '" data-index="' + i + '" value=""></input>';
                    
                    table
                        .column($(headValue).index() + ':visIdx')
                        .search("")
                }

                table
                    .draw()
                    .search("");
            });
            

            //JW - Added the ability to click on a cell which results in a filter being applied to the entire table based on the contents of the cell.
            //$('#tablePhonebook tbody').on('click', 'td', function () {
            //    table
            //        .search(table.cell(this).data())
            //        .draw();
            //});

            // Filter event handler

            $(table.table().container()).on('keyup', 'tfoot input', function () {
                table
                    .column($(this).data('index'))
                    .search(this.value)
                    .draw();
            });
                 
        }
    });    
});

