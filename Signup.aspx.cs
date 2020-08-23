using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Configuration;

public partial class Signup : System.Web.UI.Page
{
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    
    string constr = ConfigurationManager.ConnectionStrings["COSConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            SqlConnection cn = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand("Select Dept_Code,Dept_Name from Department", cn);
            cn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            ddlDepartment.DataTextField = "Dept_Name";    //must write datatextfield and value field
            ddlDepartment.DataValueField = "Dept_Code";
            ddlDepartment.DataSource = dr;
            ddlDepartment.DataBind();
        }
        
    }

    [WebMethod]
    public static string InsertMethod(string UserName, string Password, string EmailID, string EXTN_No, string CellNo, string Dept_Code, string User_Type)
    {
        string query = @"Insert into User_Mast values(@UserName,@Password,@Email_Id,@Extn_No,@CellNo,@Dept_Code,@User_Type)";
        SqlParameter[] parameters = new SqlParameter[7];
        parameters[0] = DataAccessLayer.AddParamater("@UserName", UserName, System.Data.SqlDbType.VarChar, 50);
        parameters[1] = DataAccessLayer.AddParamater("@Password", UserName, System.Data.SqlDbType.VarChar, 50);
        parameters[2] = DataAccessLayer.AddParamater("@Email_Id", EmailID, System.Data.SqlDbType.VarChar, 50);
        parameters[3] = DataAccessLayer.AddParamater("@Extn_No", EXTN_No, System.Data.SqlDbType.VarChar, 50);
        parameters[4] = DataAccessLayer.AddParamater("@CellNo", CellNo, System.Data.SqlDbType.VarChar, 50);
        parameters[5] = DataAccessLayer.AddParamater("@Dept_Code", Dept_Code, System.Data.SqlDbType.VarChar, 50);
        parameters[6] = DataAccessLayer.AddParamater("@User_Type", User_Type, System.Data.SqlDbType.VarChar, 50);
        DataAccessLayer.ExecuteNonQuery(query, parameters);
        return "True";

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
}