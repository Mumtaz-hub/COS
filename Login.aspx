<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            var $divSlide = $("div.slide");
            $divSlide.hide().eq(0).show();
            var panelCnt = $divSlide.length;

            //Set Slide Show Interval  
            setInterval(panelSlider, 4000);

            function panelSlider() {
                $divSlide.eq(($divSlide.length++) % panelCnt)
                .slideUp("slow", function () {
                    $divSlide.eq(($divSlide.length) % panelCnt)
                        .slideDown("slow");
                });
            }
        });  
    </script>  
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:100%;border:1px solid white;height:100px;">
        <asp:Image ID="ImgLogo" runat="server" ImageUrl="~/logo_larsen_toubro.jpg" />
    </div>
    <div style="background-color:White;position:absolute; top: 77px; left: 10px; height: 1221px;">
        
        <div  style="float:left;height:520px;width:494px;margin-top:1%;">
        <table style="height: 500px; width: 500px;">  
            <tr>  
                <td style="background-color: White;">  
                    <div>  
                        <asp:Panel ID="Panel2" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image2" runat="server" 
                                ImageUrl="~/Images/lt-knowledge-city-gujarat1.jpg" Height="486px" 
                                Width="588px" />
                                    
                        </asp:Panel>  
                        <asp:Panel ID="Panel3" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image3" runat="server" 
                                ImageUrl="~/Images/lt-knowledge-city-gujarat2.jpg" Height="489px" 
                                Width="586px" />
                        </asp:Panel>  
                        <asp:Panel ID="Panel4" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image4" runat="server" 
                                ImageUrl="~/Images/lt-knowledge-city-gujarat3.jpg" Height="490px" 
                                Width="583px" />
                        </asp:Panel>  
                        <asp:Panel ID="Panel5" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image5" runat="server" 
                                ImageUrl="~/Images/lt-knowledge-city-gujarat4.jpg" Height="493px" 
                                Width="583px" />
                        </asp:Panel>  
                        <asp:Panel ID="Panel6" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image6" runat="server" 
                                ImageUrl="~/Images/lt-knowledge-city-gujarat.jpg" Height="491px" 
                                Width="584px" />
                        </asp:Panel>  
                    </div>  
                </td>  
            </tr>  
        </table>  
        </div>
        
        <div style="float:right;height:651px; width:600px; margin-left: 0px;">
        <asp:Panel ID="Panel1" runat="server" Height="300px" 
            
                style="text-align: center; font-weight: 700; border:1px solid blue; background-color:Window; margin-left:400px; margin-top:10px;" Width="400px" 
            ForeColor="#000099"  >
            
            <asp:Label ID="lblHeading" runat="server" 
                style="font-size: x-large; text-decoration: underline" Text="LOGIN"></asp:Label>
            <br />
            <br />
            <br />
            
            <table align="center" class="style2" style="background-color:Window;">

                <tr>
                    <td class="style3">
                        &nbsp;</td>
                    <td class="style4">
                        <asp:ValidationSummary ID="VSLogin" runat="server" ForeColor="Red" 
                            ValidationGroup="VG" />
                        </td>
                </tr>

                <tr>
                    <td class="style3">
                        <asp:Label ID="lblUserName" runat="server" Text="User Name:" 
                            ForeColor="#000099"></asp:Label>
                    </td>
                    <td class="style4">
                        
                        <asp:TextBox ID="txtUserName" runat="server" ValidationGroup="VG" Width="180px" 
                            BorderColor="#000099" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqfUserName" runat="server" 
                            ControlToValidate="txtUserName" ErrorMessage="Required User Name" 
                            ForeColor="Red" ValidationGroup="VG">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        &nbsp;</td>
                    <td class="style4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td class="style3">
                        <asp:Label ID="lblPassword" runat="server" Text="Password" ForeColor="#000099"></asp:Label>
                    </td>
                    <td class="style4">
                        <asp:TextBox ID="txtPassword" runat="server" MaxLength="10" 
                            TextMode="Password" ValidationGroup="VG" Width="180px" 
                            BorderColor="#000099" BorderStyle="Solid" BorderWidth="1px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rqfPassword" runat="server" 
                            ControlToValidate="txtPassword" ErrorMessage="Required Password" 
                            ForeColor="Red" ValidationGroup="VG">*</asp:RequiredFieldValidator>
                        
                    </td>
                </tr>
                <tr>
                    <td class="style3">
                        &nbsp;</td>
                    <td class="style4">
                        &nbsp;</td>
                </tr>
                <tr>

                    <td>
                        &nbsp;</td>

                    <td>
                        <asp:Button ID="btnLogIn" runat="server" Height="36px" style="font-weight: 700" 
                            Text="Log In" ValidationGroup="VG" BackColor="#0099CC" 
                            BorderColor="#000066" BorderStyle="Solid" BorderWidth="1px" ForeColor="#FFFF66" 
                            Width="80px" Font-Bold="True" onclick="btnLogIn_Click" />&nbsp
                        <asp:Button ID="btnSignup" runat="server" BackColor="#0099CC" 
                            BorderColor="#000066" BorderStyle="Solid" BorderWidth="1px" ForeColor="#FFFF66" 
                            Height="36px" style="font-weight: 700" Text="Register" Width="80px" 
                            Font-Bold="True" onclick="btnSignup_Click" />
                    </td>
                            
                </tr>
                <tr>
                    <td class="style3">
                        &nbsp;</td>
                    <td>
                        <asp:Label ID="lblMessage" runat="server" style="font-size: small"></asp:Label>
                    </td>
                </tr>
            </table>
            
        </asp:Panel>
        </div>
    </div>
    
    </form>
</body>
</html>
