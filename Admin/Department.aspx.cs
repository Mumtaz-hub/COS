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

public partial class Admin_Department : System.Web.UI.Page
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
        dummy.Columns.Add("Dept_Code");
        dummy.Columns.Add("Dept_Name");
        dummy.Columns.Add("HOD");
        dummy.Columns.Add("DEBIT_CODE");
        dummy.Rows.Add();
        gvDept.DataSource = dummy;
        gvDept.DataBind();
    }

    [WebMethod]
    public static string GetDept()
    {
        string query = "SELECT Dept_Code, Dept_Name,HOD,DEBIT_CODE FROM Department";
        DataSet ds = new DataSet();
        ds = DataAccessLayer.GetDataSet(query);
        return ds.GetXml();
    }

    [WebMethod]
    public static int InsertDepartment(string Dept_Name, string HOD, string DEBIT_CODE)
    {
        
                string Query = "INSERT INTO Department VALUES(@Dept_Name, @HOD,@DEBIT_CODE) SELECT SCOPE_IDENTITY()";
                SqlParameter[] parameters = new SqlParameter[3];
                parameters[0] = DataAccessLayer.AddParamater("@Dept_Name", Dept_Name, System.Data.SqlDbType.VarChar, 50);
                parameters[1] = DataAccessLayer.AddParamater("@HOD", HOD, System.Data.SqlDbType.VarChar, 50);
                parameters[2] = DataAccessLayer.AddParamater("@DEBIT_CODE", DEBIT_CODE, System.Data.SqlDbType.VarChar, 50);
                
                int NewId = DataAccessLayer.ExecuteNonQuery(Query,parameters);
                return NewId;
    }

    [WebMethod]
    public static void UpdateDepartment(int DeptCode, string Dname, string HOD, string DEBIT_CODE)
    {
        string Query = "UPDATE Department SET Dept_Name = @Dept_Name, HOD = @HOD, DEBIT_CODE = @DEBIT_CODE WHERE Dept_Code = @Dept_Code";
        SqlParameter[] parameters = new SqlParameter[4];
        parameters[0] = DataAccessLayer.AddParamater("@Dept_Code", DeptCode, System.Data.SqlDbType.Int,100);
        parameters[1] = DataAccessLayer.AddParamater("@Dept_Name", Dname, System.Data.SqlDbType.VarChar, 50);
        parameters[2] = DataAccessLayer.AddParamater("@HOD", HOD, System.Data.SqlDbType.VarChar, 50);
        parameters[3] = DataAccessLayer.AddParamater("@DEBIT_CODE", DEBIT_CODE, System.Data.SqlDbType.VarChar, 50);

        DataAccessLayer.ExecuteNonQuery(Query, parameters);
        
    }

    [WebMethod]
    public static void DeleteDepartment(int DeptCode)
    {
        string Query = "DELETE FROM Department WHERE Dept_Code = @Dept_Code";
        SqlParameter[] parameters = new SqlParameter[1];
        parameters[0] = DataAccessLayer.AddParamater("@Dept_Code", DeptCode, System.Data.SqlDbType.Int, 100);
        DataAccessLayer.ExecuteNonQuery(Query, parameters);

    }

}