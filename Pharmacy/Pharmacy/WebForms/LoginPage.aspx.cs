using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pharmacy.WebForms
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if(txUsername.Text == "admin" && txPassword.Text == "admin")
            {
                Response.Redirect("CustomersPage.aspx");
            }
            else
            {
                txUsername.Text = "";
                txPassword.Text = "";
                lblLoginMessage.Text = "Invalid User ID or Password";
            }
        }
    }
}