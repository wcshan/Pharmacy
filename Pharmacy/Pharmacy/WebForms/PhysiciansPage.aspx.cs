using Pharmacy.Classes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Pharmacy.WebForms
{
    public partial class PhysiciansPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ClassPhysician generatePhyId = new ClassPhysician();
            txPhysicianId.Text = generatePhyId.GeneratePhysicianId();

            ClassAddresses generateAddId = new ClassAddresses();
            txNewAddressId.Text = generateAddId.GenerateAddressId();

            btnUpdate.CssClass = "btn btn-warning disabled";
            btnDelete.CssClass = "btn btn-danger disabled";
            btnAddress.CssClass = "btn btn-primary disabled";
        }

        protected void btnAddPhysicianSubmit_Click(object sender, EventArgs e)
        {
            ClassPhysician addPhysician = new ClassPhysician();
            addPhysician.addNewPhysician(this);
        }

        protected void GridViewPhysicians_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClassPhysician loadData = new ClassPhysician();
            loadData.LoadPhysicianUpdateData(this);

            ClassAddresses loadAddress = new ClassAddresses();
            loadAddress.ViewAddress(this);

            btnUpdate.CssClass = "btn btn-warning";
            btnDelete.CssClass = "btn btn-danger";
            btnAddress.CssClass = "btn btn-primary";

            lblDeletePhysicianId.Text = GridViewPhysicians.SelectedRow.Cells[1].Text;
            lblDeletePhysicianName.Text = GridViewPhysicians.SelectedRow.Cells[3].Text;
        }

        protected void btnUpdatePhysicianSubmit_Click(object sender, EventArgs e)
        {
            ClassPhysician updatePhysician = new ClassPhysician();
            updatePhysician.UpdatePhysician(this);
        }

        protected void btnDeletePhysicianSubmit_Click(object sender, EventArgs e)
        {
            ClassPhysician deletePhysician = new ClassPhysician();
            deletePhysician.DeletePhysician(this);
        }
    }
}