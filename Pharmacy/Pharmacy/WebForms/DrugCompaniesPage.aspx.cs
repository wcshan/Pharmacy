using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Pharmacy.Classes;

namespace Pharmacy.WebForms
{
    public partial class DrugCompaniesPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ClassDrugCompany generateComId = new ClassDrugCompany();
            txCompanyId.Text = generateComId.GenerateCompanyId();

            btnDelete.CssClass = "btn btn-danger disabled";
        }

        protected void btnAddCompanySubmit_Click(object sender, EventArgs e)
        {
            ClassDrugCompany addCompany = new ClassDrugCompany();
            addCompany.addNewCompany(this);
        }

        protected void btnDeleteCompanySubmit_Click(object sender, EventArgs e)
        {
            ClassDrugCompany deleteCompany = new ClassDrugCompany();
            deleteCompany.DeleteCompany(this);
        }

        protected void GridViewDrugCompanies_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnDelete.CssClass = "btn btn-danger";

            lblDeleteCompanyId.Text = GridViewDrugCompanies.SelectedRow.Cells[1].Text;
            lblDeleteCompanyName.Text = GridViewDrugCompanies.SelectedRow.Cells[2].Text;
        }
    }
}