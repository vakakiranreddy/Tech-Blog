<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="miniProject.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <h2 class="text-center mb-4">Sign Up</h2>
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <asp:Label ID="lblMessage" runat="server" CssClass="form-text text-danger mb-2" />
                    <div class="mb-3">
                        <label>Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    </div>
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary w-100" OnClick="btnRegister_Click" />
                    <div class="text-center mt-3">
                        Already have an account?
                        <a href="Login.aspx" class="text-decoration-none">Login</a>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
