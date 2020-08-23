<%@ Page Title="" Language="C#" MasterPageFile="~/master_User.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

                    <div style="width:700px;margin-left:25%">  
                        <asp:Panel ID="Panel2" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image2" runat="server" 
                                ImageUrl="~/Images/default1.jpg" Height="486px" 
                                Width="588px" />
                                    
                        </asp:Panel>  
                        <asp:Panel ID="Panel3" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image3" runat="server" 
                                ImageUrl="~/Images/default2.jpg" Height="489px" 
                                Width="586px" />
                        </asp:Panel>  
                        <asp:Panel ID="Panel4" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image4" runat="server" 
                                ImageUrl="~/Images/default3.jpg" Height="490px" 
                                Width="583px" />
                        </asp:Panel>  
                        <asp:Panel ID="Panel5" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image5" runat="server" 
                                ImageUrl="~/Images/default4.jpg" Height="493px" 
                                Width="583px" />
                        </asp:Panel>  
                        <asp:Panel ID="Panel6" runat="server" class='slide' BackColor="White" Height="500px">  
                            <asp:Image ID="Image6" runat="server" 
                                ImageUrl="~/Images/default5.jpg" Height="491px" 
                                Width="584px" />
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

