<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="miniProject.UserManagement" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="AdminHome.aspx">🏠 Admin</a>
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="AdminHome.aspx">Home</a></li>
                    <li class="nav-item"><a class="nav-link active" href="UserManagement.aspx">User Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="NewsManagement.aspx">News Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="GadgetManagement.aspx">Gadget Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="CourseManagement.aspx">Course Management</a></li>
                </ul>
                <asp:Button ID="btnLogoutUser" runat="server" Text="Logout" CssClass="btn btn-outline-light" OnClick="btnLogout_Click" />
            </div>
        </nav>
         <div id="google_translate_element" style="float: right; margin: 10px;"></div>

        <div class="container mt-4">
            <h3 class="mb-4">User Management</h3>

            <asp:Label ID="lblUserCount" runat="server" CssClass="form-text text-primary mb-2" />

            <!-- Search + View All -->
            <div class="card mb-4">
                <div class="card-header">Search User</div>
                <div class="card-body">
                    <div class="input-group mb-3">
                        <asp:TextBox ID="txtSearchUser" runat="server" CssClass="form-control" placeholder="Enter name to search" />
                        <asp:Button ID="btnSearchUser" runat="server" Text="Search" CssClass="btn btn-outline-primary" OnClick="btnSearchUser_Click" />
                        <asp:Button ID="btnViewAllUsers" runat="server" Text="View All" CssClass="btn btn-outline-secondary ms-2" OnClick="btnViewAllUsers_Click" />
                    </div>
                </div>
            </div>

            <!-- GridView -->
            <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" OnRowCommand="gvUsers_RowCommand">
                <Columns>
                    <asp:BoundField DataField="userid" HeaderText="ID" />
                    <asp:BoundField DataField="fullname" HeaderText="Full Name" />
                    <asp:BoundField DataField="email" HeaderText="Email" />
                    <asp:BoundField DataField="role" HeaderText="Role" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnDelete" runat="server" CommandName="DeleteUser" CommandArgument='<%# Eval("userid") %>' Text="Delete" CssClass="btn btn-sm btn-danger" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
        <script type="text/javascript">
  function googleTranslateElementInit() {
    new google.translate.TranslateElement(
      {
        pageLanguage: 'en',
        includedLanguages: 'hi,te,en',
        layout: google.translate.TranslateElement.InlineLayout.SIMPLE
      },
      'google_translate_element'
    );
  }
        </script>
<script type="text/javascript" src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
</body>
</html>
