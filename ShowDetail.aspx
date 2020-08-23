<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShowDetail.aspx.cs" Inherits="ShowDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        table
        {
            border: 1px solid #ccc;
            width: 200px;
            margin-bottom: -1px;
        }
        table th
        {
            background-color: #F7F7F7;
            color: #333;
            font-weight: bold;
        }
        table th, table td
        {
            padding: 5px;
            border: 1px solid #ccc;
            width:50px;
        }
        
        .tblStyle
        {
            height: 300px;
            width: 80%;
        }
        
        .td1Style
        {
            text-align: left;
            width: 150px;
        }
        
        .td2Style
        {
            text-align: left;
            width: 150px;
        }
        .td3Style
        {
            text-align: left;
            width: 150px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <div runat="server" id="Main" style="Height:400px; width:100% ;border:0px solid white;background-color:White;">
        <table align="center" class="tblStyle" border="1" >
                        <tr>
                            <td class="td1Style" colspan="2">
                                <b>form No:I&amp;s/Canteen/18-19/005/PR</b><br />
                                TO<br />
                                INFRASTRUCTURE &amp; SERVICES DEPARTMENT<br />
                                L&amp;T KNOWLEDGE CITY,VADODARA</td>
                            
                            <td class="td3Style">
                                <asp:Label id="lblDateofRequisition" runat="server" style="font-weight: 700" 
                                    Text="Date Of Requistion:"></asp:Label>
                                <asp:TextBox ID="txtDateOfRequistion" runat="server" Enabled="False" ></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td class="td1Style">
                                <asp:Label ID="lblSub" runat="server" Text="Order For:"></asp:Label>
                                
                                <asp:DropDownList ID="ddlSub" runat="server" Height="16px" Width="150px" Enabled="False">
                                    <asp:ListItem>LUNCH/SNACKS/TEA</asp:ListItem>
                                    <asp:ListItem>LUNCH</asp:ListItem>
                                    <asp:ListItem>SNACKS</asp:ListItem>
                                    <asp:ListItem>TEA</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="td2Style">
                                <asp:Label ID="lblFor" runat="server" Text="FOR"></asp:Label>
                                <asp:TextBox ID="txtFor" runat="server" Enabled="False"></asp:TextBox>
                                <asp:Label ID="Label1" runat="server" Text="NUMBER/NAME OF PERSON"></asp:Label>
                            </td>
                            <td  class="td3Style">
                                <asp:Label ID="lblDateOfEvent" runat="server" style="font-weight: 700" 
                                    Text="Date Of Event:"></asp:Label>
                                <asp:TextBox ID="txtDateOfEvent" runat="server" Enabled="False"></asp:TextBox>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1Style" colspan="3">
                                <asp:Label ID="Label2" runat="server" 
                                    Text=" KINDLY ARRANGE FOR LUNCH/TEA/SNACKS AS PER FOLLOWING DETAILS"></asp:Label>
                            </td>
                            
                        </tr>

                        <tr>
                            <td class="td1Style">
                                Purpose Of Meeting:
                                <asp:TextBox ID="txtPurposeMeeting" runat="server" Enabled="False"></asp:TextBox>
                            </td>
                            <td class="td2Style">
                                &nbsp;
                            </td>
                            <td  class="td3Style">
                                Venue:
                                <asp:TextBox ID="txtVenue" runat="server" Enabled="False"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td class="td1Style">
                                <asp:Label ID="lblDebitCode" runat="server" Text="Debit Code:-"></asp:Label>
                                <asp:TextBox ID="txtDebitCode" runat="server" Enabled="False"></asp:TextBox>
                            </td>
                            <td class="td2Style">
                                &nbsp;
                            </td>
                            <td class="td3Style">
                                <strong>Timing:</strong>
                                Morning:
                                <asp:RadioButton ID="RdMtea" GroupName="Time" runat="server" Enabled="False" Text="Tea/Snacks" TextAlign="Left" />
                                <br />
                                <strong>Timing:</strong>
                                Evening:
                                <asp:RadioButton ID="RdEtea" GroupName="Time" runat="server"  Enabled="False" Text="Tea/Snacks" TextAlign="Left" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1Style">
                                <asp:Label ID="lblDepartment" runat="server" Text="Department:"></asp:Label>
                                <asp:DropDownList ID="ddlDepartment" runat="server" Enabled="False" Height="16px" Width="134px">
                                </asp:DropDownList>
                            </td>
                            <td class="td2Style">
                                &nbsp;
                            </td>
                            <td class="td3Style">
                                &nbsp;</td>
                        </tr>
                                          
                    </table>

            <div runat="server" id="PreparedBy" style="Height:200px;width:100%; background-color:White;">
                <table align="center"  border="1" >
                <tr>
                    <td class="td1Style">
                                <asp:Label ID="Label3" runat="server" Text="Prepared By:"></asp:Label>
                                <asp:TextBox ID="txtPreparedBy" runat="server" Enabled="False" ></asp:TextBox>
                     </td>
                
                    <td class="td1Style">
                                <asp:Label ID="Label4" runat="server" Text="EXTN NO:"></asp:Label>
                                <asp:TextBox ID="txtExtno" runat="server" Enabled="False"></asp:TextBox>
                     </td>
                
                    <td class="td1Style">
                                <asp:Label ID="Label5" runat="server" Text="CELL NO:"></asp:Label>
                                <asp:TextBox ID="txtCellno" runat="server" Enabled="False"></asp:TextBox>
                     </td>
                </tr>
                </table>
            </div>
    </div>
    <div runat="server" id="Body" style=" Height:500px;width:100%;border:0px solid black;position:absolute;background-color:white;">
        <div  runat="server" id="Lunch" style="Height:300px;width:70%;float:left;background-color:White;">
            
            
        </div>

        <div runat="server" id="Snacks" style="Height:300px;width:28% ;float:left;background-color:White;">
        
        </div>

    </div>
    
    </form>

</body>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            
            $.ajax({
                type: "POST",
                url: "ShowDetail.aspx/GetItemLunchDetails",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#Lunch").html(response.d);
                   }
            });

            $.ajax({
                type: "POST",
                url: "ShowDetail.aspx/GetItemSnacksDetails",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#Snacks").html(response.d);
                   
                }
            });

        });
    </script>
</html>
