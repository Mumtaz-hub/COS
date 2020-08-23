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

public partial class Admin_Item_Category : System.Web.UI.Page
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
        dummy.Columns.Add("Category_Id");
        dummy.Columns.Add("Category_Name");
        dummy.Rows.Add();
        gvItemCategory.DataSource = dummy;
        gvItemCategory.DataBind();
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
    public static int InsertCategory(string Category_Name)
    {
        string Query = "INSERT INTO Item_Category VALUES(@Category_Name) SELECT SCOPE_IDENTITY()";
        SqlParameter[] parameters = new SqlParameter[1];
        parameters[0] = DataAccessLayer.AddParamater("@Category_Name", Category_Name, System.Data.SqlDbType.VarChar, 50);
        int NewId = DataAccessLayer.ExecuteNonQuery(Query, parameters);
        return NewId;
        
    }

    [WebMethod]
    public static void UpdateCategory(int CCode, string Cname)
    {
        string Query = "UPDATE Item_Category SET Category_Name = @Category_Name WHERE Category_Id = @Category_Id";
        SqlParameter[] parameters = new SqlParameter[2];
        parameters[0] = DataAccessLayer.AddParamater("@Category_Id", CCode, System.Data.SqlDbType.Int, 100);
        parameters[1] = DataAccessLayer.AddParamater("@Category_Name", Cname, System.Data.SqlDbType.VarChar, 50);
        DataAccessLayer.ExecuteNonQuery(Query, parameters);
    }

    [WebMethod]
    public static void DeleteCategory(int Code)
    {
        string Query = "DELETE FROM Item_Category WHERE Category_Id = @Category_Id";
        SqlParameter[] parameters = new SqlParameter[1];
        parameters[0] = DataAccessLayer.AddParamater("@Category_Id", Code, System.Data.SqlDbType.Int, 100);
        DataAccessLayer.ExecuteNonQuery(Query, parameters);
    }
}