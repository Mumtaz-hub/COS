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

public partial class Admin_ItemRate : System.Web.UI.Page
{
    static int IntGcode;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.BindDummyRowForItemGroup();
            this.BindDummyRowForItemDetails();
        }
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
    
    private void BindDummyRowForItemDetails()
    {
        DataTable dummy = new DataTable();
        dummy.Columns.Add("Item_Code");
        dummy.Columns.Add("Item_Name");
        dummy.Columns.Add("Item_Rate");
        dummy.Rows.Add();
        gvItemDetails.DataSource = dummy;
        gvItemDetails.DataBind();
    }

    [WebMethod]
    public static string GetItemGroup()
    {
        string query = "SELECT GrpCode, GrpName FROM Item_GrpMast Order By GrpCode";
        DataSet ds = new DataSet();
        ds = DataAccessLayer.GetDataSet(query);
        return ds.GetXml();
    }

    [WebMethod]
    public static string GetItemByGrpCode(string Code)
    {
        IntGcode = int.Parse(Code);
        if (Code == "0")
        {
            string query = "SELECT Top 1 GrpCode FROM Item_Details Order By GrpCode";
            IntGcode = DataAccessLayer.GetIdByQuery(query);
        }

        string query1 = "SELECT Item_Code, Item_Name,Item_Rate FROM Item_Details where GrpCode=" + Convert.ToInt32(IntGcode) + " Order By Item_Code";
        DataSet ds = new DataSet();
        ds = DataAccessLayer.GetDataSet(query1);
        return ds.GetXml();
    }

    [WebMethod]
    public static int InsertItem(string ItemName,decimal ItemRate)
    {
        string Query = "INSERT INTO Item_Details VALUES(@Item_Name,@Item_Rate,@GrpCode) SELECT SCOPE_IDENTITY()";
        SqlParameter[] parameters = new SqlParameter[3];
        parameters[0] = DataAccessLayer.AddParamater("@Item_Name", ItemName, System.Data.SqlDbType.VarChar, 50);
        parameters[1] = DataAccessLayer.AddParamater("@Item_Rate", ItemRate, System.Data.SqlDbType.Decimal, 100);
        parameters[2] = DataAccessLayer.AddParamater("@GrpCode", IntGcode, System.Data.SqlDbType.Int, 100);
        int NewId = DataAccessLayer.ExecuteNonQuery(Query, parameters);
        return NewId;
    }

    [WebMethod]
    public static void UpdateItem(int ItemCode, string ItemName,decimal ItemRate)
    {
        string Query = "UPDATE Item_Details SET Item_Name = @Item_Name,Item_Rate=@Item_Rate WHERE Item_Code = @Item_Code";
        SqlParameter[] parameters = new SqlParameter[3];
        parameters[0] = DataAccessLayer.AddParamater("@Item_Code", ItemCode, System.Data.SqlDbType.Int, 100);
        parameters[1] = DataAccessLayer.AddParamater("@Item_Name", ItemName, System.Data.SqlDbType.VarChar, 50);
        parameters[2] = DataAccessLayer.AddParamater("@Item_Rate", ItemRate, System.Data.SqlDbType.Decimal, 100);
        DataAccessLayer.ExecuteNonQuery(Query, parameters);
    }

    [WebMethod]
    public static void DeleteItem(int ItemCode)
    {
        string Query = "DELETE FROM Item_Details WHERE Item_Code = @Item_Code";
        SqlParameter[] parameters = new SqlParameter[1];
        parameters[0] = DataAccessLayer.AddParamater("@Item_Code", ItemCode, System.Data.SqlDbType.Int, 100);
        DataAccessLayer.ExecuteNonQuery(Query, parameters);
    }
}