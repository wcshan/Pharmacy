﻿using System;
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
            System.Web.UI.HtmlControls.HtmlGenericControl li = (System.Web.UI.HtmlControls.HtmlGenericControl)this.Page.Master.FindControl("liCompany");
            System.Web.UI.HtmlControls.HtmlGenericControl span1 = (System.Web.UI.HtmlControls.HtmlGenericControl)this.Page.Master.FindControl("spanCompany1");
            System.Web.UI.HtmlControls.HtmlGenericControl span2 = (System.Web.UI.HtmlControls.HtmlGenericControl)this.Page.Master.FindControl("spanCompany2");
            li.Attributes.Add("class", "item-menu active-menu");
            span1.Attributes.Add("class", "fa fa-building fa-2x active-span");
            span2.Attributes.Add("class", "menu active-span");

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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ClassDrugCompany searchCompany = new ClassDrugCompany();
            searchCompany.SearchDrugCompany(txSearch, ddSearch, GridViewDrugCompanies);
        }
    }
}