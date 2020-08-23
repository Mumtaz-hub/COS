<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="Signup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SingUp</title>
     <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />  
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>  
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js"></script>  
        <script type="text/javascript">
            $(document).ready(function () {
                $('#btnCreate').click(function () {
                    var uname = document.getElementById('txtUserName').value;
                    var pwd = document.getElementById('txtPassword').value;
                    var Email = document.getElementById('txtEmailId').value;
                    var ExtnNo = document.getElementById('txtEXTN_No').value;
                    var CellNo = document.getElementById('txtCellNo').value;
                    var DeptNo = document.getElementById('ddlDepartment').value;
                    var UType = document.getElementById('ddlUserType').value;

                    if ((uname != "") && (pwd != "") && (Email != "") && (ExtnNo != "") && (CellNo != "") && (DeptNo != "") && (UType != "")) {
                        $.ajax({
                            type: 'POST',
                            contentType: "application/json; charset=utf-8",
                            url: 'Signup.aspx/InsertMethod',
                            data: "{'UserName':'" + uname + "', 'Password':'" + pwd + "', 'EmailID':'" + Email + "','EXTN_No':'" + ExtnNo + "','CellNo':'" + CellNo + "','Dept_Code':'" + DeptNo + "','User_Type':'" + UType + "'}",
                            async: false,
                            success: function (response) {
                                if (response.d == 'True') {
                                    alert("Account Create successfully");
                                    event.preventDefault();
                                    window.location.href = "../COS/Login.aspx";
                                }
                            },
                            error: function () {
                                console.log('there is some error');
                            }
                        });
                    }
                });
            }); 
            </script>
            <style type="text/css">
         .style2
         {
             text-align: left;
             margin-left:10%;
         }
        .style3
        {
            height: 23px;
            padding:5px;
            width:300px;
            margin-left:2%;
        }
        .style4
        {
            text-align: left;
            height: 23px;
            padding:5px;
            width:300px;
            margin-left:2%;
        }
     </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin-left:5%">
    <asp:Panel ID="Panel1" runat="server" Width="600px" Height="600px" style="text-align: center;border:1px solid blue; background-color:Window; margin-left:300px; margin-top:0px;">
            <br />
            
            <asp:Image ID="ImgLogo" runat="server" ImageUrl="~/logo_larsen_toubro.jpg" /><br /><br />
            <asp:Label ID="lblHeading" runat="server" Text="Registration" 
                style="font-weight: 700; font-size: x-large; text-decoration: underline" 
                ForeColor="#000099"></asp:Label>
            <br />
            <br />
            <br />
            <table align="center" class="style2" style="background-color:Window;">
                <tr>
                <td></td>
                <td>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" 
                        ValidationGroup="VG" />
                </td>
                </tr>
                <tr>
                    <td class="style3">
                        <asp:Label ID="lblUserName" runat="server" style="font-weight: 700" 
                            Text="User Name:" ForeColor="#000099"></asp:Label>
                    </td>
                    <td class="style2">
                        &nbsp;<asp:TextBox ID="txtUserName" runat="server" Width="170px" 
                            BorderColor="#000099" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                        &nbsp;&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="refUserName" runat="server" 
                            ControlToValidate="txtUserName" ErrorMessage="Required User Name" 
                            ForeColor="Red" ValidationGroup="VG">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                
                <tr>
                    <td class="style3">
                        <asp:Label ID="lblPassword" runat="server" style="font-weight: 700" 
                            Text="Password:" ForeColor="#000099"></asp:Label>
                    </td>
                    <td class="style2">
                        <asp:TextBox ID="txtPassword" runat="server" MaxLength="10" TextMode="Password" 
                            Width="170px" BorderColor="#000099" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                        &nbsp;&nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="refPassword" runat="server" 
                            ControlToValidate="txtPassword" ErrorMessage="must required Password" 
                            ForeColor="Red" ValidationGroup="VG">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                
                <tr>
                    <td class="style3">
                        <asp:Label ID="lblConfrmPasswrd" runat="server" style="font-weight: 700" 
                            Text="Confirm Password:" ForeColor="#000099"></asp:Label>
                    </td>
                    <td class="style2">
                        &nbsp;<asp:TextBox ID="txtConfrmPasswrd" runat="server" MaxLength="10" 
                            TextMode="Password" Width="170px" BorderColor="#000099" 
                            BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                        &nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="refConfrmPasswrd" runat="server" 
                            ControlToValidate="txtConfrmPasswrd" 
                            ErrorMessage="must required confirm password" ForeColor="Red" 
                            ValidationGroup="VG">*</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CVConfrmPasswrd" runat="server" 
                            ControlToCompare="txtPassword" ControlToValidate="txtConfrmPasswrd" 
                            ErrorMessage="not match with password" ForeColor="Red" 
                            ValidationGroup="VG">*</asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        <asp:Label ID="lblEmailId" runat="server" style="font-weight: 700" 
                            Text="Email ID:" ForeColor="#000099"></asp:Label>
                    </td>
                    <td class="style2">
                        &nbsp;<asp:TextBox ID="txtEmailId" runat="server" Width="170px" 
                            BorderColor="#000099" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                        &nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="refEmailId" runat="server" 
                            ControlToValidate="txtEmailId" ErrorMessage="must required email id" 
                            ForeColor="Red" ValidationGroup="VG">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="reglrExpVEmailId" runat="server" 
                            ControlToValidate="txtEmailId" ErrorMessage="must write email in proper format" 
                            ForeColor="Red" 
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                            ValidationGroup="VG">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        <asp:Label ID="lblEXTN_No" runat="server" style="font-weight: 700" 
                            Text="EXTN_No:" ForeColor="#000099"></asp:Label>
                    </td>
                    <td class="style2">
                        &nbsp;<asp:TextBox ID="txtEXTN_No" runat="server" Width="170px" 
                            BorderColor="#000099" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                        &nbsp;&nbsp;
                        <asp:RequiredFieldValidator ID="refVEXTN_No" runat="server" 
                            ControlToValidate="txtEXTN_No" ErrorMessage=" must required EXTN No" 
                            ForeColor="Red" ValidationGroup="VG">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        <asp:Label ID="lblCellNo" runat="server" style="font-weight: 700" 
                            Text="Cell No." ForeColor="#000099"></asp:Label>
                    </td>
                    <td class="style4">
                        &nbsp;<asp:TextBox ID="txtCellNo" runat="server" Width="170px" 
                            BorderColor="#000099" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                        &nbsp;&nbsp;<asp:RequiredFieldValidator ID="refVCellNo" runat="server" 
                            ControlToValidate="txtCellNo" ErrorMessage="must requied cell no" 
                            ForeColor="Red" ValidationGroup="VG">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                
                <tr>
                    <td class="style3">
                        <asp:Label ID="lblDepartment" runat="server" style="font-weight: 700" 
                            Text="Department:" ForeColor="#000099"></asp:Label>
                    </td>
                    <td class="style2">
                        <asp:DropDownList ID="ddlDepartment" runat="server" Height="25px" Width="169px" 
                            CssClass="style3">
                            <asp:ListItem>V</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;<asp:RequiredFieldValidator ID="refVDepartment" runat="server" 
                            ControlToValidate="ddlDepartment" ErrorMessage="you must select any one" 
                            ForeColor="Red" ValidationGroup="VG">*</asp:RequiredFieldValidator>
                        &nbsp;
                    </td>
                </tr>
                
                <tr>
                    <td class="style3">
                        <asp:Label ID="lblDepartment0" runat="server" style="font-weight: 700" 
                            Text="User_Type:-" ForeColor="#000099"></asp:Label>
                    </td>
                    <td class="style4">
                        <asp:DropDownList ID="ddlUserType" runat="server" Height="25px" Width="169px" 
                            CssClass="style3">
                            <asp:ListItem Value="ADMIN">ADMIN</asp:ListItem>
                            <asp:ListItem>HOD</asp:ListItem>
                            <asp:ListItem>USER</asp:ListItem>
                            <asp:ListItem>I&amp;SDEPT</asp:ListItem>
                        </asp:DropDownList>
                        &nbsp;&nbsp;<asp:RequiredFieldValidator ID="refVUserType" runat="server" 
                            ControlToValidate="ddlUserType" ErrorMessage="you must select any one" 
                            ForeColor="Red" ValidationGroup="VG">*</asp:RequiredFieldValidator>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
                
                <tr>
                    <td class="style4" colspan="2">
                        <asp:Button ID="btnCreate" runat="server" Height="41px" 
                            style="font-weight: 700" Text="Create" Width="90px" ValidationGroup="VG" 
                            BackColor="#0099CC" BorderColor="#000066" BorderStyle="Solid" BorderWidth="1px" 
                            Font-Bold="True" ForeColor="#FFFF66" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnLogin" runat="server" Height="41px" onclick="btnLogin_Click" 
                            style="font-weight: 700" Text="Log in" Width="90px" BackColor="#0099CC" 
                            BorderColor="#000066" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" 
                            ForeColor="#FFFF66" />
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        <asp:Label ID="lblMessage" runat="server" ForeColor="#9966FF" 
                            style="font-weight: 700" Text="create successfully" Visible="False"></asp:Label>
                    </td>
                    <td class="style4">
                        &nbsp;</td>
                </tr>
                
            </table>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
