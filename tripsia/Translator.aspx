<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Translator.aspx.cs" Inherits="EADP_Project.Pages.Translator" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 587px;
        }
        .auto-style2 {
            width: 587px;
            height: 26px;
        }
        .auto-style3 {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table style="width:100%;">
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="Label1" runat="server" Text="From"></asp:Label>
&nbsp;<asp:DropDownList ID="ddlFrom" runat="server">
                        <asp:ListItem Value="en">English</asp:ListItem>
                        <asp:ListItem Value="ko">Korean</asp:ListItem>
                        <asp:ListItem Value="ja">Japanese</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="auto-style3">
                    <asp:Label ID="Label2" runat="server" Text="To"></asp:Label>
&nbsp;<asp:DropDownList ID="ddlTo" runat="server">
                        <asp:ListItem Value="en">English</asp:ListItem>
                        <asp:ListItem Value="ko">Korean</asp:ListItem>
                        <asp:ListItem Value="ja">Japanese</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:TextBox ID="tbFrom" runat="server" Height="300px" Width="500px"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="tbTo" runat="server" Height="300px" Width="500px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" Text="Submit" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
