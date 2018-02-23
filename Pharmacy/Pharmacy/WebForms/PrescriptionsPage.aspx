<%@ Page Title="" Language="C#" MasterPageFile="~/WebForms/PharmacyMaster.Master" AutoEventWireup="true" CodeBehind="PrescriptionsPage.aspx.cs" Inherits="Pharmacy.WebForms.PrescriptionsPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentHead" runat="server">
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="contentbody" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-sm-12" style="height: 10px"></div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-sm-11 table-responsive">
                <asp:GridView CssClass="table table-bordered table-hover" ID="GridViewPrescriptions" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="prescriptionId" GridLines="Vertical" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" OnSelectedIndexChanged="GridViewPrescriptions_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-dark" ShowSelectButton="True" />
                        <asp:BoundField DataField="prescriptionId" HeaderText="Prescription Id" ReadOnly="True" SortExpression="prescriptionId" />
                        <asp:BoundField DataField="customerId" HeaderText="Customer Id" SortExpression="customerId" />
                        <asp:BoundField DataField="customerName" HeaderText="Customer Name" SortExpression="customerName" />
                        <asp:BoundField DataField="physicianId" HeaderText="Physician Id" SortExpression="physicianId" />
                        <asp:BoundField DataField="physicianName" HeaderText="Physician Name" SortExpression="physicianName" />
                        <asp:BoundField DataField="statusDescription" HeaderText="Status" SortExpression="statusDescription" />
                        <asp:BoundField DataField="paymentMethod" HeaderText="Payment Method" SortExpression="paymentMethod" />
                        <asp:BoundField DataField="issuedDate" HeaderText="Issued Date" SortExpression="issuedDate" />
                        <asp:BoundField DataField="filledDate" HeaderText="Filled Date" SortExpression="filledDate" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="Gray" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourcePrescriptions" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT * FROM [Prescriptions]"></asp:SqlDataSource>
            </div>
            <div class="col-sm-1">
                <asp:LinkButton CssClass="btn btn-success" ID="btnAdd" runat="server" Text="Add" Width="78px" PostBackUrl="~/WebForms/NewPrescriptionPage.aspx" /><br />
                <br />
                <asp:LinkButton CssClass="btn btn-warning" ID="btnUpdate" runat="server" Text="Update" Width="78px" OnClick="btnUpdate_Click" /><br />
                <br />
                <asp:LinkButton CssClass="btn btn-primary" ID="btnView" runat="server" Text="View" Width="78px" data-toggle="modal" data-target="#viewPrescriptionModal" />
            </div>
        </div>
    </div>

    <!-- View Prescription Modal-->    
    <div class="modal fade" id="viewPrescriptionModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header" style="background: linear-gradient(#2b2a2a, #5c5b5b); color: white">
                    <h5 class="modal-title">Prescription</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container-fluid">
                        <div class="row main col-xs-12">
                            <asp:Panel runat="server" class="main-login col-xs-12" ID="panelDataView">

                            </asp:Panel>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button runat="server" CssClass="btn btn-dark btn-lg btn-block login-button" Text="Close" ID="btnClose" data-dismiss="modal"></asp:Button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
