<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="Pharmacy.WebForms.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="Bootstrap/css/login.css" />
</head>
<body>
    <div style="margin-top: 100px">
        <form id="loginForm" runat="server" class="login-form">
            <div class="header">
                <h1>Welcome to</h1>
                <h1>Pharmacy</h1>
            </div>

            <div class="content">
                <asp:TextBox runat="server" ID="txUsername" name="username" type="text" class="input username" placeholder="Username" required="required" />
                <div class="user-icon"></div>
                <asp:TextBox runat="server" ID="txPassword" name="password" type="password" class="input password" placeholder="Password" required="required" />
                <div class="pass-icon"></div>
            </div>

            <div class="footer">
                <asp:Button runat="server" ID="btnLogin" CssClass="button" Text="Login" OnClick="btnLogin_Click" />
                <asp:Label runat="server" ID="lblLoginMessage" ForeColor="Maroon" Text=""></asp:Label>
            </div>
        </form>
    </div>
</body>
</html>
