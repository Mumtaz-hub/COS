using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Net.Mail;
using System.Net;
using System.IO;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    [WebMethod]
    public static int MailSend(string To, string Message)
    {
        

        MailMessage Msg = new MailMessage();
        Msg.Subject = "Send Mail Using WebServices";
        Msg.Body = Message;
        Msg.IsBodyHtml = true;
        Msg.From = new MailAddress("hmduser111@gmail.com"); // Sender e-mail address.
        Msg.To.Add(To);// Recipient e-mail address.

        SmtpClient smtp = new SmtpClient();
        smtp.Host = "smtp.gmail.com";
        smtp.EnableSsl = true;

        NetworkCredential NetworkCred = new NetworkCredential("hmduser111@gmail.com", "hmduser111.com");
        smtp.UseDefaultCredentials = true;
        smtp.Credentials = NetworkCred;
        smtp.Timeout = 900000;
        smtp.Port = 587;
        smtp.Send(Msg);
        //ClientScript.RegisterStartupScript(GetType(), "alert", "alert('Email sent.');", true);

        //Msg.From = new MailAddress("hmduser111@gmail.com"); // Sender e-mail address.
        //Msg.To.Add(To);// Recipient e-mail address.
        
        
        
        
        //smtp.Port = 587;
        //smtp.Credentials = new System.Net.NetworkCredential("hmduser111@gmail.com", "hmduser111.com");
        //smtp.UseDefaultCredentials = true;
        //smtp.Send(Msg);
        return 1;
    }
}
