using System;
using System.IO;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Services;
using System.Web.Services;
using System.Net;
using System.Net.Mail;


public partial class _Default : System.Web.UI.Page
{
    

    protected void Page_Load(object sender, EventArgs e)
    { }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<string[]> GetDirectory()
    {
        // SQL Connection code pilfered from MSDN https://msdn.microsoft.com/en-us/library/fksx3b4f.aspx
        SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("sp_GetPhoneBookData", sqlConnection);
        SqlDataReader reader;
        cmd.CommandType = CommandType.StoredProcedure;
        sqlConnection.Open();
        reader = cmd.ExecuteReader();

        var data = new List<string[]>();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                // We're expecting displayname, (ignore)surname, (ignore)givenname, jobtitle, manager, department, location, telephoneNumber, groupNumber, mobile, mail
                data.Add(new string[] { reader.GetString(0), reader.GetString(3), reader.GetString(4), reader.GetString(5), reader.GetString(6), reader.GetString(7), reader.GetString(8), reader.GetString(9), reader.GetString(10) });
            }
        }
        sqlConnection.Close();

        return data;
    }


    protected void SendEmail(object sender, EventArgs e)
    {
        using (MailMessage mm = new MailMessage("phonebook@bathnes.gov.uk", "james_waldron@bathnes.gov.uk"))
        {
            mm.Subject = "Phonebook Update Request";
            mm.Body = "Name: " + txtName.Text + "\n";
            mm.Body += "Job Title: " + txtJobTitle.Text + "\n";
            mm.Body += "Location: " + txtLocation.Text + "\n";
            mm.Body += "Telephone: " + txtTelephone.Text + "\n";
            mm.Body += "Dept Number: " + txtGroupNumber.Text + "\n";
            mm.Body += "Comments: " + txtComments.Text + "\n";
            mm.Body += "-----------" + "\n";
            mm.Body += "Submitted At: " + DateTime.Now + "\n";
            mm.Body += "Submitter Username: " + Environment.UserName + "\n";
            mm.Body += "Submitter Machine: " + Environment.MachineName;

            mm.IsBodyHtml = false;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "banes-smtp1.bathnes.gov.uk";
            //smtp.EnableSsl = true;
            //NetworkCredential NetworkCred = new NetworkCredential(txtEmail.Text, txtPassword.Text);
            smtp.UseDefaultCredentials = true;
            //smtp.Credentials = NetworkCred;
            smtp.Port = 25;
            smtp.Send(mm);
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Request Sent');", true);
        }
    }


}