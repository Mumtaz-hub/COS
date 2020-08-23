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

public partial class ShowFeedback : System.Web.UI.Page
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

}