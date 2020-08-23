<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div style="width:700px;margin-left:25%">  
                        <asp:Panel ID="Panel2" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image2" runat="server" 
                                ImageUrl="~/Images/Admin1.jpg" Height="495px" 
                                Width="588px" />
                        </asp:Panel>  
                        <asp:Panel ID="Panel3" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image3" runat="server" 
                                ImageUrl="~/Images/Admin2.jpg" Height="495px" 
                                Width="588px" />
                        </asp:Panel>  
                        <asp:Panel ID="Panel4" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image4" runat="server" 
                                ImageUrl="~/Images/Admin3.jpg" Height="495px" 
                                Width="588px" />
                        </asp:Panel>  
                        <asp:Panel ID="Panel5" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image5" runat="server" 
                                ImageUrl="~/Images/Admin4.jpg" Height="495px" 
                                Width="588px" />
                        </asp:Panel>  
                        <asp:Panel ID="Panel6" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image6" runat="server" 
                                ImageUrl="~/Images/Admin5.jpg" Height="495px" 
                                Width="588px" />
                        </asp:Panel>  
                    </div>  
                

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
</asp:Content>

