<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="miniProject.UserManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand" href="AdminHome.aspx">TechBlog Admin</a>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="AdminHome.aspx">Home</a></li>
                    <li class="nav-item"><a class="nav-link active" href="UserManagement.aspx">User Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="NewsManagement.aspx">News Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="GadgetManagement.aspx">Gadget Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="CourseManagement.aspx">Course Management</a></li>
                    <li class="nav-item"><a class="nav-link" href="EmailNotification.aspx">Notification Management</a></li>
                </ul>
                <a href="BellIcon.aspx" class="btn btn-outline-light position-relative">🔔
<span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notificationCount" runat="server">0</span>
                </a>

                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light ms-2" OnClick="btnLogout_Click" />
            </div>
        </div>
    </nav>
        <div id="google_translate_element" style="float: right; margin: 10px;"></div>

        <div class="container mt-4">
            <h3 class="mb-4">User Management</h3>

            <asp:Label ID="lblUserCount" runat="server" CssClass="badge bg-primary fs-5 px-3 py-2 mb-3" />

            <!-- Search + View All + Sort -->
            <div class="card mb-4">
                <div class="card-header">Search and Sort Users</div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8">
                            <div class="input-group mb-3">
                                <asp:TextBox ID="txtSearchUser" runat="server" CssClass="form-control" placeholder="Enter name to search" />
                                <asp:Button ID="btnSearchUser" runat="server" Text="Search" CssClass="btn btn-outline-primary" OnClick="btnSearchUser_Click" />
                                <asp:Button ID="btnViewAllUsers" runat="server" Text="View All" CssClass="btn btn-outline-secondary ms-2" OnClick="btnViewAllUsers_Click" />
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="d-flex gap-2">
                                <asp:DropDownList ID="ddlSortBy" runat="server" CssClass="form-select">
                                    <asp:ListItem Text="Default" Value="Default" />
                                    <asp:ListItem Text="Newest First" Value="Newest" />
                                    <asp:ListItem Text="Oldest First" Value="Oldest" />
                                    <asp:ListItem Text="Name (A-Z)" Value="Name" />
                                </asp:DropDownList>
                                <asp:Button ID="btnSortUsers" runat="server" Text="Sort" CssClass="btn btn-outline-info" OnClick="btnSortUsers_Click" />
                            </div>
                        </div>
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
