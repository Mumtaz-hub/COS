<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Feedback.aspx.cs" Inherits="Admin_Feedback" %>

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
<asp:GridView ID="gvFeedback" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="Feedback Code" ItemStyle-Width="110px" ItemStyle-CssClass="Feedback_Code">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Feedback_Code") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Feedback Description" ItemStyle-Width="150px" ItemStyle-CssClass="Feedback_Desc">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Feedback_Desc") %>' runat="server" />
                    <asp:TextBox Text='<%# Eval("Feedback_Desc") %>' runat="server" Style="display: none" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:LinkButton Text="Edit" runat="server" CssClass="Edit" />
                    <asp:LinkButton Text="Update" runat="server" CssClass="Update" Style="display: none" />
                    <asp:LinkButton Text="Cancel" runat="server" CssClass="Cancel" Style="display: none" />
                    <asp:LinkButton Text="Delete" runat="server" CssClass="Delete" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
        <tr>
            <td style="width: 150px">
                Feedback Description:<br />
                <asp:TextBox ID="txtFeedback" runat="server" Width="140" />
            </td>
            
            <td style="width: 100px">
                <br />
                <asp:Button ID="btnAdd" runat="server" Text="Add" />
            </td>
        </tr>
    </table>
    </div>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                type: "POST",
                url: "Feedback.aspx/GetFeedback",
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
            var row = $("[id*=gvFeedback] tr:last-child").clone(true);
            $("[id*=gvFeedback] tr").not($("[id*=gvFeedback] tr:first-child")).remove();
            $.each(Details, function () {
                var Detail = $(this);
                AppendRow(row, $(this).find("Feedback_Code").text(), $(this).find("Feedback_Desc").text())
                row = $("[id*=gvFeedback] tr:last-child").clone(true);
            });
        }

        function AppendRow(row, CId, name) {
            //Bind Feedback Code
            $(".Feedback_Code", row).find("span").html(CId);

            //Bind Feedback Description
            $(".Feedback_Desc", row).find("span").html(name);
            $(".Feedback_Desc", row).find("input").val(name);

            $("[id*=gvFeedback]").append(row);
        }

        //Add event handler.
        $("body").on("click", "[id*=btnAdd]", function () {
            var txtName = $("[id*=txtFeedback]");

            $.ajax({
                type: "POST",
                url: "Feedback.aspx/InsertFeedback",
                data: '{Feedback_Desc: "' + txtName.val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var row = $("[id*=gvFeedback] tr:last-child").clone(true);
                    AppendRow(row, response.d, txtName.val());
                    txtName.val("");

                }
            });
            return false;
        });

        //Edit event handler.
        $("body").on("click", "[id*=gvFeedback] .Edit", function () {
            var row = $(this).closest("tr");
            $("td", row).each(function () {
                if ($(this).find("input").length > 0) {
                    $(this).find("input").show();
                    $(this).find("span").hide();
                }
            });
            row.find(".Update").show();
            row.find(".Cancel").show();
            row.find(".Delete").hide();
            $(this).hide();
            return false;
        });

        //Update event handler.
        $("body").on("click", "[id*=gvFeedback] .Update", function () {
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
            var name = row.find(".Feedback_Desc").find("span").html();

            $.ajax({
                type: "POST",
                url: "Feedback.aspx/UpdateFeedback",
                data: '{Code: ' + Code + ', name: "' + name + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            });

            return false;
        });

        //Cancel event handler.
        $("body").on("click", "[id*=gvFeedback] .Cancel", function () {
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

        //Delete event handler.
        $("body").on("click", "[id*=gvFeedback] .Delete", function () {
            if (confirm("Do you want to delete this Feedback?")) {
                var row = $(this).closest("tr");
                var Code = row.find("span").html();
                $.ajax({
                    type: "POST",
                    url: "Feedback.aspx/DeleteFeedback",
                    data: '{Code: ' + Code + '}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        row.remove();
                    }
                });
            }

            return false;
        });
    </script>
</asp:Content>

