using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Pharmacy.Classes;

namespace Pharmacy.WebForms
{
    public partial class CustomersPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ClassCustomer generateCusId = new ClassCustomer();
            txCustomerId.Text = generateCusId.GenerateCustomerId();

            ClassAddresses generateAddId = new ClassAddresses();
            txNewAddressId.Text = generateAddId.GenerateAddressId();

            btnUpdate.CssClass = "btn btn-warning disabled";
            btnDelete.CssClass = "btn btn-danger disabled";
            btnAddress.CssClass = "btn btn-primary disabled";
        }

        protected void btnAddCustomerSubmit_Click(object sender, EventArgs e)
        {
            ClassCustomer addCustomer = new ClassCustomer();
            addCustomer.addNewCustomer(this);            
        }

        protected void GridViewCustomers_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClassCustomer loadData = new ClassCustomer();
            loadData.LoadCustomerUpdateData(this);

            ClassAddresses loadAddress = new ClassAddresses();
            loadAddress.ViewAddress(this);

            btnUpdate.CssClass = "btn btn-warning";
            btnDelete.CssClass = "btn btn-danger";
            btnAddress.CssClass = "btn btn-primary";

            lblDeleteCustomerId.Text = GridViewCustomers.SelectedRow.Cells[1].Text;
            lblDeleteCustomerName.Text = GridViewCustomers.SelectedRow.Cells[3].Text;
        }

        protected void btnUpdateCustomerSubmit_Click(object sender, EventArgs e)
        {
            ClassCustomer updateCustomer = new ClassCustomer();
            updateCustomer.UpdateCustomer(this);
        }

        protected void btnDeleteCustomer_Click(object sender, EventArgs e)
        {
            ClassCustomer deleteCustomer = new ClassCustomer();
            deleteCustomer.DeleteCustomer(this);
        }        
    }
}