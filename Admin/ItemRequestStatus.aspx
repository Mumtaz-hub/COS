<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="ItemRequestStatus.aspx.cs" Inherits="Admin_ItemRequestStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<style type="text/css">
        body
        {
            font-family: Arial;
            font-size: 10pt;
        }
        table
        {
            border: 1px solid #ccc;
            width: 550px;
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
        }
        
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<div style="margin-left:20%;">

    <asp:GridView ID="gvItemRequest" runat="server" AutoGenerateColumns="false" AllowPaging="true">
        <Columns>
            <asp:TemplateField HeaderText="ID" ItemStyle-Width="150px" ItemStyle-CssClass="Trans_Id">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Trans_Id") %>' runat="server"  />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Date Of Request" ItemStyle-Width="150px" ItemStyle-CssClass="Date_Request">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Date_Request") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="No Of Person" ItemStyle-Width="150px" ItemStyle-CssClass="No_Of_Person">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("No_Of_Person") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date Of Event" ItemStyle-Width="150px" ItemStyle-CssClass="Date_Event">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Date_Event") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Purpose Of Meeting" ItemStyle-Width="150px" ItemStyle-CssClass="Purpose_Of_Meeting">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Purpose_Of_Meeting") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="DEBIT CODE" ItemStyle-Width="150px" ItemStyle-CssClass="DEBIT_Code">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("DEBIT_Code") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Venue" ItemStyle-Width="150px" ItemStyle-CssClass="VENUE">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("VENUE") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Time For Tea/Snacks" ItemStyle-Width="150px" ItemStyle-CssClass="Time_For_Teasnacks">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Time_For_Teasnacks") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Department Name" ItemStyle-Width="150px" ItemStyle-CssClass="Dept_Name">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Dept_Name") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Prepared By" ItemStyle-Width="150px" ItemStyle-CssClass="Prepared_By">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Prepared_By") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status" ItemStyle-Width="150px" ItemStyle-CssClass="Status">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Status") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status HOD" ItemStyle-Width="150px" ItemStyle-CssClass="Status_HOD">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Status_HOD") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Status I&S Dept." ItemStyle-Width="150px" ItemStyle-CssClass="Status_ISDept">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Status_ISDept") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton Text="ShowDetails" runat="server" CssClass="ShowDetails" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton Text="ShowFeedback" runat="server" CssClass="ShowFeedback" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </div>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                type: "POST",
                url: "ItemRequestStatus.aspx/GetItemRequestStatus",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess
            });
        });

        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var Details = xml.find("Table");
            var row = $("[id*=gvItemRequest] tr:last-child").clone(true);
            $("[id*=gvItemRequest] tr").not($("[id*=gvItemRequest] tr:first-child")).remove();
            $.each(Details, function () {
                var Detail = $(this);
                AppendRow(row,
                $(this).find("Trans_Id").text(),
                $(this).find("Date_Request").text(),
                $(this).find("No_Of_Person").text(),
                $(this).find("Date_Event").text(),
                $(this).find("Purpose_Of_Meeting").text(),
                $(this).find("DEBIT_Code").text(),
                $(this).find("VENUE").text(),
                $(this).find("Time_For_Teasnacks").text(),
                $(this).find("Dept_Name").text(),
                $(this).find("Prepared_By").text(),
                $(this).find("Status").text(),
                $(this).find("Status_HOD").text(),
                $(this).find("Status_ISDept").text());
                row = $("[id*=gvItemRequest] tr:last-child").clone(true);
            });
        }

        function AppendRow(row,TransId,DateRequest, NoOfPerson, DateEvent, PurposeOfMeeing, DebitCode, Venue,
                            Time,DeptName,PreparedBy,Status,Staus_HOD,Status_ISDept) 
        {

            $(".Trans_Id", row).find("span").html(TransId);
            $(".Date_Request", row).find("span").html(DateRequest);
            $(".No_Of_Person", row).find("span").html(NoOfPerson);
            $(".Date_Event", row).find("span").html(DateEvent);
            $(".Purpose_Of_Meeting", row).find("span").html(PurposeOfMeeing);
            $(".DEBIT_Code", row).find("span").html(DebitCode);
            $(".VENUE", row).find("span").html(Venue);
            $(".Time_For_Teasnacks", row).find("span").html(Time);
            $(".Dept_Name", row).find("span").html(DeptName);
            $(".Prepared_By", row).find("span").html(PreparedBy);
            $(".Status", row).find("span").html(Status);
            $(".Status_HOD", row).find("span").html(Staus_HOD);
            $(".Status_ISDept", row).find("span").html(Status_ISDept);

            $("[id*=gvItemRequest]").append(row);
        }

        var popUpObj;
        $("body").on("click", "[id*=gvItemRequest] .ShowDetails", function () {

            var row = $(this).closest("tr");

            var TransId = $(".Trans_Id", row).find("span").html();

            popUpObj = window.open("../ShowDetail.aspx?Text=" + TransId, "_blank", "WIDTH=980,HEIGHT=590,scrollbars=no, menubar=no,resizable=yes,directories=no,location=no");

        });

        
        $("body").on("click", "[id*=gvItemRequest] .ShowFeedback", function () {

            var row = $(this).closest("tr");

            var TransId = $(".Trans_Id", row).find("span").html();

            window.open("../ShowFeedback.aspx?Text=" + TransId, "_blank", "WIDTH=980,HEIGHT=590,scrollbars=no, menubar=no,resizable=yes,directories=no,location=no");

        });
            
        </script>


</asp:Content>

