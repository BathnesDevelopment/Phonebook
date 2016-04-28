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
        SqlCommand cmd = new SqlCommand();
        SqlDataReader reader;
        cmd.CommandText = "select displayName, sn, givenName, IsNull(telephoneNumber,''), mobile, IsNull(mail, ''), title, physicalDeliveryOfficeName, IsNull(department,'') from phonebook";
        cmd.CommandType = CommandType.Text;
        cmd.Connection = sqlConnection;
        sqlConnection.Open();
        reader = cmd.ExecuteReader();

        var data = new List<string[]>();
        if (reader.HasRows)
        {
            while (reader.Read())
            {
                data.Add(new string[] { reader.GetString(0), reader.GetString(8), reader.GetString(3), reader.GetString(5) });
            }
        }
        sqlConnection.Close();

        return data;
    }
}