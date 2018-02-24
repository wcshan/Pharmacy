﻿using Pharmacy.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pharmacy.WebForms
{
    public partial class DrugsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            System.Web.UI.HtmlControls.HtmlGenericControl li = (System.Web.UI.HtmlControls.HtmlGenericControl)this.Page.Master.FindControl("liDrug");
            System.Web.UI.HtmlControls.HtmlGenericControl span1 = (System.Web.UI.HtmlControls.HtmlGenericControl)this.Page.Master.FindControl("spanDrug1");
            System.Web.UI.HtmlControls.HtmlGenericControl span2 = (System.Web.UI.HtmlControls.HtmlGenericControl)this.Page.Master.FindControl("spanDrug2");
            li.Attributes.Add("class", "item-menu active-menu");
            span1.Attributes.Add("class", "fa fa-medkit fa-2x active-span");
            span2.Attributes.Add("class", "menu active-span");

            ClassDrug generateDrugId = new ClassDrug();
            txDrugId.Text = generateDrugId.GenerateDrugId();
            
            btnUpdate.CssClass = "btn btn-warning disabled";
            btnDelete.CssClass = "btn btn-danger disabled";            
        }

        protected void btnAddDrugSubmit_Click(object sender, EventArgs e)
        {
            ClassDrug addDrug = new ClassDrug();
            addDrug.addNewDrug(this);
        }

        protected void btnUpdateDrugSubmit_Click(object sender, EventArgs e)
        {
            ClassDrug updateDrug = new ClassDrug();
            updateDrug.UpdateDrug(this);
        }

        protected void btnDeleteDrugSubmit_Click(object sender, EventArgs e)
        {
            ClassDrug deleteDrug = new ClassDrug();
            deleteDrug.DeleteDrug(this);
        }

        protected void GridViewDrugs_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClassDrug loadData = new ClassDrug();
            loadData.LoadDrugUpdateData(this);

            btnUpdate.CssClass = "btn btn-warning";
            btnDelete.CssClass = "btn btn-danger";

            lblDeleteDrugId.Text = GridViewDrugs.SelectedRow.Cells[1].Text;
            lblDeleteDrugName.Text = GridViewDrugs.SelectedRow.Cells[3].Text;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            ClassDrug searchDrug = new ClassDrug();
            searchDrug.SearchDrug(txSearch, ddSearch, GridViewDrugs);
        }
    }
}