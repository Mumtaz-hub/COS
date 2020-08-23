using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;

public partial class master_User : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["User_Type"].ToString() == "HOD" || Session["User_Type"].ToString() == "ISDEPT")
            {
                SiteMapDataSource1.SiteMapProvider = "HODSiteMap";
                
            }
            else if (Session["User_Type"].ToString() == "User")
            {
                SiteMapDataSource1.SiteMapProvider = "UserSiteMap";
            }

            lblUser.Text = Session["User_Name"].ToString();
            BindTable();
        }

    }

    private void BindTable()
    {
        //Building an HTML string.
        StringBuilder html = new StringBuilder();

        //Table start.
        html.Append("<table id='tblmain' border = '0'>");

        DataTable dtHeader = new DataTable();
        string query = @"SELECT 'REGULAR THALI' AS COLNAME
                            UNION 
                            SELECT 'SPECIAL' AS COLNAME
                            UNION 
                            SELECT 'VIP' AS COLNAME";

        dtHeader = DataAccessLayer.GetDataTable(query);

        for (int i = 0; i < dtHeader.Rows.Count; i++)
        {
            html.Append("<th>");
            html.Append(dtHeader.Rows[i]["COLNAME"].ToString());
            html.Append("</th>");
        }


        DataTable dtStandard = new DataTable();
        query = @"SELECT GRP_DETAILS  AS 'REGULAR THALI' FROM ITEM_GRPDETAILS WHERE GRPCODE=1";
        dtStandard = DataAccessLayer.GetDataTable(query);

        DataTable dtSpecial = new DataTable();
        query = @"SELECT GRP_DETAILS  AS 'SPECIAL' FROM ITEM_GRPDETAILS WHERE GRPCODE=2";
        dtSpecial = DataAccessLayer.GetDataTable(query);

        DataTable dtVIP = new DataTable();
        query = @"SELECT GRP_DETAILS  AS 'VIP' FROM ITEM_GRPDETAILS WHERE GRPCODE=3";
        dtVIP = DataAccessLayer.GetDataTable(query);

        int maxcount = dtStandard.Rows.Count - 1;

        if (dtSpecial.Rows.Count > maxcount)
            maxcount = dtSpecial.Rows.Count;

        if (dtVIP.Rows.Count > maxcount)
            maxcount = dtVIP.Rows.Count;


        for (int irow = 0; irow < maxcount; irow++)
        {
            html.Append("<tr>");

            html.Append("<td>");
            if (irow <= dtStandard.Rows.Count - 1)
            {
                html.Append(dtStandard.Rows[irow]["REGULAR THALI"]);
            }
            else
            {
                html.Append("");
            }

            html.Append("</td>");
            html.Append("<td>");
            if (irow <= dtSpecial.Rows.Count - 1)
            {
                html.Append(dtSpecial.Rows[irow]["SPECIAL"]);
            }
            else
            {
                html.Append("");
            }
            html.Append("</td>");

            html.Append("<td>");
            if (irow <= dtVIP.Rows.Count - 1)
            {
                html.Append(dtVIP.Rows[irow]["VIP"]);
            }
            else
            {
                html.Append("");
            }

            html.Append("</td>");

            html.Append("</tr>");
        }

        html.Append("</table>");

        //Append the HTML string to Placeholder.
        Control myControl1 = FindControl("Footer");
        if (myControl1 != null)
        {
            //myControl1.Controls.Add(new Literal { Text = html.ToString() });
        }

        //form1.Controls.Add(new Literal { Text = html.ToString() });
    }

    protected void ImgBtnLogout_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Login.aspx");
    }
}
