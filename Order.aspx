<%@ Page Title="" Language="C#" MasterPageFile="~/master_User.master" AutoEventWireup="true" CodeFile="Order.aspx.cs" Inherits="Order" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        table
        {
            border: 1px solid #ccc;
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
    .style1
    {
        width: 100px;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div runat="server" id="Main" style="Height:320px; width:100% ;border:0px solid white;background-color:White;">
        
        <table align="center" class="tblStyle" border="1" >
                        <tr>
                            <td class="td1Style" colspan="2">
                                <b>form No:I&amp;s/Canteen/18-19/005/PR</b><br />
                                TO<br />
                                INFRASTRUCTURE &amp; SERVICES DEPARTMENT<br />
                                L&amp;T KNOWLEDGE CITY,VADODARA<asp:TextBox ID="txtTransID" runat="server" Width="100px" ></asp:TextBox>
                            </td>
                            
                            <td class="td3Style">
                                <asp:Label id="lblDateofRequisition" runat="server" style="font-weight: 700" 
                                    Text="Date Of Requistion:"></asp:Label>
                                <asp:TextBox ID="txtDateOfRequistion" runat="server" Width="100px" ></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td class="td1Style">
                                <asp:Label ID="lblSub" runat="server" Text="Order For:"></asp:Label>
                                
                                <asp:DropDownList ID="ddlSub" runat="server" Height="16px" Width="170px">
                                    <asp:ListItem>LUNCH/SNACKS/TEA</asp:ListItem>
                                    <asp:ListItem>LUNCH</asp:ListItem>
                                    <asp:ListItem>SNACKS</asp:ListItem>
                                    <asp:ListItem>TEA</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td class="td2Style">
                                <asp:Label ID="lblFor" runat="server" Text="FOR"></asp:Label>
                                <asp:TextBox ID="txtFor" runat="server" Width="30px"></asp:TextBox>
                                <asp:Label ID="Label1" runat="server" Text="NUMBER/NAME OF PERSON"></asp:Label>
                            </td>
                            <td  class="td3Style">
                                <asp:Label ID="lblDateOfEvent" runat="server" style="font-weight: 700" 
                                    Text="Date Of Event:"></asp:Label>
                                 
                                        <asp:TextBox ID="txtDateOfEvent" runat="server" Width="100px"></asp:TextBox>
                                        <asp:ImageButton ID="imgPopup" ImageUrl="images/calendar.png" ImageAlign="Bottom"
                                            runat="server" onclick="imgPopup_Click" />
                                        <asp:Calendar ID="CalendarDE" runat="server" Height="122px" 
                                    onselectionchanged="CalendarDE_SelectionChanged" Visible="false" ></asp:Calendar>
        
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
                                <asp:TextBox ID="txtPurposeMeeting" runat="server" Width="200px"></asp:TextBox>
                            </td>
                            <td class="td2Style">
                                &nbsp;
                            </td>
                            <td  class="td3Style">
                                Venue:
                                <asp:TextBox ID="txtVenue" runat="server" Width="100px"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td class="td1Style">
                                <asp:Label ID="lblDebitCode" runat="server" Text="Debit Code:-"></asp:Label>
                                <asp:TextBox ID="txtDebitCode" runat="server" Width="100px"></asp:TextBox>
                            </td>
                            <td class="td2Style">
                                &nbsp;
                            </td>
                            <td class="td3Style">
                                <strong>Timing:</strong>
                                Morning:
                                <asp:RadioButton ID="RdMtea" GroupName="Time" runat="server" Text="Tea/Snacks" TextAlign="Left" />
                                <br />
                                <strong>Timing:</strong>
                                Evening:
                                <asp:RadioButton ID="RdEtea" GroupName="Time" runat="server" Text="Tea/Snacks" TextAlign="Left" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="td1Style">
                                <asp:Label ID="lblDepartment" runat="server" Text="Department:"></asp:Label>
                                <asp:DropDownList ID="ddlDepartment" runat="server" Height="16px" Width="134px">
                                </asp:DropDownList>
                            </td>
                            <td class="td2Style">
                                &nbsp;
                            </td>
                            <td class="td3Style">
                                &nbsp;</td>
                        </tr>
                                          
                    </table>

            
    </div>
    
    <div runat="server" id="Body" style=" Height:500px;width:100%;border:0px solid black;position:absolute;background-color:white;left:5%">
        <div  runat="server" id="Lunch" style="Height:100px;width:55%; float:left;background-color:White;">
        
        </div>
        
        <div runat="server" id="Snacks" style="Height:300px;width:28% ;float:left;background-color:White;">
        
        </div>

        <div runat="server" id="PreparedBy" style="Height:200px;width:50%; background-color:White;">
                <table align="center"  border="1" >
                <tr>
                    <td class="td1Style">
                                <asp:Label ID="Label3" runat="server" Text="Prepared By:"></asp:Label>
                                <asp:TextBox ID="txtPreparedBy" runat="server" Width="100px"></asp:TextBox>
                     </td>
                
                    <td class="td1Style">
                                <asp:Label ID="Label4" runat="server" Text="EXTN NO:"></asp:Label>
                                <asp:TextBox ID="txtExtno" runat="server" Width="100px"></asp:TextBox>
                     </td>
                
                    <td class="td1Style">
                                <asp:Label ID="Label5" runat="server" Text="CELL NO:"></asp:Label>
                                <asp:TextBox ID="txtCellno" runat="server" Width="100px"></asp:TextBox>
                     </td>
                </tr>
                <tr>
                    <td  colspan="3" >
                        <asp:Button ID="btnSave" runat="server" Text=" Create & Save" style="Height:30px;width:100% ; font-weight:bold;" />    
                    </td>
                </tr>
                </table>
            </div>
        
    </div>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {

            $.ajax({
                type: "POST",
                url: "Order.aspx/GetItemLunchDetails",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#ContentPlaceHolder1_Lunch").html(response.d);
                }
            });

            $.ajax({
                type: "POST",
                url: "Order.aspx/GetItemSnacksDetails",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $("#ContentPlaceHolder1_Snacks").html(response.d);

                }
            });

        });


        $('#ContentPlaceHolder1_btnSave').click(function () {

            var TeaTime;
            TeaTime = 'Morning';

            var Lunchvalues = "";
            $("input[name=LunchTextBox]").each(function () {
                Lunchvalues += $(this).val() + ",";
            });

            var Teavalues = "";
            $("input[name=TeaSnacksTextBox]").each(function () {
                Teavalues += $(this).val() + ",";
            });

            //alert(values);

            $.ajax({
                type: 'POST',
                contentType: "application/json; charset=utf-8",
                url: 'Order.aspx/InsertMethod',

                //string Date_Request,                                                                          string Order_For,                                                   string No_Of_Person,                                                    string Date_Event,                                              string Purpose_Of_Meeting,                                                          string DEBIT_Code,                                          string VENUE,                                           string Time_For_Teasnacks,                          string Dept_Code,                                                                       string Prepared_By
                data: "{'Date_Request':'" + document.getElementById('ContentPlaceHolder1_txtDateOfRequistion').value + "', 'Order_For':'" + document.getElementById('ContentPlaceHolder1_ddlSub').value + "', 'No_Of_Person':'" + document.getElementById('ContentPlaceHolder1_txtFor').value + "','Date_Event':'" + document.getElementById('ContentPlaceHolder1_txtDateOfEvent').value + "','Purpose_Of_Meeting':'" + document.getElementById('ContentPlaceHolder1_txtPurposeMeeting').value + "','DEBIT_Code':'" + document.getElementById('ContentPlaceHolder1_txtDebitCode').value + "','VENUE':'" + document.getElementById('ContentPlaceHolder1_txtVenue').value + "','Time_For_Teasnacks':'" + TeaTime + "','Dept_Code':'" + document.getElementById('ContentPlaceHolder1_ddlDepartment').value + "','Prepared_By':'" + document.getElementById('ContentPlaceHolder1_txtPreparedBy').value + "','LunchValues':'" + Lunchvalues + "','TeaSnacksValues':'" + Teavalues + "'}",
                async: false,
                success: function (response) {
                },
                error: function () {
                    console.log('there is some error');
                }
            });

            var Code = document.getElementById('ContentPlaceHolder1_txtTransID').value;
            window.open("SendMail.aspx?Text=" + Code, "_blank", "WIDTH=980,HEIGHT=590,scrollbars=no, menubar=no,resizable=yes,directories=no,location=no");
            alert("Order Request Created successfully");
            

        });
       

    </script>
</asp:Content>

