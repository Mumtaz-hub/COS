using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;

public partial class Admin_Feedback : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.BindDummyRow();
        }

    }

    private void BindDummyRow()
    {
        DataTable dummy = new DataTable();
        dummy.Columns.Add("Feedback_Code");
        dummy.Columns.Add("Feedback_Desc");
        dummy.Rows.Add();
        gvFeedback.DataSource = dummy;
        gvFeedback.DataBind();
    }

    [WebMethod]
    public static string GetFeedback()
    {
        string query = "SELECT Feedback_Code,Feedback_Desc FROM Feedback_Mast";

        DataSet ds = new DataSet();
        ds = DataAccessLayer.GetDataSet(query);
        return ds.GetXml();
    }

    [WebMethod]
    public static int InsertFeedback(string Feedback_Desc)
    {
        string Query = "INSERT INTO Feedback_Mast VALUES(@Feedback_Desc) SELECT SCOPE_IDENTITY()";
        SqlParameter[] parameters = new SqlParameter[1];
        parameters[0] = DataAccessLayer.AddParamater("@Feedback_Desc", Feedback_Desc, System.Data.SqlDbType.VarChar, 50);
        int NewId = DataAccessLayer.ExecuteNonQuery(Query, parameters);
        return NewId;
    }

    [WebMethod]
    public static void UpdateFeedback(int Code, string name)
    {
        string Query = "UPDATE Feedback_Mast SET Feedback_Desc = @Feedback_Desc WHERE Feedback_Code = @Feedback_Code";
        SqlParameter[] parameters = new SqlParameter[2];
        parameters[0] = DataAccessLayer.AddParamater("@Feedback_Code", Code, System.Data.SqlDbType.Int, 100);
        parameters[1] = DataAccessLayer.AddParamater("@Feedback_Desc", name, System.Data.SqlDbType.VarChar, 50);
        DataAccessLayer.ExecuteNonQuery(Query, parameters);
    }

    [WebMethod]
    public static void DeleteFeedback(int Code)
    {
        string Query = "DELETE FROM Feedback_Mast WHERE Feedback_Code = @Feedback_Code";
        SqlParameter[] parameters = new SqlParameter[1];
        parameters[0] = DataAccessLayer.AddParamater("@Feedback_Code", Code, System.Data.SqlDbType.Int, 100);
        DataAccessLayer.ExecuteNonQuery(Query, parameters);

        
    }
}