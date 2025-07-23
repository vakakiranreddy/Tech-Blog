using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace miniProject
{
    public partial class GadgetManagement : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    UpdateNotificationCount();
                    LoadTop3Gadgets();
                    LoadGadgetCount();
                    LoadAllGadgets();
                }
                catch (Exception ex)
                {
                    lblGadgetCount.Text = "Error loading data: " + ex.Message;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string name = txtName.Text.Trim();
                string description = txtDescription.Text.Trim();
                DateTime releaseDate = Convert.ToDateTime(txtReleaseDate.Text.Trim());
                string imagePath = "";

                if (fileImage.HasFile)
                {
                    string fileName = Path.GetFileName(fileImage.PostedFile.FileName);
                    string folderPath = Server.MapPath("~/uploads/");
                    if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);
                    imagePath = "uploads/" + fileName;
                    fileImage.SaveAs(Path.Combine(folderPath, fileName));
                }

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd;
                    if (string.IsNullOrEmpty(hdnGadgetId.Value))
                    {
                        cmd = new SqlCommand("addgadget", conn);
                    }
                    else
                    {
                        cmd = new SqlCommand("updategadget", conn);
                        cmd.Parameters.AddWithValue("@gadgetid", hdnGadgetId.Value);
                    }

                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@description", description);
                    cmd.Parameters.AddWithValue("@image", imagePath);
                    cmd.Parameters.AddWithValue("@releasedate", releaseDate);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                ClearForm();
                LoadTop3Gadgets();
                LoadGadgetCount();
                LoadAllGadgets();
            }
            catch (Exception ex)
            {
                lblGadgetCount.Text = "Error saving gadget: " + ex.Message;
            }
        }

        protected void gvGadgets_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(e.CommandArgument);
                if (e.CommandName == "EditGadget")
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        SqlCommand cmd = new SqlCommand("SELECT * FROM latestgadgets WHERE gadgetid = @id", conn);
                        cmd.Parameters.AddWithValue("@id", id);
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            txtName.Text = reader["name"].ToString();
                            txtDescription.Text = reader["description"].ToString();
                            txtReleaseDate.Text = Convert.ToDateTime(reader["releasedate"]).ToString("yyyy-MM-dd");
                            hdnGadgetId.Value = reader["gadgetid"].ToString();
                        }
                    }
                }
                else if (e.CommandName == "DeleteGadget")
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        SqlCommand cmd = new SqlCommand("deletegadget", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@gadgetid", id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }

                    LoadTop3Gadgets();
                    LoadGadgetCount();
                    LoadAllGadgets();
                }
            }
            catch (Exception ex)
            {
                lblGadgetCount.Text = "Error processing gadget: " + ex.Message;
            }
        }
        private void UpdateNotificationCount()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("sp_getnotificationcount", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();

                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        notificationCount.InnerText = result.ToString();
                    }
                }
            }
            catch (Exception)
            {
                notificationCount.InnerText = "0";
            }
        }

        private void LoadTop3Gadgets()
        {
            try
            {
                topGadgetCards.Controls.Clear();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT TOP 3 * FROM latestgadgets ORDER BY releasedate DESC", conn);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string name = reader["name"].ToString();
                        string description = reader["description"].ToString();
                        string image = reader["image"].ToString();

                        string cardHtml = $@"<div class='col-lg-4 col-md-6 mb-3'>
    <div class='card h-100'>
        <img src='{image}' class='card-img-top' style='height:150px; object-fit:cover;' />
        <div class='card-body'>
            <h5 class='card-title'>{name}</h5>
            <p class='card-text'>{(description.Length > 100 ? description.Substring(0, 100) + "..." : description)}</p>
        </div>
    </div>
</div>";
                        topGadgetCards.Controls.Add(new LiteralControl(cardHtml));
                    }
                }
            }
            catch (Exception ex)
            {
                topGadgetCards.Controls.Add(new LiteralControl("<p class='text-danger'>Error loading top gadgets: " + ex.Message + "</p>"));
            }
        }

        private void LoadAllGadgets()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM latestgadgets ORDER BY releasedate DESC", conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvGadgets.DataSource = dt;
                    gvGadgets.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblGadgetCount.Text = "Error loading all gadgets: " + ex.Message;
            }
        }

        private void LoadGadgetCount()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM latestgadgets", conn);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    lblGadgetCount.Text = "Total Gadgets: " + count;
                }
            }
            catch (Exception ex)
            {
                lblGadgetCount.Text = "Error counting gadgets: " + ex.Message;
            }
        }

        private void ClearForm()
        {
            txtName.Text = "";
            txtDescription.Text = "";
            txtReleaseDate.Text = "";
            hdnGadgetId.Value = "";
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            try
            {
                Session.Clear();
                Response.Redirect("Login.aspx");
            }
            catch (Exception ex)
            {
                lblGadgetCount.Text = "Error during logout: " + ex.Message;
            }
        }
    }
}
