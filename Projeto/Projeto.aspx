<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Projeto.aspx.cs" Inherits="Projeto.Projeto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataKeyNames="cd_id"
        OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
        OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="Nenhum registro">
        <Columns>
            <asp:TemplateField HeaderText="Nome" ItemStyle-Width="150">
                <ItemTemplate>
                    <asp:Label ID="lblNome" runat="server" Text='<%# Eval("nm_nome") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtNome" runat="server" Text='<%# Eval("nm_nome") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Endereço" ItemStyle-Width="150">
                <ItemTemplate>
                    <asp:Label ID="lblEndereco" runat="server" Text='<%# Eval("nm_endereco") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEndereco" runat="server" Text='<%# Eval("nm_endereco") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Email" ItemStyle-Width="150">
                <ItemTemplate>
                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("nm_email") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("nm_email") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true"
                ItemStyle-Width="150" />
        </Columns>
    </asp:GridView>
    <table border="1" style="border-collapse: collapse">
        <tr>
            <td style="width: 150px">
                Nome:<br />
                <asp:TextBox ID="txtNome" runat="server" Width="140" />
            </td>
            <td style="width: 150px">
                Endereço:<br />
                <asp:TextBox ID="txtEndereco" runat="server" Width="140" />
            </td>
            <td style="width: 150px">
                Email:<br />
                <asp:TextBox ID="txtEmail" runat="server" Width="140" />
            </td>
            <td style="width: 100px">
                <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="Insert" />
            </td>
        </tr>
    </table>
        
    </form>
</body>
</html>
