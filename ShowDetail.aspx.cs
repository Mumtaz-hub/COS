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
using System.Text;
using System.Web.UI.HtmlControls;

public partial class ShowDetail : System.Web.UI.Page
{
    static int TransID;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["Text"] != null)
        {
            TransID = int.Parse(Request.QueryString["Text"].ToString());

            BindControls();
            BindDepartment();

        }
    }
    private void BindDepartment()
    {
        string query = @"select *from Department";
        DataTable dt = new DataTable();
        dt = DataAccessLayer.GetDataTable(query);


        if (dt.Rows.Count > 0)
        {
            ddlDepartment.DataTextField = "Dept_Name";
            ddlDepartment.DataValueField = "Dept_Code";
            ddlDepartment.DataSource = dt;
            ddlDepartment.DataBind();

        }

    }
    private void BindControls()
    {
        string query = @"select t.Trans_Id,t.Order_For,CONVERT(varchar,t.Date_Request,103) as 'Date_Request',t.No_Of_Person
                        ,CONVERT(varchar,t.Date_Event,103) as 'Date_Event',t.Purpose_Of_Meeting
                        ,t.DEBIT_Code,t.VENUE,t.Time_For_Teasnacks,t.Prepared_By,t.dept_code,d.dept_name,u.Extn_No,u.CellNo 
                         from Trans_Mast t 
                         inner join Department d on t.dept_code=d.dept_code 
                         inner Join User_Mast u on t.Prepared_By=u.UserName
                         where t.Trans_Id=" + TransID;

        SqlCommand cmd = new SqlCommand(query);

        DataTable dt = new DataTable();
        dt = DataAccessLayer.GetDataTable(query);

        if (dt.Rows.Count > 0)
        {
            txtDateOfRequistion.Text = dt.Rows[0]["Date_Request"].ToString();
            ddlSub.Text = dt.Rows[0]["Order_For"].ToString();
            txtFor.Text = dt.Rows[0]["No_Of_Person"].ToString();
            txtDateOfEvent.Text = dt.Rows[0]["Date_Event"].ToString();
            txtPurposeMeeting.Text = dt.Rows[0]["Purpose_Of_Meeting"].ToString();
            txtDebitCode.Text = dt.Rows[0]["DEBIT_Code"].ToString();
            txtVenue.Text = dt.Rows[0]["VENUE"].ToString();
            if (dt.Rows[0]["VENUE"].ToString().ToUpper() == "MORNING")
            {
                RdMtea.Checked = true;
            }
            else
            {
                RdEtea.Checked = true;
            }
            ddlDepartment.SelectedValue = dt.Rows[0]["Dept_Code"].ToString();
            txtPreparedBy.Text = dt.Rows[0]["Prepared_By"].ToString();
            txtExtno.Text = dt.Rows[0]["Extn_No"].ToString();
            txtCellno.Text = dt.Rows[0]["CellNo"].ToString();
        }

    }

    [WebMethod]
    public static string GetItemLunchDetails()
    {

        string query = @"Select i.Item_Rate as Rate,i.Item_Name as 'Name',T.Item_Qty as 'QTY'
                            from Item_Details i 
                            left join Item_GrpMast p on  i.Grpcode=p.grpcode
                            left join Trans_Details t on i.Item_Code=t.Item_Code and t.trans_id=" + TransID + @"
                            where p.Category_Id in (select Category_Id from Item_Category where Category_Name='Lunch')
                            order by p.Grpcode";


        DataSet ds = new DataSet();
        ds = DataAccessLayer.GetDataSet(query);

        DataTable dt = new DataTable();
        for (int i = 0; i <= ds.Tables[0].Rows.Count; i++)
        {
            dt.Columns.Add();
        }
        for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
        {
            dt.Rows.Add();
            dt.Rows[i][0] = ds.Tables[0].Columns[i].ColumnName;
        }
        for (int i = 0; i < ds.Tables[0].Columns.Count; i++)
        {
            for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
            {
                dt.Rows[i][j + 1] = ds.Tables[0].Rows[j][i];
            }
        }


        //Building an HTML string.
        StringBuilder html = new StringBuilder();

        //Table start.
        html.Append("<table id='tblmain' border = '1' width=" + "640px" + " runat=" + "server" + ">");

        DataTable dtHeader = new DataTable();
        query = @"select g.Grpcode,g.GrpName,g.Category_Id,COUNT(*) as Cols from Item_GrpMast g
                inner join Item_Details d on g.Grpcode=d.Grpcode
                where g.Category_Id In ( select Category_Id from Item_Category where Category_Name='Lunch')
                group by g.Grpcode,g.GrpName,g.Category_Id
                union
                Select 0 as GrpCode, 'MENU' as 'GrpName',0 as 'Category_Id',1 as 'Cols'
                order by g.Grpcode";

        dtHeader = DataAccessLayer.GetDataTable(query);

        for (int i = 0; i < dtHeader.Rows.Count; i++)
        {
            html.Append("<th style=" + "width:60px;" + " align=" + "center" + " colspan=" + int.Parse(dtHeader.Rows[i]["Cols"].ToString()) + ">");
            if (i == 0)
            {
                html.Append(dtHeader.Rows[i]["GrpName"].ToString());
            }
            else
            {
                html.Append("<a href=" + "ShowItemGroupDetails.aspx" + ">" + dtHeader.Rows[i]["GrpName"].ToString() + "</a>");
            }
            html.Append("</th>");
        }

        //Building the Data rows.
        for (int row = 0; row < dt.Rows.Count; row++)
        {
            html.Append("<tr>");


            if (row == dt.Rows.Count - 1)
            {
                //For Last row set textbox
                for (int Col = 0; Col < dt.Columns.Count; Col++)
                {

                    if (Col == 0)
                    {
                        html.Append("<td style=" + "width:60px;" + " >Qty");
                        html.Append("</td>");
                    }
                    else
                    {

                        html.Append("<td style=" + "width:60px;" + "><INPUT type=text Name=" + dt.Rows[1][Col].ToString() + " disabled=" + "disabled" + "   value=" + ((dt.Rows[row][Col].ToString() == "") ? "0" : dt.Rows[row][Col].ToString()) + " style=" + "width:60px; text-align:center;" + " />");
                        html.Append("</td>");

                    }
                }

            }
            else
            {
                for (int Col = 0; Col < dt.Columns.Count; Col++)
                {

                    html.Append("<td style=" + "width:60px;" + " align=" + "center" + " >");
                    html.Append(dt.Rows[row][Col].ToString());
                    html.Append("</td>");
                }

            }

            html.Append("</tr>");
        }

        html.Append("</tr>");

        html.Append("</table>");

        return (html.ToString());
    }


    [WebMethod]
    public static string GetItemSnacksDetails()
    {

        string query = @"select Item_Name,case i.Item_Rate when 0.10 then 'MRP' else cast(i.Item_Rate as varchar(10))  end as 'Item_Rate' ,
							T.Item_Qty as 'QTY'
                            from Item_Details i
                            inner join Item_GrpMast g on i.Grpcode=g.Grpcode
                            inner join Item_Category c on g.Category_Id=c.Category_Id
                            left join Trans_Details t on i.Item_Code=t.Item_Code and t.trans_id=" + TransID + @"
                            where  c.Category_Name='Tea-Snack'
                            order by i.Item_Code";

        DataTable dt = new DataTable();
        dt = DataAccessLayer.GetDataTable(query);


        //Building an HTML string.
        StringBuilder html = new StringBuilder();

        //Table start.
        html.Append("<table id='tblSnacks' border = '1' width=" + "440px" + " runat=" + "server" + ">");

        for (int i = 0; i < dt.Columns.Count; i++)
        {
            html.Append("<th style=" + "width:60px;" + " align=" + "center" + ">");
            html.Append(dt.Columns[i].ColumnName.ToString());
            html.Append("</th>");
        }

        //Building the Data rows.
        foreach (DataRow row in dt.Rows)
        {
            html.Append("<tr>");

            foreach (DataColumn column in dt.Columns)
            {
                if (column.ColumnName.ToUpper() == "QTY")
                {
                    html.Append("<td style=" + "width:60px;" + "><INPUT type=text Name=" + row["Item_Name"].ToString() + " disabled=" + "disabled" + "   value=" + ((row[column.ColumnName].ToString() == "") ? "0" : row[column.ColumnName].ToString()) + " style=" + "width:60px; text-align:center;" + " />");
                    html.Append("</td>");
                }
                else if (column.ColumnName.ToUpper() == "ITEM_NAME")
                {
                    html.Append("<td style=" + "width:150px;" + " align=" + "left" + " >");
                    html.Append(row[column.ColumnName]);
                    html.Append("</td>");
                }
                else
                {

                    html.Append("<td style=" + "width:60px;" + " align=" + "left" + " >");
                    html.Append(row[column.ColumnName]);
                    html.Append("</td>");
                }
            }

            html.Append("</tr>");
        }


        html.Append("</table>");

        return (html.ToString());
    }
}
            
        
    
