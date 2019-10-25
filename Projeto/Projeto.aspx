<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Projeto.aspx.cs" Inherits="Projeto.Projeto" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
    <title></title>
</head>
<body>


    <div class="container">
        <form id="form1" runat="server">

            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <a class="navbar-brand" href="#">Projeto</a>

                <div class="navbar-nav ml-auto">
                    <% if (Session["Nome"] == null)
                        { %>
                    <div class="input-group ">
                        <div class="input-group-prepend ">
                            <span class="input-group-text rounded-left">Login</span>
                        </div>
                        <asp:TextBox ID="txtLogin" runat="server" Width="140" CssClass="form-control mr-1 rounded-right" />

                        <div class="input-group-prepend ">
                            <span class="input-group-text rounded-left">Senha</span>
                        </div>
                        <asp:TextBox ID="txtSenha" runat="server" Width="140" CssClass="form-control mr-1 rounded-right" />

                        <asp:Button ID="btnLogar" runat="server" Text="Logar" OnClick="Logar" CssClass="btn btn-light" />
                    </div>
                    <%}
                        else
                        { %>

                    <asp:Label ID="txtStatus" runat="server" Text="" CssClass="bg-light rounded mr-1 text-dark"></asp:Label>


                    <asp:Button ID="btnSair" runat="server" Text="Sair" OnClick="Sair" CssClass="btn btn-light " />


                    <%} %>
                </div>

            </nav>
            <br />
            <div class="col">
            <asp:Label ID="txtErro" runat="server" Text="" CssClass="bg-light text-dark ml-auto"></asp:Label>
            </div>
            <% if (Session["Nome"] != null)
                { %>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataKeyNames="cd_id"
                OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
                OnRowUpdating="OnRowUpdating" OnRowDeleting="OnRowDeleting" EmptyDataText="Nenhum registro" CssClass="table table-bordered">
                <Columns>
                    <asp:TemplateField HeaderText="ID" >
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Text='<%# Eval("cd_id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Nome" >
                        <ItemTemplate>
                            <asp:Label ID="lblNome" runat="server" Text='<%# Eval("nm_nome") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNome" runat="server" Text='<%# Eval("nm_nome") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Endereço" >
                        <ItemTemplate>
                            <asp:Label ID="lblEndereco" runat="server" Text='<%# Eval("nm_endereco") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEndereco" runat="server" Text='<%# Eval("nm_endereco") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email" >
                        <ItemTemplate>
                            <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("nm_email") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEmail" runat="server" Text='<%# Eval("nm_email") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Login" >
                        <ItemTemplate>
                            <asp:Label ID="lblLogin" runat="server" Text='<%# Eval("nm_login") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLogin" runat="server" Text='<%# Eval("nm_login") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Senha" >
                        <ItemTemplate>
                            <asp:Label ID="lblSenha" runat="server" Text='<%# Eval("nm_senha") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtSenha" runat="server" Text='<%# Eval("nm_senha") %>'></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ButtonType="Link" ShowEditButton="true" ShowDeleteButton="true" ItemStyle-Width="150" />
                </Columns>
            </asp:GridView>
            <table border="1" style="border-collapse: collapse" class="table table-bordered ">
                <thead>
                    <tr>
                        <th>Cadastro</th>
                    </tr>
                </thead>
                <tr>
                    <td>Nome:<br />
                        <asp:TextBox ID="txtNome" runat="server" Width="140" />
                    </td>
                    <td>Endereço:<br />
                        <asp:TextBox ID="txtEndereco" runat="server" Width="140" />
                    </td>
                    <td>Email:<br />
                        <asp:TextBox ID="txtEmail" runat="server" Width="140" />
                    </td>
                    <td>Login:<br />
                        <asp:TextBox ID="txtCLogin" runat="server" Width="140" />
                    </td>
                    <td>Senha:<br />
                        <asp:TextBox ID="txtCSenha" runat="server" Width="140" />
                    </td>
                    <td align="center">
                        <asp:Button ID="btnAdd" runat="server" Text="Adicionar" OnClick="Insert" CssClass="btn btn-dark" />
                    </td>
                </tr>

                <tr>
                    <th>Procurar</th>

                </tr>
                <tr>
                    <td>Procurar por nome:<br />
                        <asp:TextBox ID="txtProcurar" runat="server" Width="140" />
                    </td>
                    <td align="center">
                        <asp:Button ID="btnProcurar" runat="server" Text="Procurar" OnClick="Procurar" CssClass="btn btn-dark" />
                    </td>
                    <td align="center">
                        <asp:Button ID="mostrar" runat="server" OnClick="mostrar_Click" Text="Mostrar todos" CssClass="btn btn-dark" />
                    </td>

                </tr>
                <tr>
                    <th>Exportar para excel</th>
                </tr>
                <tr>
                    <td align="center">
                        <asp:Button ID="Button1" runat="server" Text="Exportar" OnClick="Exportar" CssClass="btn btn-dark" />
                    </td>

                </tr>
            </table>
            <%} %>
        </form>
    </div>
</body>
</html>
