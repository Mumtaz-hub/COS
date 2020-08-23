<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true" CodeFile="Department.aspx.cs" Inherits="Admin_Department" %>

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
<asp:GridView ID="gvDept" runat="server" AutoGenerateColumns="false">
        <Columns>
            <asp:TemplateField HeaderText="Department Code" ItemStyle-Width="110px" ItemStyle-CssClass="Dept_Code">
                <ItemTemplate>
                    <asp:Label Text='<%# Eval("Dept_Code") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Department Name" ItemStyle-Width="150px" ItemStyle-CssClass="Dept_Name">
                <ItemTemplate>
                    <asp:Label  Text='<%# Eval("Dept_Name") %>' runat="server" />
                    <asp:TextBox Text='<%# Eval("Dept_Name") %>' runat="server" Style="display: none" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="HOD Name" ItemStyle-Width="150px" ItemStyle-CssClass="HOD">
                <ItemTemplate>
                    <asp:Label  Text='<%# Eval("HOD") %>' runat="server" />
                    <asp:TextBox Text='<%# Eval("HOD") %>' runat="server" Style="display: none" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="DEBIT_CODE" ItemStyle-Width="150px" ItemStyle-CssClass="DEBIT_CODE">
                <ItemTemplate>
                    <asp:Label  Text='<%# Eval("DEBIT_CODE") %>' runat="server" />
                    <asp:TextBox Text='<%# Eval("DEBIT_CODE") %>' runat="server" Style="display: none" />
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
                Department Name:<br />
                <asp:TextBox ID="txtDName" runat="server" Width="140" />
            </td>
            <td style="width: 150px">
                HOD Name:<br />
                <asp:TextBox ID="txtHOD" runat="server" Width="140" />
            </td>
            <td style="width: 150px">
                DEBIT CODE:<br />
                <asp:TextBox ID="txtDebitCode" runat="server" Width="140" />
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
                url: "Department.aspx/GetDept",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess
            });
        });

        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var Depts = xml.find("Table");
            var row = $("[id*=gvDept] tr:last-child").clone(true);
            $("[id*=gvDept] tr").not($("[id*=gvDept] tr:first-child")).remove();
            $.each(Depts, function () {
                var Dept = $(this);
                AppendRow(row, $(this).find("Dept_Code").text(), $(this).find("Dept_Name").text(), $(this).find("HOD").text(), $(this).find("DEBIT_CODE").text())
                row = $("[id*=gvDept] tr:last-child").clone(true);
            });
        }

        function AppendRow(row, DId, name, hod,debitcode) {
            //Bind Department Id.
            $(".Dept_Code", row).find("span").html(DId);

            //Bind Name.
            $(".Dept_Name", row).find("span").html(name);
            $(".Dept_Name", row).find("input").val(name);

            //Bind HOD.
            $(".HOD", row).find("span").html(hod);
            $(".HOD", row).find("input").val(hod);

            //Bind HOD.
            $(".DEBIT_CODE", row).find("span").html(debitcode);
            $(".DEBIT_CODE", row).find("input").val(debitcode);

            $("[id*=gvDept]").append(row);
        }

        //Add event handler.
        $("body").on("click", "[id*=btnAdd]", function () {
            var txtDName = $("[id*=txtDName]");
            var txtHOD = $("[id*=txtHOD]");
            var txtDebitCode = $("[id*=txtDebitCode]");

            $.ajax({
                type: "POST",
                url: "Department.aspx/InsertDepartment",
                data: '{Dept_Name: "' + txtDName.val() + '", HOD: "' + txtHOD.val() + '" , DEBIT_CODE: "' + txtDebitCode.val() + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    var row = $("[id*=gvDept] tr:last-child").clone(true);
                    AppendRow(row, response.d, txtDName.val(), txtHOD.val(), txtDebitCode.val());
                    txtDName.val("");
                    txtHOD.val("");
                    txtDebitCode.val("");
                }
            });
            return false;
        });

        //Edit event handler.
        $("body").on("click", "[id*=gvDept] .Edit", function () {
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
        $("body").on("click", "[id*=gvDept] .Update", function () {
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

            var DeptCode = row.find(".Dept_Code").find("span").html();
            var Dname = row.find(".Dept_Name").find("span").html();
            var HOD = row.find(".HOD").find("span").html();
            var DebitCode = row.find(".DEBIT_CODE").find("span").html();
            $.ajax({
                type: "POST",
                url: "Department.aspx/UpdateDepartment",
                data: '{DeptCode: ' + DeptCode + ', Dname: "' + Dname + '", HOD: "' + HOD + '" , DEBIT_CODE: "' + DebitCode + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json"
            });

            return false;
        });
        //Cancel event handler.
        $("body").on("click", "[id*=gvDept] .Cancel", function () {
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
        $("body").on("click", "[id*=gvDept] .Delete", function () {
            if (confirm("Do you want to delete this Department?")) {
                var row = $(this).closest("tr");
                var DCode = row.find("span").html();
                $.ajax({
                    type: "POST",
                    url: "Department.aspx/DeleteDepartment",
                    data: '{DeptCode: ' + DCode + '}',
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

