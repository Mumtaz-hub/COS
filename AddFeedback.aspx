<%@ Page Title="" Language="C#" MasterPageFile="~/master_User.master" AutoEventWireup="true" CodeFile="AddFeedback.aspx.cs" Inherits="AddFeedback" %>

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
<asp:GridView ID="gvFeedbackStatus" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="Feedback Code" ItemStyle-Width="110px" ItemStyle-CssClass="Feedback_Code">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Feedback_Code") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Feedback Desc" ItemStyle-Width="110px" ItemStyle-CssClass="Feedback_Desc">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Feedback_Desc") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Feedback Status" ItemStyle-Width="150px" ItemStyle-CssClass="Feedback_Status">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Feedback_Status") %>' runat="server" />
                    <asp:TextBox Text='<%# Eval("Feedback_Status") %>' runat="server" Style="display: none" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton Text="Edit" runat="server" CssClass="Edit" />
                    <asp:LinkButton Text="Update" runat="server" CssClass="Update" Style="display: none" />
                    <asp:LinkButton Text="Cancel" runat="server" CssClass="Cancel" Style="display: none" />
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
                url: "AddFeedback.aspx/GetFeedback",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess
            });
        });

        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var Categories = xml.find("Table");
            var row = $("[id*=gvFeedbackStatus] tr:last-child").clone(true);
            $("[id*=gvFeedbackStatus] tr").not($("[id*=gvFeedbackStatus] tr:first-child")).remove();
            $.each(Categories, function () {
                var Category = $(this);
                AppendRow(row, $(this).find("Feedback_Code").text(), $(this).find("Feedback_Desc").text(), $(this).find("Feedback_Status").text())
                row = $("[id*=gvFeedbackStatus] tr:last-child").clone(true);
            });
        }

        function AppendRow(row, Code, Desc,Status) {

            $(".Feedback_Code", row).find("span").html(Code);
            $(".Feedback_Desc", row).find("span").html(Desc);

            $(".Feedback_Status", row).find("span").html(Status);
            $(".Feedback_Status", row).find("input").val(Status);

            $("[id*=gvFeedbackStatus]").append(row);
        }

        //Edit event handler.
        $("body").on("click", "[id*=gvFeedbackStatus] .Edit", function () {
            var row = $(this).closest("tr");
            $("td", row).each(function () {
                if ($(this).find("input").length > 0) {
                    $(this).find("input").show();
                    $(this).find("span").hide();
                }
            });
            row.find(".Update").show();
            row.find(".Cancel").show();
            $(this).hide();
            return false;
        });

        //Update event handler.
        $("body").on("click", "[id*=gvFeedbackStatus] .Update", function () {
            var row = $(this).closest("tr");
            $("td", row).each(function () {
                if ($(this).find("input").length > 0) {
                    var span = $(this).find("span");
                    var input = $(this).find("input");
                    span.html(input.val());
                    span.show();
                    input.hide();
                }
            });
            row.find(".Edit").show();
            row.find(".Delete").show();
            row.find(".Cancel").hide();
            $(this).hide();

            var Code = row.find(".Feedback_Code").find("span").html();
            var Status = row.find(".Feedback_Status").find("span").html();

            $.ajax({
                type: "POST",
                url: "AddFeedback.aspx/UpdateFeedback",
                data: '{Code: ' + Code + ',Status: "' + Status + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            });

            return false;
        });

        //Cancel event handler.
        $("body").on("click", "[id*=gvFeedbackStatus] .Cancel", function () {
            var row = $(this).closest("tr");
            $("td", row).each(function () {
                if ($(this).find("input").length > 0) {
                    var span = $(this).find("span");
                    var input = $(this).find("input");
                    input.val(span.html());
                    span.show();
                    input.hide();
                }
            });
            row.find(".Edit").show();
            row.find(".Delete").show();
            row.find(".Update").hide();
            $(this).hide();
            return false;
        });

    </script>
</asp:Content>

