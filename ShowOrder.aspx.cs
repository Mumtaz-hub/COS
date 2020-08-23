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

public partial class Status : System.Web.UI.Page
{
    static int DeptCode;
    static string UserName;
    static string UserType;
    static string IsDeptEmail;

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
        UserName=Session["User_Name"].ToString();
        UserType = Session["User_Type"].ToString();
        IsDeptEmail = Session["IsDeptEmailId"].ToString();
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
        dummy.Columns.Add("UserEmailID");
        dummy.Columns.Add("HODEmailID");
        dummy.Columns.Add("ISDEPTEmailID");

        dummy.Rows.Add();
        gvItemRequest.DataSource = dummy;
        gvItemRequest.DataBind();
    }

    [WebMethod]
    public static string GetItemRequestStatus()
    {
        string query = @"SELECT Trans_Id,CONVERT(varchar,Date_Request,103) as 'Date_Request',No_Of_Person,CONVERT(varchar,Date_Event,103) as 'Date_Event',Purpose_Of_Meeting
                        ,T.DEBIT_Code,VENUE,Time_For_Teasnacks,Dept_Name,Prepared_By
                        ,Status,Status_HOD,Status_ISDept,U.Email_Id as 'UserEmailID',
                        (select Email_Id from User_Mast where User_Type='HOD' and Dept_Code=T.Dept_Code ) as 'HODEmailID',
                       (select Email_Id from User_Mast where User_Type='ISDEPT') as 'ISDEPTEmailID'
                        FROM Trans_Mast T
                        Left Join Department D on T.Dept_Code=D.Dept_Code
                        Left Join User_Mast U on T.Prepared_By=U.UserName
                        Where 1=1 ";

        if (UserType == "ISDept")
        {
            query += " and T.Status_HOD='Approved' and T.Status_ISDept='Pending'";
        }

        if (UserType == "USER")
        {
            query += " and T.Prepared_By='"+ UserName + "'";
        }

        if (UserType == "HOD")
        {
            query += " and T.Status_HOD='Pending' and t.Dept_Code=" + DeptCode;
        }

        DataSet ds = new DataSet();
        ds = DataAccessLayer.GetDataSet(query);
        return ds.GetXml();
        
    }

    [WebMethod]
    public static void UpdateStatus(int Code)
    {
        //WebService.MailSend();
        string constr = ConfigurationManager.ConnectionStrings["COSConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            string Query="";
            if (UserType.ToUpper() == "ISDEPT")
            {
                //Query = @"UPDATE Trans_Mast SET Status_ISDept = 'Approved',Status='Approved',Status_HOD='Approved' WHERE Trans_Id = @Trans_Id";
                Query = @"UPDATE Trans_Mast SET Status_ISDept = @Status_ISDept,Status=@Status,Status_HOD=@Status_HOD WHERE Trans_Id = @Trans_Id";
                SqlParameter[] parameters = new SqlParameter[4];
                parameters[0] = DataAccessLayer.AddParamater("@Status_ISDept", "Approved", System.Data.SqlDbType.VarChar, 50);
                parameters[1] = DataAccessLayer.AddParamater("@Status", "Approved", System.Data.SqlDbType.VarChar, 50);
                parameters[2] = DataAccessLayer.AddParamater("@Status_HOD", "Approved", System.Data.SqlDbType.VarChar, 50);
                parameters[3] = DataAccessLayer.AddParamater("@Trans_Id", Code, System.Data.SqlDbType.Int, 100);
                DataAccessLayer.ExecuteNonQuery(Query, parameters);
            }

            if (UserType.ToUpper() == "HOD")
            {
                //Query = @"UPDATE Trans_Mast SET Status_HOD = 'Approved' WHERE Trans_Id = @Trans_Id";
                Query = @"UPDATE Trans_Mast SET Status_HOD=@Status_HOD WHERE Trans_Id = @Trans_Id";
                SqlParameter[] parameters = new SqlParameter[2];
                parameters[0] = DataAccessLayer.AddParamater("@Status_HOD", "Approved", System.Data.SqlDbType.VarChar, 50);
                parameters[1] = DataAccessLayer.AddParamater("@Trans_Id", Code, System.Data.SqlDbType.Int, 100);
                DataAccessLayer.ExecuteNonQuery(Query, parameters);
            }

        }

        
    }
}