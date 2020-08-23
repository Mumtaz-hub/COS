<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Item_Category.aspx.cs" Inherits="Admin_Item_Category" %>

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
<asp:GridView ID="gvItemCategory" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="Category Code" ItemStyle-Width="110px" ItemStyle-CssClass="Category_Id">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Category_Id") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Category Name" ItemStyle-Width="150px" ItemStyle-CssClass="Category_Name">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Category_Name") %>' runat="server" />
                    <asp:TextBox Text='<%# Eval("Category_Name") %>' runat="server" Style="display: none" />
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
                Category Name:<br />
                <asp:TextBox ID="txtCName" runat="server" Width="140" />
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
                url: "Item_Category.aspx/GetItemCategory",
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
            var row = $("[id*=gvItemCategory] tr:last-child").clone(true);
            $("[id*=gvItemCategory] tr").not($("[id*=gvItemCategory] tr:first-child")).remove();
            $.each(Categories, function () {
                var Category = $(this);
                AppendRow(row, $(this).find("Category_Id").text(), $(this).find("Category_Name").text())
                row = $("[id*=gvItemCategory] tr:last-child").clone(true);
            });
        }

        function AppendRow(row, CId, name) {
            //Bind Category Id.
            $(".Category_Id", row).find("span").html(CId);

            //Bind Category Name.
            $(".Category_Name", row).find("span").html(name);
            $(".Category_Name", row).find("input").val(name);

            $("[id*=gvItemCategory]").append(row);
        }

        //Add event handler.
        $("body").on("click", "[id*=btnAdd]", function () {
            var txtCName = $("[id*=txtCName]");
            
            $.ajax({
                type: "POST",
                url: "Item_Category.aspx/InsertCategory",
                data: '{Category_Name: "' + txtCName.val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var row = $("[id*=gvItemCategory] tr:last-child").clone(true);
                    AppendRow(row, response.d, txtCName.val());
                    txtCName.val("");
                    
                }
            });
            return false;
        });

        //Edit event handler.
        $("body").on("click", "[id*=gvItemCategory] .Edit", function () {
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
        $("body").on("click", "[id*=gvItemCategory] .Update", function () {
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

            var CCode = row.find(".Category_Id").find("span").html();
            var Cname = row.find(".Category_Name").find("span").html();
            
            $.ajax({
                type: "POST",
                url: "Item_Category.aspx/UpdateCategory",
                data: '{CCode: ' + CCode + ', Cname: "' + Cname + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            });

            return false;
        });
        //Cancel event handler.
        $("body").on("click", "[id*=gvItemCategory] .Cancel", function () {
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
        $("body").on("click", "[id*=gvItemCategory] .Delete", function () {
            if (confirm("Do you want to delete this Category?")) {
                var row = $(this).closest("tr");
                var Code = row.find("span").html();
                $.ajax({
                    type: "POST",
                    url: "Item_Category.aspx/DeleteCategory",
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

