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
    <title>Phonebook | Bath and North East Somerset Council</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/phonebook.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/t/bs/dt-1.10.11/datatables.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/buttons/1.1.2/css/buttons.bootstrap.min.css" rel="stylesheet">
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
                    <a class="navbar-brand" href="http://intranet/">
                        <img src="/images/logo.svg" />
                    </a>
                </div>

                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li><a href="http://intranet/dash-news">News</a></li>
                        <li><a href="http://intranet/dash-flexible">Flexible working</a></li>
                        <li><a href="http://intranet/dash-working">HR + Payroll</a></li>
                        <li><a href="http://intranet/dash-procurement">Procurement + Finance</a></li>
                        <li><a href="http://intranet/dash-it">IT</a></li>
                        <li><a href="http://intranet/dash-social">Social</a></li>
                        <li><a href="http://intranet/dash-getting-about">Getting About</a></li>
                        <li><a href="http://intranet/dash-tools">Useful Tools</a></li>
                        <li><a href="http://phonebook.bathnes.gov.uk">Phonebook</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                    </ul>
                </div>
            </div>
        </nav>
    </div>
    <!-- Option Jumbotron - remove if not wanted. -->
    <div class="jumbotron">
        <div class="container">
            <h1>#Phonebook</h1>
            <p>B&amp;NES Council phonebook</p>
<%--			<small>If your phone number is incorrect please contact the IT Helpdesk on 7252</small>--%> 
            <p>
                <a class="btn btn-success" target="_blank" href="phonebook_userguide.pdf">User Guide</a>
                <a href="#" class="btn btn-success" data-toggle="modal" data-target="#formModal">Request Update</a>
                <a class="btn btn-success" target="_blank" href="http://intranet/site-codes-and-address-0">Site Codes</a>
            </p>
            <p class="loading">Loading</p>
        </div>
    </div>
    <!-- End optional Jumbotron-->
    <div class="container">
        <!-- Page content goes in here -->
        
        <table class="table" id="tablePhonebook"><tfoot><tr>
                            <!-- Matthew Steer added this on 6.6.16 -->
                            <th rowspan="1" colspan="1"><input type="text"></th>
                            <th rowspan="1" colspan="1"><input type="text"></th>
                            <th rowspan="1" colspan="1"><input type="text"></th> 
                            <th rowspan="1" colspan="1"><input type="text"></th>                           
                            <th rowspan="1" colspan="1"><input type="text"></th>
                            <th rowspan="1" colspan="1"><input type="text"></th>                            
                            <th rowspan="1" colspan="1"><input type="text"></th>       
					</tr></tfoot></table>
        
                    <div class="modal fade" id="formModal" tabindex="-1" role="dialog" aria-labelledby="formModal" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button class="close" aria-hidden="true" type="button" data-dismiss="modal">&times;</button>
                        <h4 class="modal-title">Phonebook Update Request</h4>
                    </div>
                    <div class="modal-body">
                        <p>Use the following form to request updates to the Phonebook</p>


                     <form id="frm" runat="server">                   
                        <table>
                           <tr>
                            <td>Name:  </td>
                            <td><asp:TextBox ID="txtName" runat="server" Columns="30" Font-Size="Small"></asp:TextBox></td>
                            </tr>
                            <tr>
                            <td>Job Title:  </td>
                            <td><asp:TextBox ID="txtJobTitle" runat="server" Columns="30" Font-Size="Small"></asp:TextBox></td>
                            </tr>
                            <tr>
                            <td>Department:  </td>
                            <td><asp:TextBox ID="txtDept" runat="server" Columns="30" Font-Size="Small"></asp:TextBox></td>
                            </tr>
                            <tr>
                            <td>Office:  </td>
                            <td><asp:TextBox ID="txtLocation" runat="server" Columns="30" Font-Size="Small"></asp:TextBox></td>
                            </tr>
                            <tr>
                            <td>Telephone:  </td>
                            <td><asp:TextBox ID="txtTelephone" runat="server" Columns="30" Font-Size="Small"></asp:TextBox></td>
                            </tr>
                            <tr>
                            <td>Dept Number:  </td>
                            <td><asp:TextBox ID="txtGroupNumber" runat="server" Columns="30" Font-Size="Small"></asp:TextBox></td>
                            </tr>
                            <tr>
                            <td>Comments:  </td>
                            <td><asp:TextBox ID="txtComments" runat="server" Columns="40" TextMode="MultiLine" Font-Size="Small" ></asp:TextBox></td>
                            </tr>
                            <tr>
                            <td></td>
                            <td><asp:Button Text="Send Request" OnClick="SendEmail" runat="server" /></td>
                            </tr>
                         </table>
                         </form>


                        <div></div>
                    </div>
                </div>
            </div>
        </div>

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
    <script src="scripts/jquery.min.js" type="text/javascript"></script>
    <script src="scripts/bootstrap.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/2.6.0/jszip.min.js" type="text/javascript"></script>
    <script src="https://cdn.datatables.net/t/bs/dt-1.10.11/datatables.min.js" type="text/javascript"></script>
    <script src="https://cdn.datatables.net/buttons/1.1.2/js/buttons.html5.min.js" type="text/javascript"></script>
<!--<script src="https://cdn.datatables.net/buttons/1.1.2/js/dataTables.buttons.min.js" type="text/javascript"></script>-->
<!--<script src="https://cdn.datatables.net/buttons/1.1.2/js/buttons.bootstrap.min.js" type="text/javascript"></script>-->
<!--<script src="https://cdn.datatables.net/buttons/1.1.2/js/buttons.print.min.js" type="text/javascript"></script>-->
    <script src="scripts/phonebook.js" type="text/javascript"></script>


</body>
</html>