<%@ Page Title="" Language="C#" MasterPageFile="~/master_User.master" AutoEventWireup="true" CodeFile="ShowFeedback.aspx.cs" Inherits="ShowFeedback" %>

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
            
            
        </Columns>
    </asp:GridView>
    
    </div>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">

        $(function () {
            $.ajax({
                type: "POST",
                url: "ShowFeedback.aspx/GetFeedback",
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
        </script>    
</asp:Content>

