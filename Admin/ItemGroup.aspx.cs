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

public partial class Admin_ItemGroup : System.Web.UI.Page
{
    static int IntGcode;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.BindDummyRowForCategory();
            this.BindDummyRowForItemGroup();
        }
    }

    private void BindDummyRowForCategory()
    {
        DataTable dummy = new DataTable();
        dummy.Columns.Add("Category_Id");
        dummy.Columns.Add("Category_Name");
        dummy.Rows.Add();
        gvItemCategory.DataSource = dummy;
        gvItemCategory.DataBind();
    }

    private void BindDummyRowForItemGroup()
    {
        DataTable dummy = new DataTable();
        dummy.Columns.Add("GrpCode");
        dummy.Columns.Add("GrpName");
        dummy.Rows.Add();
        gvItemGroup.DataSource = dummy;
        gvItemGroup.DataBind();
    }


    [WebMethod]
    public static string GetItemCategory()
    {
        string query = "SELECT Category_Id, Category_Name FROM Item_Category";
        DataSet ds = new DataSet();
        ds = DataAccessLayer.GetDataSet(query);
        return ds.GetXml();
    }

    [WebMethod]
    public static string GetItemByCategoryId(string CCode)
    {

        IntGcode = int.Parse(CCode);
        string query = "SELECT GrpCode, GrpName FROM Item_GrpMast where Category_Id="+ Convert.ToInt32(CCode);
        DataSet ds = new DataSet();
        ds = DataAccessLayer.GetDataSet(query);
        return ds.GetXml();
    }

    [WebMethod]
    public static int InsertGroup(string GrpName)
    {
        string Query = "INSERT INTO Item_GrpMast VALUES(@GrpName,@Category_Id) SELECT SCOPE_IDENTITY()";
        SqlParameter[] parameters = new SqlParameter[2];
        parameters[0] = DataAccessLayer.AddParamater("@GrpName", GrpName, System.Data.SqlDbType.VarChar, 50);
        parameters[1] = DataAccessLayer.AddParamater("@Category_Id", IntGcode, System.Data.SqlDbType.Int, 100);
        int NewId = DataAccessLayer.ExecuteNonQuery(Query, parameters);
        return NewId;
    }

    [WebMethod]
    public static void UpdateGroup(int GrpCode, string GrpName)
    {
        string Query = "UPDATE Item_GrpMast SET GrpName = @GrpName WHERE GrpCode = @GrpCode";

        SqlParameter[] parameters = new SqlParameter[2];
        parameters[0] = DataAccessLayer.AddParamater("@GrpCode", GrpCode, System.Data.SqlDbType.Int, 100);
        parameters[1] = DataAccessLayer.AddParamater("@GrpName", GrpName, System.Data.SqlDbType.VarChar, 50);
        DataAccessLayer.ExecuteNonQuery(Query, parameters);
    }

    [WebMethod]
    public static void DeleteGroup(int GrpCode)
    {
        string Query = "DELETE FROM Item_GrpMast WHERE GrpCode = @GrpCode";
        SqlParameter[] parameters = new SqlParameter[1];
        parameters[0] = DataAccessLayer.AddParamater("@GrpCode", GrpCode, System.Data.SqlDbType.Int, 100);
        DataAccessLayer.ExecuteNonQuery(Query, parameters);
    }
}