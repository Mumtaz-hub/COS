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

public partial class Admin_ItemRequestStatus : System.Web.UI.Page
{
    static int DeptCode;
    static string UserName;
    static string UserType;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.BindDummyRow();
            this.GetDeptCode();
        }
    }

    private void GetDeptCode()
    {
        UserName = Session["User_Name"].ToString();
        UserType = Session["User_Type"].ToString();

        DeptCode = DataAccessLayer.GetIdByQuery("select Dept_Code From User_Mast where Username='" + UserName + "'");

    }

    private void BindDummyRow()
    {
        DataTable dummy = new DataTable();
        dummy.Columns.Add("Trans_Id");
        dummy.Columns.Add("Date_Request");
        dummy.Columns.Add("No_Of_Person");
        dummy.Columns.Add("Date_Event");
        dummy.Columns.Add("Purpose_Of_Meeting");
        dummy.Columns.Add("DEBIT_Code");
        dummy.Columns.Add("VENUE");
        dummy.Columns.Add("Time_For_Teasnacks");
        dummy.Columns.Add("Dept_Name");
        dummy.Columns.Add("Prepared_By");
        dummy.Columns.Add("Status");
        dummy.Columns.Add("Status_HOD");
        dummy.Columns.Add("Status_ISDept");
        
        dummy.Rows.Add();
        gvItemRequest.DataSource = dummy;
        gvItemRequest.DataBind();
    }

    [WebMethod]
    public static string GetItemRequestStatus()
    {
        string query = @"SELECT Trans_Id,CONVERT(varchar,Date_Request,103) as 'Date_Request',No_Of_Person,CONVERT(varchar,Date_Event,103) as 'Date_Event',Purpose_Of_Meeting
                        ,T.DEBIT_Code,VENUE,Time_For_Teasnacks,Dept_Name,Prepared_By
                        ,Status,Status_HOD,Status_ISDept
                        FROM Trans_Mast T
                        Left Join Department D on T.Dept_Code=D.Dept_Code
                        Where 1=1 ";

        if (UserType.ToUpper() != "ISDEPT" && UserType.ToUpper() != "ADMIN")
        {
            query += " and T.Dept_Code=" + DeptCode;
        }

        if (UserType == "USER")
        {
            query += " and Prepared_By='"+ UserName + "'";
        }

        DataSet ds = new DataSet();
        ds = DataAccessLayer.GetDataSet(query);
        return ds.GetXml();

    }

}