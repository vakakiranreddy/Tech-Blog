using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI.WebControls;

namespace miniProject
{
    public partial class EmailNotification : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadNotifications();
                UpdateNotificationCount();
            }
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            string subject = txtSubject.Text.Trim();
            string body = txtBody.Text.Trim();

            if (subject == "" || body == "")
            {
                lblStatus.Text = "Subject and body are required!";
                lblStatus.CssClass = "text-danger";
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    SqlCommand getUsersCmd = new SqlCommand("SELECT Email FROM users", conn);
                    SqlDataReader reader = getUsersCmd.ExecuteReader();
                    while (reader.Read())
                    {
                        SendMail(reader["Email"].ToString(), subject, body);
                    }
                    reader.Close();

                    // Store in notification table
                    SqlCommand cmd = new SqlCommand("sp_addnotification", conn);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@subject", subject);
                    cmd.Parameters.AddWithValue("@message", body);
                    cmd.ExecuteNonQuery();
                }

                lblStatus.Text = "Email sent successfully and notification stored!";
                lblStatus.CssClass = "text-success";
                txtSubject.Text = "";
                txtBody.Text = "";
                LoadNotifications();
                UpdateNotificationCount();
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Error: " + ex.Message;
                lblStatus.CssClass = "text-danger";
            }
        }

        private void SendMail(string toEmail, string subject, string body)
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("kiranreddyvaka4@gmail.com");
            mail.To.Add(toEmail);
            mail.Subject = subject;
            mail.Body = body;

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.EnableSsl = true;
            smtp.Credentials = new NetworkCredential("kiranreddyvaka4@gmail.com", "yavl insa iahf tavz");
            smtp.Send(mail);
        }

        private void LoadNotifications()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("sp_getallnotifications", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptNotifications.DataSource = dt;
                rptNotifications.DataBind();
            }
        }

        protected void DeleteNotification_Command(object sender, CommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("sp_deletenotification", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@notificationid", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            LoadNotifications();
            UpdateNotificationCount();
        }

        private void UpdateNotificationCount()
        {
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string subject = txtSearchSubject.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand("sp_getnotificationbysubject", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@subject", subject);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                rptNotifications.DataSource = dt;
                rptNotifications.DataBind();
            }
        }

        protected void btnViewAll_Click(object sender, EventArgs e)
        {
            LoadNotifications();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
