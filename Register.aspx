<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs"
    Inherits="miniProject.Register" ValidateRequest="true" EnableEventValidation="true" %>

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

                    <!-- Full Name -->
                    <div class="mb-3">
                        <label>Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                            ErrorMessage="Full Name is required." ForeColor="Red" CssClass="form-text"
                            Display="Dynamic" EnableClientScript="true" />
                    </div>

                    <!-- Email -->
                    <div class="mb-3">
                        <label>Email</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Email is required." ForeColor="Red" CssClass="form-text"
                            Display="Dynamic" EnableClientScript="true" />
                        <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                            ErrorMessage="Enter a valid Gmail address."
                            ValidationExpression="^[a-zA-Z0-9._%+-]+@gmail\.com$" ForeColor="Red"
                            CssClass="form-text" Display="Dynamic" EnableClientScript="true" />
                    </div>

                    <!-- Password -->
                    <div class="mb-3">
                        <label>Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Password is required." ForeColor="Red" CssClass="form-text"
                            Display="Dynamic" EnableClientScript="true" />
                        <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
                            ErrorMessage="Password must be 6–12 chars, 1 uppercase, 1 digit."
                            ValidationExpression="^(?=.*[A-Z])(?=.*\d)[A-Za-z\d]{6,12}$"
                            ForeColor="Red" CssClass="form-text" Display="Dynamic" EnableClientScript="true" />

                    </div>

                    <!-- Confirm Password -->
                    <div class="mb-3">
                        <label>Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" />
                        <asp:RequiredFieldValidator ID="rfvConfirm" runat="server" ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Confirm Password is required." ForeColor="Red" CssClass="form-text"
                            Display="Dynamic" EnableClientScript="true" />
                        <asp:CompareValidator ID="cvPasswords" runat="server"
                            ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"
                            ErrorMessage="Passwords do not match." ForeColor="Red" CssClass="form-text"
                            Display="Dynamic" EnableClientScript="true" />
                    </div>

                    <!-- Register Button -->
                    <asp:Button ID="btnRegister" runat="server" Text="Register"
                        CssClass="btn btn-primary w-100" OnClick="btnRegister_Click" />

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
