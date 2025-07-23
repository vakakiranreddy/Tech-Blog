<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailNotification.aspx.cs" Inherits="miniProject.EmailNotification" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Email Notification</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Navbar with bell icon -->
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
                        <li class="nav-item"><a class="nav-link active" href="EmailNotification.aspx">Notification Management</a></li>
                    </ul>
                    <a href="BellIcon.aspx" class="btn btn-outline-light position-relative">🔔
    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" id="notificationCount" runat="server">0</span>
                    </a>

                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light ms-2" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>

        <!-- Email Form -->
        <div class="container mt-5">
            <h2>Email Notification Panel</h2>
            <div class="mb-3">
                <label class="form-label">Subject</label>
                <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label class="form-label">Message</label>
                <asp:TextBox ID="txtBody" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" />
            </div>
            <asp:Button ID="btnSend" runat="server" CssClass="btn btn-primary" Text="Send Email" OnClick="btnSend_Click" />
            <br />
            <br />
            <asp:Label ID="lblStatus" runat="server" CssClass="text-success"></asp:Label>
        </div>

        <!-- Search + View -->
        <div class="container mt-4">
            <div class="d-flex align-items-center gap-3">
                <asp:TextBox ID="txtSearchSubject" runat="server" CssClass="form-control w-50" placeholder="Search by Subject" />
                <asp:Button ID="btnSearch" runat="server" CssClass="btn btn-info" Text="Search" OnClick="btnSearch_Click" />
                <asp:Button ID="btnViewAll" runat="server" CssClass="btn btn-secondary" Text="View All" OnClick="btnViewAll_Click" />
                <asp:Label ID="lblTotalCount" runat="server" CssClass="ms-3 fw-bold"></asp:Label>
            </div>
        </div>

        <!-- Notification List -->
        <div class="container mt-4">
            <asp:Repeater ID="rptNotifications" runat="server">
                <ItemTemplate>
                    <div class="card my-2 shadow-sm">
                        <div class="card-body d-flex justify-content-between align-items-start">
                            <div>
                                <h5 class="card-title"><%# Eval("Subject") %></h5>
                                <p class="card-text"><%# Eval("Message") %></p>
                                <small class="text-muted"><%# Eval("CreatedAt", "{0:g}") %></small>
                            </div>
                            <asp:Button ID="btnDelete" runat="server" Text="🗑️" CssClass="btn btn-sm btn-danger"
                                CommandArgument='<%# Eval("NotificationId") %>'
                                OnCommand="DeleteNotification_Command" />
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
