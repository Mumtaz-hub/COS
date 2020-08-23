<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="ItemGroup.aspx.cs" Inherits="Admin_ItemGroup" %>

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
            /*width:30%*/
            padding: 5px;
            border: 1px solid #ccc;
        }
        
        
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate> 
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
                    <asp:LinkButton Text="Select" runat="server" CssClass="Select" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <br /><br />
<asp:GridView ID="gvItemGroup" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="Group Code" ItemStyle-Width="110px" ItemStyle-CssClass="GrpCode">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("GrpCode") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Group Name" ItemStyle-Width="150px" ItemStyle-CssClass="GrpName">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("GrpName") %>' runat="server" />
                    <asp:TextBox Text='<%# Eval("GrpName") %>' runat="server" Style="display: none" />
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
            <td style="width: 100px">
                Group Name:<br />
                <asp:TextBox ID="txtGName" runat="server" Width="140" />
            </td>
            
            <td style="width: 50px">
                <br />
                <asp:Button ID="btnAdd" runat="server" Text="Add" />
            </td>
        </tr>
    </table>
</div>
 
</ContentTemplate>  
</asp:UpdatePanel>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        
        $(function () {
            $.ajax({
                type: "POST",
                url: "ItemGroup.aspx/GetItemCategory",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess
            });
        });

        $(function () {
            $.ajax({
                type: "POST",
                url: "ItemGroup.aspx/GetItemByCategoryId",
                data: '{CCode:1}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess1
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


        //Selete event handler.
        $("body").on("click", "[id*=gvItemCategory] .Select", function () {

            var row = $(this).closest("tr");
            var CCode = row.find("span").html();
            

            $.ajax({
                type: "POST",
                url: "ItemGroup.aspx/GetItemByCategoryId",
                data: '{CCode: ' + CCode + '}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess1
            });

            return false;
        });

        function OnSuccess1(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var Groups = xml.find("Table");
            var row = $("[id*=gvItemGroup] tr:last-child").clone(true);
            $("[id*=gvItemGroup] tr").not($("[id*=gvItemGroup] tr:first-child")).remove();
            $.each(Groups, function () {
                var Group = $(this);
                AppendRow1(row, $(this).find("GrpCode").text(), $(this).find("GrpName").text())
                row = $("[id*=gvItemGroup] tr:last-child").clone(true);
            });
        }

        function AppendRow1(row, GId, name) {
            //Bind Category Id.
            $(".GrpCode", row).find("span").html(GId);

            //Bind Category Name.
            $(".GrpName", row).find("span").html(name);
            $(".GrpName", row).find("input").val(name);

            $("[id*=gvItemGroup]").append(row);
        }

        //Add event handler.
        $("body").on("click", "[id*=btnAdd]", function () {
            var txtGName = $("[id*=txtGName]");

            $.ajax({
                type: "POST",
                url: "ItemGroup.aspx/InsertGroup",
                data: '{GrpName: "' + txtGName.val() + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var row = $("[id*=gvItemGroup] tr:last-child").clone(true);
                    AppendRow1(row, response.d, txtGName.val());
                    txtGName.val("");

                }
            });
            return false;
        });
        //Edit event handler.
        $("body").on("click", "[id*=gvItemGroup] .Edit", function () {
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
        $("body").on("click", "[id*=gvItemGroup] .Update", function () {
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

            var CCode = row.find(".GrpCode").find("span").html();
            var Cname = row.find(".GrpName").find("span").html();

            $.ajax({
                type: "POST",
                url: "ItemGroup.aspx/UpdateGroup",
                data: '{GrpCode: ' + CCode + ', GrpName: "' + Cname + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            });

            return false;
        });

        //Cancel event handler.
        $("body").on("click", "[id*=gvItemGroup] .Cancel", function () {
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
        $("body").on("click", "[id*=gvItemGroup] .Delete", function () {
            if (confirm("Do you want to delete this Item Group?")) {
                var row = $(this).closest("tr");
                var CCode = row.find("span").html();
                $.ajax({
                    type: "POST",
                    url: "ItemGroup.aspx/DeleteGroup",
                    data: '{GrpCode: ' + CCode + '}',
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

