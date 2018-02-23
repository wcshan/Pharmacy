<%@ Page Title="" Language="C#" MasterPageFile="~/WebForms/PharmacyMaster.Master" AutoEventWireup="true" CodeBehind="NewPrescriptionPage.aspx.cs" Inherits="Pharmacy.WebForms.NewPrescriptionPage" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentHead" runat="server">
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="contentBody" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-sm-12" style="height: 10px"></div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-sm-4">
                <asp:Label ID="Label1" runat="server" Text="Prescription ID"></asp:Label>&nbsp
                <asp:TextBox ID="txPrescriptionId" runat="server" Enabled="false"></asp:TextBox>
            </div>
            <div class="col-sm-4">
                <asp:Label ID="Label2" runat="server" Text="Customer"></asp:Label>&nbsp&nbsp&nbsp&nbsp
                <asp:DropDownList CssClass="btn btn-dark" ID="ddCustomer" Width="200px" Height="35px" runat="server" AppendDataBoundItems="True" ValidationGroup="groupAdd" DataSourceID="SqlDataSourceCustomersList" DataTextField="customerName" DataValueField="customerId">
                    <asp:ListItem Value="0" Text="-- Select --" Selected="True"></asp:ListItem>
                </asp:DropDownList>                
                <asp:SqlDataSource ID="SqlDataSourceCustomersList" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT [customerId], [customerName] FROM [Customers]"></asp:SqlDataSource>
            </div>
            <div class="col-sm-4">
                <asp:Label ID="Label3" runat="server" Text="Physician"></asp:Label>
                <asp:DropDownList CssClass="btn btn-dark" ID="ddPhysician" Width="200px" Height="35px" runat="server" AppendDataBoundItems="True" ValidationGroup="groupAdd" DataSourceID="SqlDataSourcePhysicianList" DataTextField="physicianName" DataValueField="physicianId">
                    <asp:ListItem Value="0" Text="-- Select --" Selected="True"></asp:ListItem>
                </asp:DropDownList>                
                <asp:SqlDataSource ID="SqlDataSourcePhysicianList" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT [physicianId], [physicianName] FROM [Physicians]"></asp:SqlDataSource>
            </div>
        </div>
        <div class="row" style="margin-top: 20px">
            <div class="col-sm-4">
                <asp:Label ID="Label4" runat="server" Text="Prescrip: Status"></asp:Label>
                <asp:DropDownList CssClass="btn btn-dark" ID="ddPrescriptionStatus" Width="200px" Height="35px" runat="server" AppendDataBoundItems="True" ValidationGroup="groupAdd" DataSourceID="SqlDataSourcePrescriptionStatus" DataTextField="statusDescription" DataValueField="prescriptionStatuscode">
                    <asp:ListItem Value="0" Text="-- Select --" Selected="True"></asp:ListItem>
                </asp:DropDownList>                
                <asp:SqlDataSource ID="SqlDataSourcePrescriptionStatus" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT [prescriptionStatuscode], [statusDescription] FROM [PrescriptionStatus]"></asp:SqlDataSource>
            </div>
            <div class="col-sm-4">
                <asp:Label ID="Label5" runat="server" Text="Pay Method"></asp:Label>
                <asp:DropDownList CssClass="btn btn-dark" ID="ddPaymentMethod" Width="200px" Height="35px" runat="server" AppendDataBoundItems="True" ValidationGroup="groupAdd" DataSourceID="SqlDataSourcePaymentMethod" DataTextField="paymentMethod" DataValueField="paymentMethodCode">
                    <asp:ListItem Value="0" Text="-- Select --" Selected="True"></asp:ListItem>
                </asp:DropDownList>                
                <asp:SqlDataSource ID="SqlDataSourcePaymentMethod" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT [paymentMethodCode], [paymentMethod] FROM [PaymentMethods]"></asp:SqlDataSource>
            </div>
            <div class="col-sm-4">
                <asp:Label ID="Label6" runat="server" Text="Prescription Date"></asp:Label>
                <asp:TextBox ID="txPrescriptionDate" CssClass="form-control-sm bg-dark" Width="145px" Height="35px" ForeColor="White" TextMode="Date" runat="server"></asp:TextBox>                
            </div>
        </div>
    </div>
    <hr style="height: 2px; background-color: black; width:1100px;" />

    <div class="container">
        <div class="row">
            <div class="col-sm-4 table-responsive">
                <asp:GridView CssClass="table table-bordered table-hover" ID="GridViewDrugs" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="drugId" DataSourceID="SqlDataSourceDrugsList" GridLines="Vertical" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" OnSelectedIndexChanged="GridViewDrugs_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-dark" ShowSelectButton="True" />
                        <asp:BoundField DataField="drugId" HeaderText="Drug Id" ReadOnly="True" SortExpression="drugId" />
                        <asp:BoundField DataField="drugName" HeaderText="Drug Name" SortExpression="drugName" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#105b85" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="Gray" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSourceDrugsList" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT [drugId], [drugName] FROM [DrugsAndMedication]"></asp:SqlDataSource>
            </div>
            <div class="col-sm-2">
                <asp:LinkButton CssClass="btn btn-success" ID="btnAdd" runat="server" Width="140px" data-toggle="modal" data-target="#inputModal"><span class="fa fa-user-plus"></span>&nbsp;&nbsp;Add</asp:LinkButton><br />
                <br />
                <asp:LinkButton CssClass="btn btn-danger" ID="btnDelete" runat="server" Width="140px" data-toggle="modal" data-target="#removeModal"><span class="fa fa-trash"></span>&nbsp;&nbsp;Remove</asp:LinkButton><br />
                <br />
                <asp:LinkButton CssClass="btn btn-primary" ID="btnComplete" runat="server" Width="140px" data-toggle="modal" data-target="#completeModal"><span class="fa fa-globe"></span>&nbsp;&nbsp;Complete</asp:LinkButton>
            </div>
            <div class="col-sm-6 table-responsive">
                <asp:GridView CssClass="table table-bordered table-hover" ID="GridViewDrugItems" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="drugId" GridLines="Vertical" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" OnSelectedIndexChanged="GridViewDrugItems_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-dark" ShowSelectButton="True" />
                        <asp:BoundField DataField="drugId" HeaderText="Drug Id" ReadOnly="True" SortExpression="drugId" />
                        <asp:BoundField DataField="drugName" HeaderText="Drug Name" SortExpression="drugName" />
                        <asp:BoundField DataField="quantity" HeaderText="Quantity" SortExpression="quantity" />
                        <asp:BoundField DataField="instructions" HeaderText="Instructions" SortExpression="instructions" />
                    </Columns>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#105b85" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="Gray" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />                    
                </asp:GridView>                
            </div>             
        </div>
    </div>
    
    <!-- Input Modal -->
    <div class="modal fade" id="inputModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#0a5b64, #139aa9); color: white">
                    <h5 class="modal-title">Input Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-5">
                            <asp:Label ID="lbl1" runat="server" Text="Drug Id"></asp:Label>
                        </div>
                        <div class="col-sm-7">
                            <asp:TextBox Enabled="false" ID="txDrugId" runat="server" ValidationGroup="groupAdd"></asp:TextBox>                            
                        </div>
                    </div>
                    &nbsp;
                    <div class="row">
                        <div class="col-sm-5">
                            <asp:Label ID="Label11" runat="server" Text="Quantity"></asp:Label>
                        </div>
                        <div class="col-sm-7">
                            <asp:TextBox ID="txQuantity" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvtxQuantity" runat="server" ErrorMessage="" ControlToValidate="txQuantity" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                        </div>
                    </div>
                    &nbsp;
                    <div class="row">
                        <div class="col-sm-5">
                            <asp:Label ID="Label7" runat="server" Text="Instructions"></asp:Label>
                        </div>
                        <div class="col-sm-7">
                            <asp:TextBox ID="txInstructions" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvtxInstructions" runat="server" ErrorMessage="" ControlToValidate="txInstructions" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button type="submit" runat="server" CssClass="btn btn-dark btn-lg btn-block login-button" UseSubmitBehavior="false" Text="Submit" ID="btnAddInputSubmit" ValidationGroup="groupAdd" OnClick="btnAddInputSubmit_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>

    <!-- Remove Modal -->
    <div class="modal fade" id="removeModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#0a5b64, #139aa9); color: white">
                    <h5 class="modal-title">Delete Confirmation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to remove
                    <asp:Label runat="server" ID="lblRemoveDrugId"></asp:Label>
                    <asp:Label runat="server" ID="lblRemoveDrugName"></asp:Label>
                    ?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <asp:Button type="submit" runat="server" CssClass="btn btn-danger" Text="Remove" ID="btnRemoveDrug" OnClick="btnRemoveDrug_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>

    <!-- Complete Modal -->
    <div class="modal fade" id="completeModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#0a5b64, #139aa9); color: white">
                    <h5 class="modal-title">Complete Confirmation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to complete the Prescription ?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <asp:Button type="submit" runat="server" CssClass="btn btn-primary" Text="Complete" ID="btnConfirmComplete" OnClick="btnConfirmComplete_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
