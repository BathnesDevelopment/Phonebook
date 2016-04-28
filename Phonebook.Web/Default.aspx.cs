using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                // We're expecting displayname, surname, givenname, jobtitle, manager, department, location, telephoneNumber, mobile, mail
                data.Add(new string[] { reader.GetString(0), reader.GetString(1), reader.GetString(2), reader.GetString(3), reader.GetString(4), reader.GetString(5), reader.GetString(6), reader.GetString(7), reader.GetString(8), reader.GetString(9) });
            }
        }
        sqlConnection.Close();

        return data;
    }
}