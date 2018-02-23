using Pharmacy.Database;
using Pharmacy.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace Pharmacy.Classes
{
    public class ClassPrescription
    {
        string vReadPrescriptionId, vPrescriptionId, vCustomerId, vPhysicianId, vStatusCode, vPaymentMethodCode, vIssuedDate, vFilledDate, vDrugId, vInstructions;
        int vNewPrescriptionId, vQuantity;
        public string GeneratePriscriptionId()
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                string sqlSelectCmd = "SELECT MAX(prescriptionId) FROM Prescriptions";
                SqlCommand com = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = com.ExecuteReader();
                read.Read();
                vReadPrescriptionId = read[0].ToString();
                if (string.IsNullOrEmpty(vReadPrescriptionId))
                {
                    vPrescriptionId = "PRS001";
                }
                else
                {
                    vNewPrescriptionId = Convert.ToInt32(vReadPrescriptionId.Substring(3)) + 1;
                    vPrescriptionId = "PRS" + vNewPrescriptionId.ToString("000");
                }
                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
            return vPrescriptionId;
        }

        public void AddNewPrescription(NewPrescriptionPage addPrescription)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                vPrescriptionId = addPrescription.txPrescriptionId.Text;
                vCustomerId = addPrescription.ddCustomer.SelectedValue;
                vPhysicianId = addPrescription.ddPhysician.SelectedValue;
                vStatusCode = addPrescription.ddPrescriptionStatus.SelectedValue;
                vPaymentMethodCode = addPrescription.ddPaymentMethod.SelectedValue;
                vIssuedDate = addPrescription.txPrescriptionDate.Text;
                vFilledDate = DateTime.Now.ToString("yyyy-MM-dd");

                string sqlInsertCmd = "INSERT INTO Prescriptions VALUES('" + vPrescriptionId + "', '" + vCustomerId + "', '" + vPhysicianId + "', '" + vStatusCode + "', '" + vPaymentMethodCode + "', '" + vIssuedDate + "', '"+ vFilledDate + "')";
                SqlCommand cmd = new SqlCommand(sqlInsertCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();

                foreach (GridViewRow row in addPrescription.GridViewDrugItems.Rows)
                {
                    vDrugId = row.Cells[1].Text;
                    vQuantity = Convert.ToInt32(row.Cells[3].Text);
                    vInstructions = row.Cells[4].Text;

                    string sqlInsertCom = "INSERT INTO PrescriptionItems VALUES('" + vPrescriptionId + "', '" + vDrugId + "', '" + vQuantity + "', '" + vInstructions + "')";
                    SqlCommand com = new SqlCommand(sqlInsertCom, DatabaseConnection.dbConnection);
                    com.ExecuteNonQuery();
                }
                DB.closeConnection();
                ScriptManager.RegisterClientScriptBlock(addPrescription, this.GetType(), "SweetAlert", "swal('Success!', 'Prescription created sucessfully', 'success').then(function(){window.location='PrescriptionsPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void LoadPrescriptionData(GridView gridViewPrescriptions)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                string sqlSelectCmd = "SELECT t1.prescriptionId, t1.customerId, t1.physicianId, t1.statusCode, t1.paymentMethodCode, t1.issuedDate, t1.filledDate, t2.customerName, t4.physicianName, t3.paymentMethod, t5.statusDescription FROM Prescriptions AS t1 LEFT JOIN Customers AS t2 ON t2.customerId = t1.customerId LEFT JOIN PaymentMethods AS t3 ON t1.paymentMethodCode = t3.paymentMethodCode LEFT JOIN Physicians AS t4 ON t1.physicianId = t4.physicianId LEFT JOIN PrescriptionStatus AS t5 ON t1.statusCode = t5.prescriptionStatuscode";
                DataAdapter dataAdapter = new SqlDataAdapter(sqlSelectCmd, DatabaseConnection.dbConnection);
                DataSet DS = new DataSet();
                dataAdapter.Fill(DS);
                gridViewPrescriptions.DataSourceID = null;
                gridViewPrescriptions.DataSource = DS.Tables[0];
                gridViewPrescriptions.DataBind();

                DB.closeConnection();                
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void ViewPrescription(string vPresId, System.Web.UI.WebControls.Panel panelDataView)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                string sqlSelectCmd = "SELECT t1.drugId, t1.prescriptionQuantity, t1.instructions, t2.drugName FROM PrescriptionItems AS t1 LEFT JOIN DrugsAndMedication as t2 ON t2.drugId = t1.drugId WHERE t1.prescriptionId = '" + vPresId + "'";
                DataAdapter dataAdapter = new SqlDataAdapter(sqlSelectCmd, DatabaseConnection.dbConnection);
                DataSet DS = new DataSet();
                dataAdapter.Fill(DS);

                foreach (DataTable DT in DS.Tables)
                {
                    foreach (DataRow row in DT.Rows)
                    {
                        System.Web.UI.WebControls.Label lblDrugId = new System.Web.UI.WebControls.Label();
                        System.Web.UI.WebControls.Label lblPresQuantity = new System.Web.UI.WebControls.Label();
                        System.Web.UI.WebControls.Label lblInstructions = new System.Web.UI.WebControls.Label();
                        System.Web.UI.WebControls.Label lblDrugName = new System.Web.UI.WebControls.Label();
                        lblDrugId.Text = row[0].ToString();
                        lblPresQuantity.Text = row[1].ToString();
                        lblInstructions.Text = row[2].ToString();
                        lblDrugName.Text = row[3].ToString();

                        System.Web.UI.WebControls.Label lbl1 = new System.Web.UI.WebControls.Label();
                        System.Web.UI.WebControls.Label lbl2 = new System.Web.UI.WebControls.Label();
                        System.Web.UI.WebControls.Label lbl3 = new System.Web.UI.WebControls.Label();
                        System.Web.UI.WebControls.Label lbl4 = new System.Web.UI.WebControls.Label();

                        lbl1.Text = "Drug ID : ";
                        lbl2.Text = "Drug Name : ";
                        lbl3.Text = "Quantity : ";
                        lbl4.Text = "Instructions : ";

                        panelDataView.Controls.Add(lbl1);
                        panelDataView.Controls.Add(lblDrugId);
                        panelDataView.Controls.Add(new LiteralControl("<br />"));

                        panelDataView.Controls.Add(lbl2);
                        panelDataView.Controls.Add(lblDrugName);
                        panelDataView.Controls.Add(new LiteralControl("<br />"));

                        panelDataView.Controls.Add(lbl3);
                        panelDataView.Controls.Add(lblPresQuantity);
                        panelDataView.Controls.Add(new LiteralControl("<br />"));

                        panelDataView.Controls.Add(lbl4);
                        panelDataView.Controls.Add(lblInstructions);                        
                        panelDataView.Controls.Add(new LiteralControl("<br />"));
                        panelDataView.Controls.Add(new LiteralControl("<br />"));
                    }
                }

                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void LoadDataToUpdate(UpdatePrescriptionPage loadData)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();
                vPrescriptionId = loadData.txPrescriptionId.Text;

                string sqlSelectCmd = "SELECT * FROM Prescriptions WHERE prescriptionId = '" + vPrescriptionId + "'";
                SqlCommand cmd = new SqlCommand(sqlSelectCmd, DatabaseConnection.dbConnection);
                SqlDataReader read = cmd.ExecuteReader();
                read.Read();
                loadData.ddCustomer.SelectedValue = read[1].ToString();
                loadData.ddPhysician.SelectedValue = read[2].ToString();
                loadData.ddPrescriptionStatus.SelectedValue = read[3].ToString();
                loadData.ddPaymentMethod.SelectedValue = read[4].ToString();
                loadData.txPrescriptionDate.Text = read[5].ToString();
                read.Close();

                DB.closeConnection();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void UpdatePrescription(UpdatePrescriptionPage updatePrescription)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                vPrescriptionId = updatePrescription.txPrescriptionId.Text;
                vCustomerId = updatePrescription.ddCustomer.SelectedValue;
                vPhysicianId = updatePrescription.ddPhysician.SelectedValue;
                vStatusCode = updatePrescription.ddPrescriptionStatus.SelectedValue;
                vPaymentMethodCode = updatePrescription.ddPaymentMethod.SelectedValue;
                vIssuedDate = updatePrescription.txPrescriptionDate.Text;

                string sqlUpdateCmd = "UPDATE Prescriptions SET customerId = '" + vCustomerId + "', physicianId = '" + vPhysicianId + "', statusCode = '" + vStatusCode + "', paymentMethodCode = '" + vPaymentMethodCode + "', issuedDate = '" + vIssuedDate + "' WHERE prescriptionId = '" + vPrescriptionId + "'";
                SqlCommand cmd = new SqlCommand(sqlUpdateCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();

                string sqlDeleteCmnd = "DELETE FROM PrescriptionItems WHERE prescriptionId = '" + vPrescriptionId + "'";
                SqlCommand cmnd = new SqlCommand(sqlDeleteCmnd, DatabaseConnection.dbConnection);
                cmnd.ExecuteNonQuery();

                foreach (GridViewRow row in updatePrescription.GridViewDrugItems.Rows)
                {
                    vDrugId = row.Cells[1].Text;
                    vQuantity = Convert.ToInt32(row.Cells[3].Text);
                    vInstructions = row.Cells[4].Text;

                    string sqlInsertCom = "INSERT INTO PrescriptionItems VALUES('" + vPrescriptionId + "', '" + vDrugId + "', '" + vQuantity + "', '" + vInstructions + "')";
                    SqlCommand com = new SqlCommand(sqlInsertCom, DatabaseConnection.dbConnection);
                    com.ExecuteNonQuery();
                }
                DB.closeConnection();
                ScriptManager.RegisterClientScriptBlock(updatePrescription, this.GetType(), "SweetAlert", "swal('Success!', 'Prescription updated sucessfully', 'success').then(function(){window.location='PrescriptionsPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void SearchPrescription(System.Web.UI.WebControls.TextBox txSearch, DropDownList ddSearch, GridView GridViewSearch)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();
                string selectQuery = null;
                string vSearchValue = '%' + txSearch.Text + '%';

                switch (ddSearch.SelectedIndex)
                {
                    case 0:
                        selectQuery = "SELECT t1.prescriptionId, t1.customerId, t1.physicianId, t1.statusCode, t1.paymentMethodCode, t1.issuedDate, t1.filledDate, t2.customerName, t4.physicianName, t3.paymentMethod, t5.statusDescription FROM Prescriptions AS t1 LEFT JOIN Customers AS t2 ON t2.customerId = t1.customerId LEFT JOIN PaymentMethods AS t3 ON t1.paymentMethodCode = t3.paymentMethodCode LEFT JOIN Physicians AS t4 ON t1.physicianId = t4.physicianId LEFT JOIN PrescriptionStatus AS t5 ON t1.statusCode = t5.prescriptionStatuscode WHERE t1.prescriptionId LIKE '" + vSearchValue + "'";
                        break;

                    case 1:
                        selectQuery = "SELECT t1.prescriptionId, t1.customerId, t1.physicianId, t1.statusCode, t1.paymentMethodCode, t1.issuedDate, t1.filledDate, t2.customerName, t4.physicianName, t3.paymentMethod, t5.statusDescription FROM Prescriptions AS t1 LEFT JOIN Customers AS t2 ON t2.customerId = t1.customerId LEFT JOIN PaymentMethods AS t3 ON t1.paymentMethodCode = t3.paymentMethodCode LEFT JOIN Physicians AS t4 ON t1.physicianId = t4.physicianId LEFT JOIN PrescriptionStatus AS t5 ON t1.statusCode = t5.prescriptionStatuscode WHERE t2.customerName LIKE '" + vSearchValue + "'";
                        break;
                    case 2:
                        selectQuery = "SELECT t1.prescriptionId, t1.customerId, t1.physicianId, t1.statusCode, t1.paymentMethodCode, t1.issuedDate, t1.filledDate, t2.customerName, t4.physicianName, t3.paymentMethod, t5.statusDescription FROM Prescriptions AS t1 LEFT JOIN Customers AS t2 ON t2.customerId = t1.customerId LEFT JOIN PaymentMethods AS t3 ON t1.paymentMethodCode = t3.paymentMethodCode LEFT JOIN Physicians AS t4 ON t1.physicianId = t4.physicianId LEFT JOIN PrescriptionStatus AS t5 ON t1.statusCode = t5.prescriptionStatuscode WHERE t4.physicianName LIKE '" + vSearchValue + "'";
                        break;
                }
                var dataAdapter = new SqlDataAdapter(selectQuery, DatabaseConnection.dbConnection);
                var DS = new DataSet();
                dataAdapter.Fill(DS);
                GridViewSearch.DataSourceID = null;
                GridViewSearch.DataSource = DS.Tables[0];
                GridViewSearch.DataBind();
                DB.closeConnection();
                txSearch.Text = "";
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }

        public void DeletePrescription(PrescriptionsPage deletPrescription)
        {
            try
            {
                DatabaseConnection DB = new DatabaseConnection();
                DB.openConnection();

                vPrescriptionId = deletPrescription.GridViewPrescriptions.SelectedRow.Cells[1].Text;
                string sqlDeleteCom = "DELETE FROM PrescriptionItems WHERE prescriptionId = '" + vPrescriptionId + "'";
                SqlCommand com = new SqlCommand(sqlDeleteCom, DatabaseConnection.dbConnection);
                com.ExecuteNonQuery();

                string sqlDeleteCmd = "DELETE FROM Prescriptions WHERE prescriptionId = '" + vPrescriptionId + "'";
                SqlCommand cmd = new SqlCommand(sqlDeleteCmd, DatabaseConnection.dbConnection);
                cmd.ExecuteNonQuery();                

                DB.closeConnection();
                ScriptManager.RegisterClientScriptBlock(deletPrescription, this.GetType(), "SweetAlert", "swal('Success!', 'Prescription Deleted', 'success').then(function(){window.location='PrescriptionsPage.aspx';})", true);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error" + ex);
            }
        }
    }
}

