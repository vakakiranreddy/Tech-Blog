<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GadgetManagement.aspx.cs" Inherits="miniProject.GadgetManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Gadget Management</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&family=Roboto&display=swap" rel="stylesheet" />

    <!-- Custom Styles -->
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }

        h3, .card-title {
            font-family: 'Poppins', sans-serif;
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            transition: all 0.3s ease-in-out;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.2);
        }

        .gadget-summary {
            background: linear-gradient(to right, #007BFF, #00BFFF);
            color: white;
            padding: 15px 20px;
            border-radius: 10px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        label {
            font-weight: 500;
        }

        .btn {
            border-radius: 6px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
            <div class="container-fluid">
                <a class="navbar-brand" href="AdminHome.aspx">🏠 Admin</a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item"><a class="nav-link" href="AdminHome.aspx">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="UserManagement.aspx">User Management</a></li>
                        <li class="nav-item"><a class="nav-link" href="NewsManagement.aspx">News Management</a></li>
                        <li class="nav-item"><a class="nav-link active" href="GadgetManagement.aspx">Gadget Management</a></li>
                        <li class="nav-item"><a class="nav-link" href="CourseManagement.aspx">Course Management</a></li>
                    </ul>
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-light" OnClick="btnLogout_Click" />
                </div>
            </div>
        </nav>
         <div id="google_translate_element" style="float: right; margin: 10px;"></div>

        <div class="container mt-4">
            <h3 class="mb-3 text-center">Manage Gadgets</h3>

            <!-- Gadget Count Summary -->
            <div class="gadget-summary text-center">
                <asp:Label ID="lblGadgetCount" runat="server" />
            </div>

            <!-- Top 3 Gadget Cards -->
            <div class="row mb-4" id="topGadgetCards" runat="server">
                <!-- Cards populated from backend -->
            </div>

            <!-- Add / Update Form -->
            <div class="card mb-4">
                <div class="card-header bg-light">Add / Update Gadget</div>
                <div class="card-body">
                    <div class="row">
                        <div class="mb-3 col-md-6">
                            <label>Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
                        </div>
                        <div class="mb-3 col-md-6">
                            <label>Release Date</label>
                            <asp:TextBox ID="txtReleaseDate" runat="server" CssClass="form-control" TextMode="Date" />
                        </div>
                    </div>
                    <div class="mb-3">
                        <label>Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label>Upload Image</label>
                        <asp:FileUpload ID="fileImage" runat="server" CssClass="form-control" />
                    </div>
                    <asp:HiddenField ID="hdnGadgetId" runat="server" />
                    <asp:Button ID="btnSave" runat="server" Text="Save Gadget" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                </div>
            </div>

            <!-- All Gadgets Table -->
            <asp:GridView ID="gvGadgets" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered" OnRowCommand="gvGadgets_RowCommand">
                <Columns>
                    <asp:BoundField DataField="gadgetid" HeaderText="ID" />
                    <asp:BoundField DataField="name" HeaderText="Name" />
                    <asp:BoundField DataField="releasedate" HeaderText="Release Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                            <img src='<%# Eval("image") %>' style="height: 60px; width: 100px; object-fit: cover;" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnEdit" runat="server" CommandName="EditGadget" CommandArgument='<%# Eval("gadgetid") %>' Text="Edit" CssClass="btn btn-sm btn-warning" />
                            <asp:Button ID="btnDelete" runat="server" CommandName="DeleteGadget" CommandArgument='<%# Eval("gadgetid") %>' Text="Delete" CssClass="btn btn-sm btn-danger ms-1" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
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
