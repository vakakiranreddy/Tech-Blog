using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace miniProject
{
    public partial class UserManagement : Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try
                {
                    LoadUsers();
                    LoadUserCount();
                }
                catch (Exception ex)
                {
                    lblUserCount.Text = "Error loading users: " + ex.Message;
                }
            }
        }

        private void LoadUsers()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("viewusers", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblUserCount.Text = "Error loading user list: " + ex.Message;
            }
        }

        private void LoadUserCount()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM users", conn);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    lblUserCount.Text = "Total Users: " + count;
                }
            }
            catch (Exception ex)
            {
                lblUserCount.Text = "Error getting user count: " + ex.Message;
            }
        }

        protected void gvUsers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(e.CommandArgument);
                if (e.CommandName == "DeleteUser")
                {
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        SqlCommand cmd = new SqlCommand("deleteuser", conn);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@userid", id);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }

                    LoadUsers();
                    LoadUserCount();
                }
            }
            catch (Exception ex)
            {
                lblUserCount.Text = "Error deleting user: " + ex.Message;
            }
        }

        protected void btnSearchUser_Click(object sender, EventArgs e)
        {
            try
            {
                string name = txtSearchUser.Text.Trim();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    SqlCommand cmd = new SqlCommand("searchuserbyname", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@name", name);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvUsers.DataSource = dt;
                    gvUsers.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblUserCount.Text = "Error searching user: " + ex.Message;
            }
        }

        protected void btnViewAllUsers_Click(object sender, EventArgs e)
        {
            try
            {
                txtSearchUser.Text = "";
                LoadUsers();
                LoadUserCount();
            }
            catch (Exception ex)
            {
                lblUserCount.Text = "Error refreshing users: " + ex.Message;
            }
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
                lblUserCount.Text = "Error during logout: " + ex.Message;
            }
        }
    }
}
