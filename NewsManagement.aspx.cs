using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace miniProject
{
    public partial class NewsManagement : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    UpdateNotificationCount();
                    LoadTop3News();         
                    LoadNewsCount();
                    gvNews.Visible = false;
                }
                catch (Exception ex)
                {
                    lblNewsCount.Text = "Error loading data: " + ex.Message;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                string title = txtTitle.Text.Trim();
                string content = txtContent.Text.Trim();
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
                    if (string.IsNullOrEmpty(hdnNewsId.Value))
                    {
                        cmd = new SqlCommand("addnews", conn);
                    }
                    else
                    {
                        cmd = new SqlCommand("updatenews", conn);
                        cmd.Parameters.AddWithValue("@newsid", hdnNewsId.Value);
                    }
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@title", title);
                    cmd.Parameters.AddWithValue("@content", content);
                    cmd.Parameters.AddWithValue("@image", imagePath);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                ClearForm();
                LoadTop3News();
                LoadNewsCount();
                LoadAllNews();
            }
            catch (Exception ex)
            {
                lblNewsCount.Text = "Error saving news: " + ex.Message;
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

        protected void gvNews_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(e.CommandArgument);
                if (e.CommandName == "EditNews")
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        SqlCommand cmd = new SqlCommand("SELECT * FROM latesttechnews WHERE newsid = @id", conn);
                        cmd.Parameters.AddWithValue("@id", id);
                        conn.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            txtTitle.Text = reader["title"].ToString();
                            txtContent.Text = reader["content"].ToString();
                            hdnNewsId.Value = reader["newsid"].ToString();
                        }
                    }
                }
                else if (e.CommandName == "DeleteNews")
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        SqlCommand cmd = new SqlCommand("deletenews", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@newsid", id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }

                    LoadTop3News();
                    LoadNewsCount();
                    LoadAllNews();
                }
            }
            catch (Exception ex)
            {
                lblNewsCount.Text = "Error processing news item: " + ex.Message;
            }
        }

        protected void btnRefreshNews_Click(object sender, EventArgs e)
        {
            try
            {
                gvNews.Visible = true;     
                LoadTop3News();
                LoadAllNews();
            }
            catch (Exception ex)
            {
                lblNewsCount.Text = "Error refreshing news: " + ex.Message;
            }
        }

        private void LoadTop3News()
        {
            try
            {
                topNewsCards.Controls.Clear();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT TOP 3 * FROM latesttechnews ORDER BY posteddate DESC", conn);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    while (reader.Read())
                    {
                        string title = reader["title"].ToString();
                        string content = reader["content"].ToString();
                        string image = reader["image"].ToString();
                        string cardHtml = $@"
                    <div class='col-12 col-sm-6 col-md-4 mb-3'>
                        <div class='card h-100'>
                            <img src='{image}' class='card-img-top' alt='News Image' style='height: 150px; object-fit: cover;' />
                            <div class='card-body'>
                                <h5 class='card-title'>{title}</h5>
                                <p class='card-text'>{(content.Length > 100 ? content.Substring(0, 100) + "..." : content)}</p>
                            </div>
                        </div>
                    </div>";
                        topNewsCards.Controls.Add(new LiteralControl(cardHtml));
                    }
                }
            }
            catch (Exception ex)
            {
                topNewsCards.Controls.Add(new LiteralControl("<p class='text-danger'>Error loading top news: " + ex.Message + "</p>"));
            }
        }

        private void LoadAllNews()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT * FROM latesttechnews ORDER BY posteddate DESC", conn);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvNews.DataSource = dt;
                    gvNews.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblNewsCount.Text = "Error loading all news: " + ex.Message;
            }
        }

        private void LoadNewsCount()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM latesttechnews", conn);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    lblNewsCount.Text = "Total News Articles: " + count;
                }
            }
            catch (Exception ex)
            {
                lblNewsCount.Text = "Error counting news: " + ex.Message;
            }
        }

        private void ClearForm()
        {
            txtTitle.Text = "";
            txtContent.Text = "";
            hdnNewsId.Value = "";
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
                lblNewsCount.Text = "Error during logout: " + ex.Message;
            }
        }
    }
}
