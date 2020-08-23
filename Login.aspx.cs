using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogIn_Click(object sender, EventArgs e)
    {
        string query = @"select User_Type,Email_Id 
                        ,(select Email_Id from User_Mast where User_Type='HOD' and Dept_Code in
                        (select Dept_Code from User_Mast where Username='" + txtUserName.Text + @"'))as 'HodEmailId',
                        (select Email_Id from User_Mast where User_Type='ISDEPT' ) as 'IsDeptEmailId'
                        From User_Mast 
                        where Username='" + txtUserName.Text + "' and Password='" + txtPassword.Text + "'";
        DataTable dt= new DataTable();
        dt = DataAccessLayer.GetDataTable(query);

        if (dt.Rows.Count > 0)
        {
            string obj = Convert.ToString(dt.Rows[0][0]);
            Session["User_Type"] = obj;
            Session["User_Name"] = txtUserName.Text;
            Session["UserEmailId"] = Convert.ToString(dt.Rows[0][1]);
            Session["HODEmailId"] = Convert.ToString(dt.Rows[0][2]);
            Session["IsDeptEmailId"] = Convert.ToString(dt.Rows[0][3]);

            if (obj.ToUpper() == "ADMIN")
            {
                Response.Redirect("~/Admin/Default.aspx");
            }
            else if (obj.ToUpper() == "HOD" || obj.ToUpper() == "ISDEPT")
            {
                Response.Redirect("Default.aspx");
            }
            else if (obj.ToUpper() == "USER")
            {
                Response.Redirect("Default.aspx");
            }
        }
        else
        {
            lblMessage.Text = "Invalid UserName or Password";
            this.lblMessage.ForeColor = Color.Red;
        }
    }
    
    protected void btnSignup_Click(object sender, EventArgs e)
    {
        Response.Redirect("Signup.aspx");
    }
}