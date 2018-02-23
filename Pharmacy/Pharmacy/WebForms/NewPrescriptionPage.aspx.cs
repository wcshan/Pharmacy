using Pharmacy.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace Pharmacy.WebForms
{
    public partial class NewPrescriptionPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            btnAdd.CssClass = "btn btn-success disabled";
            btnDelete.CssClass = "btn btn-danger disabled";
            GridViewDrugItems.EmptyDataText = "Empty";
            GridViewDrugItems.ShowHeaderWhenEmpty = true;

            ClassPrescription generateId = new ClassPrescription();
            txPrescriptionId.Text = generateId.GeneratePriscriptionId();            
        }

        protected void GridViewDrugs_SelectedIndexChanged(object sender, EventArgs e)
        {
            txDrugId.Text = GridViewDrugs.SelectedRow.Cells[1].Text;
            btnAdd.CssClass = "btn btn-success enabled";
        }

        protected void btnAddInputSubmit_Click(object sender, EventArgs e)
        {
            bool vFound = false;
            try
            {
                DataTable DT = new DataTable();
                DT.Columns.Add("drugId");
                DT.Columns.Add("drugName");
                DT.Columns.Add("quantity");
                DT.Columns.Add("instructions");

                foreach (GridViewRow row in GridViewDrugItems.Rows)
                {
                    DataRow DR = DT.NewRow();
                    DR["drugId"] = row.Cells[1].Text;
                    DR["drugName"] = row.Cells[2].Text;
                    DR["quantity"] = row.Cells[3].Text;
                    DR["instructions"] = row.Cells[4].Text;
                    DT.Rows.Add(DR);
                }

                foreach (GridViewRow row in GridViewDrugItems.Rows)
                {
                    if (row.Cells[1].Text == txDrugId.Text)
                    {
                        vFound = true;
                        break;
                    }
                }

                if (vFound == true)
                {
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Error!', 'Selected Drug is already added', 'error');", true);
                }
                else
                {
                    DataRow newDR = DT.NewRow();
                    newDR["drugId"] = txDrugId.Text;
                    newDR["drugName"] = GridViewDrugs.SelectedRow.Cells[2].Text;
                    newDR["quantity"] = txQuantity.Text;
                    newDR["instructions"] = txInstructions.Text;
                    DT.Rows.Add(newDR);

                    GridViewDrugItems.DataSource = DT;
                    GridViewDrugItems.DataBind();
                    this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Success!', 'Drug added successfully', 'success');", true);
                }

                btnAdd.CssClass = "btn btn-success disabled";
                GridViewDrugs.SelectedIndex = -1;
                txQuantity.Text = "";
                txInstructions.Text = "";

            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }

        }

        protected void GridViewDrugItems_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnDelete.CssClass = "btn btn-danger enabled";
            lblRemoveDrugId.Text = GridViewDrugItems.SelectedRow.Cells[1].Text;
            lblRemoveDrugName.Text = GridViewDrugItems.SelectedRow.Cells[2].Text;
        }

        protected void btnRemoveDrug_Click(object sender, EventArgs e)
        {
            int index = GridViewDrugItems.SelectedIndex;

            try
            {
                DataTable DT = new DataTable();
                DT.Columns.Add("drugId");
                DT.Columns.Add("drugName");
                DT.Columns.Add("quantity");
                DT.Columns.Add("instructions");

                foreach (GridViewRow row in GridViewDrugItems.Rows)
                {
                    DataRow DR = DT.NewRow();
                    DR["drugId"] = row.Cells[1].Text;
                    DR["drugName"] = row.Cells[2].Text;
                    DR["quantity"] = row.Cells[3].Text;
                    DR["instructions"] = row.Cells[4].Text;
                    DT.Rows.Add(DR);
                }

                DT.Rows.RemoveAt(index);
                GridViewDrugItems.DataSource = DT;
                GridViewDrugItems.DataBind();
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Success!', 'Drug removed successfully', 'success');", true);

                btnDelete.CssClass = "btn btn-danger disabled";
                GridViewDrugItems.SelectedIndex = -1;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        protected void btnConfirmComplete_Click(object sender, EventArgs e)
        {
            if (GridViewDrugItems.Rows.Count == 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Error!', 'No drugs added', 'error');", true);
            }
            else if(ddCustomer.SelectedIndex == 0 || ddPhysician.SelectedIndex == 0 || ddPaymentMethod.SelectedIndex == 0 || ddPrescriptionStatus.SelectedIndex == 0 || txPrescriptionDate.Text.Length == 0)
            {
                this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Error!', 'One or more fields are not filled', 'error');", true);
            }
            else
            {
                ClassPrescription addPrescription = new ClassPrescription();
                addPrescription.AddNewPrescription(this);
            }
        }
    }
}