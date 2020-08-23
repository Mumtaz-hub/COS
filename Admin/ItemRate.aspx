<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="ItemRate.aspx.cs" Inherits="Admin_ItemRate" %>

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
                    <asp:LinkButton Text="Select" runat="server" CssClass="Select" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <br /><br />
    <asp:GridView ID="gvItemDetails" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="Item Code" ItemStyle-Width="110px" ItemStyle-CssClass="Item_Code">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Item_Code") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Item Name" ItemStyle-Width="150px" ItemStyle-CssClass="Item_Name">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Item_Name") %>' runat="server" />
                    <asp:TextBox Text='<%# Eval("Item_Name") %>' runat="server" Style="display: none" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Item Rate" ItemStyle-Width="150px" ItemStyle-CssClass="Item_Rate">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Item_Rate") %>' runat="server" />
                    <asp:TextBox Text='<%# Eval("Item_Rate") %>' runat="server" Style="display: none" />
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
                Item Name:<br />
                <asp:TextBox ID="txtItemName" runat="server" Width="140" />
            </td>
            <td style="width: 100px">
                Item Rate:<br />
                <asp:TextBox ID="txtItemRate" runat="server" Width="140" />
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
            url: "ItemRate.aspx/GetItemGroup",
            data: '{}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess
        });
    });

    $(function () {
        $.ajax({
            type: "POST",
            url: "ItemRate.aspx/GetItemByGrpCode",
            data: '{Code:0}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess1
        });
    });

    function OnSuccess(response) {
        var xmlDoc = $.parseXML(response.d);
        var xml = $(xmlDoc);
        var Groups = xml.find("Table");
        var row = $("[id*=gvItemGroup] tr:last-child").clone(true);
        $("[id*=gvItemGroup] tr").not($("[id*=gvItemGroup] tr:first-child")).remove();
        $.each(Groups, function () {
            var Group = $(this);
            AppendRow(row, $(this).find("GrpCode").text(), $(this).find("GrpName").text())
            row = $("[id*=gvItemGroup] tr:last-child").clone(true);
        });
    }

    function AppendRow(row, Id, name) {
        //Bind Group Code
        $(".GrpCode", row).find("span").html(Id);

        //Bind Group Name.
        $(".GrpName", row).find("span").html(name);
        $(".GrpName", row).find("input").val(name);

        $("[id*=gvItemGroup]").append(row);
    }

    //Selete event handler.
    $("body").on("click", "[id*=gvItemGroup] .Select", function () {

        var row = $(this).closest("tr");
        var Code = row.find("span").html();

        $.ajax({
            type: "POST",
            url: "ItemRate.aspx/GetItemByGrpCode",
            data: '{Code: ' + Code + '}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: OnSuccess1
        });

        return false;
    });

    function OnSuccess1(response) {
        var xmlDoc = $.parseXML(response.d);
        var xml = $(xmlDoc);
        var Details = xml.find("Table");
        var row = $("[id*=gvItemDetails] tr:last-child").clone(true);
        $("[id*=gvItemDetails] tr").not($("[id*=gvItemDetails] tr:first-child")).remove();
        $.each(Details, function () {
            var Detail = $(this);
            AppendRow1(row, $(this).find("Item_Code").text(), $(this).find("Item_Name").text(), $(this).find("Item_Rate").text())
            row = $("[id*=gvItemDetails] tr:last-child").clone(true);
        });
    }

    function AppendRow1(row, Id, name,rate) {
        //Bind Item Code.
        $(".Item_Code", row).find("span").html(Id);

        //Bind Item Name.
        $(".Item_Name", row).find("span").html(name);
        $(".Item_Name", row).find("input").val(name);

        //Bind Item Rate.
        $(".Item_Rate", row).find("span").html(rate);
        $(".Item_Rate", row).find("input").val(rate);

        $("[id*=gvItemDetails]").append(row);
    }

    //Add event handler.
    $("body").on("click", "[id*=btnAdd]", function () {
        var txtItemName = $("[id*=txtItemName]");
        var txtItemRate = $("[id*=txtItemRate]");
        var data = { ItemName: "" + txtItemName.val() + "",ItemRate:+ txtItemRate.val()};

        $.ajax({
            type: "POST",
            url: "ItemRate.aspx/InsertItem",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (response) {
                var row = $("[id*=gvItemDetails] tr:last-child").clone(true);
                AppendRow1(row, response.d, txtItemName.val(), txtItemRate.val());
                txtItemName.val("");
                txtItemRate.val("");

            }
        });
        return false;
    });

    //Edit event handler.
    $("body").on("click", "[id*=gvItemDetails] .Edit", function () {
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
    $("body").on("click", "[id*=gvItemDetails] .Update", function () {
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

        var Code = row.find(".Item_Code").find("span").html();
        var name = row.find(".Item_Name").find("span").html();
        var Rate = row.find(".Item_Rate").find("span").html();

        $.ajax({
            type: "POST",
            url: "ItemRate.aspx/UpdateItem",
            data: '{ItemCode: ' + Code + ', ItemName: "' + name + '", ItemRate: "' + Rate + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json"
        });

        return false;
    });

    //Cancel event handler.
    $("body").on("click", "[id*=gvItemDetails] .Cancel", function () {
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
    $("body").on("click", "[id*=gvItemDetails] .Delete", function () {
        if (confirm("Do you want to delete this Item Item?")) {
            var row = $(this).closest("tr");
            var Code = row.find("span").html();
            $.ajax({
                type: "POST",
                url: "ItemRate.aspx/DeleteItem",
                data: '{ItemCode: ' + Code + '}',
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

