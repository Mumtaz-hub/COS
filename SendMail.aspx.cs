using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;
using System.Net.Mail;
using System.Data;

public partial class SendMail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Text"] != null)
        {

            int TransId = int.Parse(Request.QueryString["Text"].ToString());

            string User_Type = Session["User_Type"].ToString();
            string UserName = Session["User_Name"].ToString();

            if (UserName.ToUpper() == "I&S-DEPT")
            {
                this.ClientScript.RegisterClientScriptBlock(this.GetType(), "Close", "window.close()", true);
            }

            if (User_Type.ToUpper() =="USER")
            {
                txtTo.Text = Session["HODEmailId"].ToString();
                txtEmail.Text = Session["UserEmailId"].ToString();
            }

            if (User_Type.ToUpper() == "HOD")
            {
                txtTo.Text = Session["IsDeptEmailId"].ToString();
                txtEmail.Text = Session["HODEmailId"].ToString();
            }

            string query = @"select t.Trans_Id,t.Order_For,CONVERT(varchar,t.Date_Request,103) as 'Date_Request',t.No_Of_Person
                        ,CONVERT(varchar,t.Date_Event,103) as 'Date_Event',t.Purpose_Of_Meeting
                        ,t.DEBIT_Code,t.VENUE,t.Time_For_Teasnacks,t.Prepared_By,t.dept_code,d.dept_name,u.Extn_No,u.CellNo 
                         from Trans_Mast t 
                         inner join Department d on t.dept_code=d.dept_code 
                         inner Join User_Mast u on t.Prepared_By=u.UserName
                         where t.Trans_Id=" + TransId;

            DataTable dt = new DataTable();
            dt = DataAccessLayer.GetDataTable(query);

            if (dt.Rows.Count > 0)
            {
                string strBody = @"Dear Sir,"+"\n\n" + @" Here,This E-mail requesting for Canteen Order of " + dt.Rows[0]["Order_For"].ToString() +
                                @" For " + dt.Rows[0]["No_Of_Person"].ToString() + @" Person." + "\n" + @" The event is organized on " + dt.Rows[0]["Date_Event"].ToString() +
                                @" date." + "\n" + @" This request made By " + dt.Rows[0]["Prepared_By"].ToString() + @"  " + "\n" + @" ExtnNo :" + dt.Rows[0]["Extn_No"].ToString() +
                                @" Cell No :" + dt.Rows[0]["CellNo"].ToString() + @" " + "\n" + @" Please, check details " + "\n\n" + @" Thank You," + "\n\n" + @" Your's Sincerly " + "\n" + @" " + Session["User_Name"].ToString();

                txtBody.Text = strBody;
                txtSubject.Text = "New Canteen Order Request By " + Session["User_Name"].ToString();
                txtPassword.Focus();
            }
        }
    }
    protected void SendEmail(object sender, EventArgs e)
    {
        string to = txtTo.Text;
        string from = txtEmail.Text;
        string subject = txtSubject.Text;
        string body = txtBody.Text;
        using (MailMessage mm = new MailMessage(txtEmail.Text, txtTo.Text))
        {
            mm.Subject = subject;
            mm.Body = body;
            mm.IsBodyHtml = false;
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.EnableSsl = true;
            smtp.UseDefaultCredentials = true;
            NetworkCredential NetworkCred = new NetworkCredential(txtEmail.Text, txtPassword.Text);
            smtp.Credentials = NetworkCred;
            smtp.Port = 587;
            smtp.Send(mm);
            ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Email sent.');", true);
        }
    }
    
}