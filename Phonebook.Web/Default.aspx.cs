using System;
using System.Collections.Generic;
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
        //SqlConnection sqlConnection = new SqlConnection("");
        //SqlCommand cmd = new SqlCommand();
        //SqlDataReader reader;
        //cmd.CommandText = "SELECT * FROM Customers";
        //cmd.CommandType = CommandType.Text;
        //cmd.Connection = sqlConnection;
        //sqlConnection.Open();
        //reader = cmd.ExecuteReader();
        //sqlConnection.Close();

        var data = new List<string[]>();
        data.Add(new string[] { "Dave", "IT", "7356" });
        return data;
        //var serializer = new JavaScriptSerializer();
        //return serializer.Serialize(data);
    }
}