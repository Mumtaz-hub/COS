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

public partial class AddFeedback : System.Web.UI.Page
{
    static int TransId;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["Text"] != null)
            {
                TransId = int.Parse(Request.QueryString["Text"].ToString());
            }
            this.BindDummyRow();
        }
    }

    private void BindDummyRow()
    {
        DataTable dummy = new DataTable();
        dummy.Columns.Add("Feedback_Code");
        dummy.Columns.Add("Feedback_Desc");
        dummy.Columns.Add("Feedback_Status");
        dummy.Rows.Add();
        gvFeedbackStatus.DataSource = dummy;
        gvFeedbackStatus.DataBind();
    }

    [WebMethod]
    public static string GetFeedback()
    {
        string query = @"select f.*,t.Feedback_Status from Feedback_Mast f
                            left join Trans_Feedback t on t.Feedback_Code=f.Feedback_Code and Trans_Id=" + TransId;
        DataSet ds = new DataSet();
        ds = DataAccessLayer.GetDataSet(query);
        return ds.GetXml();
    }

    [WebMethod]
    public static void UpdateFeedback(int Code, string Status)
    {
        string query = @"select *from Trans_Feedback Where Feedback_Code=" + Code + " and Trans_Id=" + TransId;
        DataTable dt = new DataTable();
        dt = DataAccessLayer.GetDataTable(query);

        if (dt.Rows.Count > 0)
        {
            string Query = "UPDATE Trans_Feedback SET Feedback_Status = @feedback_Status WHERE Feedback_Code = @Feedback_Code and Trans_Id=" + TransId;
            SqlParameter[] parameters = new SqlParameter[2];
            parameters[0] = DataAccessLayer.AddParamater("@Feedback_Code", Code, System.Data.SqlDbType.Int, 100);
            parameters[1] = DataAccessLayer.AddParamater("@feedback_Status", Status, System.Data.SqlDbType.VarChar, 50);
            DataAccessLayer.ExecuteNonQuery(Query, parameters);
        }
        else
        {
            string Query = "Insert into Trans_Feedback values(@Trans_Id,@Feedback_Code,@Feedback_Status)";
            SqlParameter[] parameters = new SqlParameter[3];
            parameters[0] = DataAccessLayer.AddParamater("@Trans_Id", TransId, System.Data.SqlDbType.Int, 100);
            parameters[1] = DataAccessLayer.AddParamater("@Feedback_Code", Code, System.Data.SqlDbType.Int, 100);
            parameters[2] = DataAccessLayer.AddParamater("@feedback_Status", Status, System.Data.SqlDbType.VarChar, 50);
            DataAccessLayer.ExecuteNonQuery(Query, parameters);

        }

    }
}