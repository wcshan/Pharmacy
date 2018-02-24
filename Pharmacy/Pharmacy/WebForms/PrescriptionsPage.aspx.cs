using Pharmacy.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pharmacy.WebForms
{
    public partial class PrescriptionsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                ClassPrescription loadData = new ClassPrescription();
                loadData.LoadPrescriptionData(GridViewPrescriptions);
            }
            System.Web.UI.HtmlControls.HtmlGenericControl li = (System.Web.UI.HtmlControls.HtmlGenericControl)this.Page.Master.FindControl("liPrescription");
            System.Web.UI.HtmlControls.HtmlGenericControl span1 = (System.Web.UI.HtmlControls.HtmlGenericControl)this.Page.Master.FindControl("spanPrescription1");
            System.Web.UI.HtmlControls.HtmlGenericControl span2 = (System.Web.UI.HtmlControls.HtmlGenericControl)this.Page.Master.FindControl("spanPrescription2");
            li.Attributes.Add("class", "item-menu active-menu");
            span1.Attributes.Add("class", "fa fa-sticky-note fa-2x active-span");
            span2.Attributes.Add("class", "menu active-span");

            btnUpdate.CssClass = "btn btn-warning disabled";
            btnView.CssClass = "btn btn-primary disabled";
            btnDelete.CssClass = "btn btn-danger disabled";
        }

        protected void GridViewPrescriptions_SelectedIndexChanged(object sender, EventArgs e)
        {
            string vPresId = GridViewPrescriptions.SelectedRow.Cells[1].Text;
            ClassPrescription loadPriscription = new ClassPrescription();
            loadPriscription.ViewPrescription(vPresId, panelDataView);

            btnUpdate.CssClass = "btn btn-warning enabled";
            btnView.CssClass = "btn btn-primary enabled";
            btnDelete.CssClass = "btn btn-danger enabled";
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string vPresID = GridViewPrescriptions.SelectedRow.Cells[1].Text;
            Response.Redirect("UpdatePrescriptionPage.aspx?vPresId="+vPresID);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ClassPrescription searchPrescription = new ClassPrescription();
            searchPrescription.SearchPrescription(txSearch, ddSearch, GridViewPrescriptions);
        }

        protected void btnDeletePrescriptionSubmit_Click(object sender, EventArgs e)
        {
            ClassPrescription deletePrescription = new ClassPrescription();
            deletePrescription.DeletePrescription(this);
        }
    }
}