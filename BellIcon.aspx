<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BellIcon.aspx.cs" Inherits="YourNamespace.UserBellIcon" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Notifications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
            <div class="container-fluid">
                <a class="navbar-brand" href="AdminHome.aspx">TechBlog Admin</a>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link" href="AdminHome.aspx">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="UserManagement.aspx">User Management</a></li>
                        <li class="nav-item"><a class="nav-link" href="NewsManagement.aspx">News Management</a></li>
                        <li class="nav-item"><a class="nav-link" href="GadgetManagement.aspx">Gadget Management</a></li>
                        <li class="nav-item"><a class="nav-link" href="CourseManagement.aspx">Course Management</a></li>
                        <li class="nav-item"><a class="nav-link" href="EmailNotification.aspx">Notification Management</a></li>
                    </ul>
                    <a href="UserBellIcon.aspx" class="btn btn-outline-light position-relative">
                        🔔
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notificationCount" runat="server">0</span>
                    </a>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light ms-2" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <div class="container mt-5">
            <h2 class="mb-4">🔔 Your Notifications</h2>

            <asp:Repeater ID="rptUserNotifications" runat="server">
                <ItemTemplate>
                    <div class="alert alert-light border d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <h6 class="mb-1"><%# Eval("Subject") %></h6>
                            <p class="mb-1"><%# Eval("Message") %></p>
                            <small class="text-muted">Posted on <%# Eval("CreatedAt", "{0:dd MMM yyyy hh:mm tt}") %></small>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <asp:Label ID="lblEmptyUser" runat="server" CssClass="text-muted" Visible="false" Text="No notifications found." />
        </div>
    </form>
</body>
</html>
