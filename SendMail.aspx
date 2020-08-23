<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SendMail.aspx.cs" Inherits="SendMail" %>

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
        </style>

        <script type="text/javascript">
            function CloseWindow() {
                window.close();
            }
        </script>
</head>
<body>
    <form id="form1" runat="server">
    <div runat="server" id="Main" 
        style="Height:350px; width:370px ; border:1px solid blue;background-color:White;">
        <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
        <tr>
        <td style="width: 80px">
            To:
        </td>
        <td>
            <asp:TextBox ID="txtTo" runat="server" Width="195px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
            Subject:
        </td>
        <td>
            <asp:TextBox ID="txtSubject" runat="server" Width="195px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td valign = "top">
            Body:
        </td>
        <td>
            <asp:TextBox ID="txtBody" runat="server" TextMode = "MultiLine" 
                Height = "150px" Width = "288px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
             Email Id:
        </td>
        <td>
            <asp:TextBox ID="txtEmail" runat="server" Width="195px"></asp:TextBox>
        </td>
    </tr>
    
    <tr>
        <td>
            Email Password:
        </td>
        <td>
            <asp:TextBox ID="txtPassword" runat="server" TextMode = "Password" Width="195px"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td>
        </td>
        <td>
            <asp:Button ID="btnSendMail" Text="Send" OnClick="SendEmail" runat="server" />
        </td>
    </tr>
    </table>

    </div>
    </form>
</body>

</html>
