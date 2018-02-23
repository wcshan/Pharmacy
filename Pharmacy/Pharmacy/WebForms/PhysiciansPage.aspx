<%@ Page Title="" Language="C#" MasterPageFile="~/WebForms/PharmacyMaster.Master" AutoEventWireup="true" CodeBehind="PhysiciansPage.aspx.cs" Inherits="Pharmacy.WebForms.PhysiciansPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentHead" runat="server">
</asp:Content>

<asp:Content ID="body" ContentPlaceHolderID="contentbody" runat="server">
    <div class="container">
        <div class="row" style="margin-bottom:10px; margin-top:20px">
            <div class="col-sm-6">
                <div class="input-group">
                    <asp:DropDownList CssClass="btn-success" runat="server" ID="ddPhysicianSearch" Width="100px">
                        <asp:ListItem>ID</asp:ListItem>
                        <asp:ListItem>Name</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox CssClass="form-control" runat="server" ID="txPhysicianSearch" placeholder="Search Text" BackColor="#eaeaea"></asp:TextBox>
                    <asp:Button runat="server" CssClass="btn-success" Text="   Search   " ID="btnPhysicianSearch" OnClick="btnPhysicianSearch_Click" />
                </div>
            </div>
            <div class="col-sm-6 text-right">
                <asp:LinkButton CssClass="btn btn-success" ID="btnAdd" runat="server" Width="110px" data-toggle="modal" data-target="#addPhysicianModal"><span class="fa fa-user-plus"></span>&nbsp;&nbsp;Add</asp:LinkButton>&nbsp;&nbsp;                
                <asp:LinkButton CssClass="btn btn-warning" ID="btnUpdate" runat="server" Width="110px" data-toggle="modal" data-target="#updatePhysicianModal"><span class="fa fa-edit"></span>&nbsp;&nbsp;Update</asp:LinkButton>&nbsp;&nbsp;                
                <asp:LinkButton CssClass="btn btn-danger" ID="btnDelete" runat="server" Width="110px" data-toggle="modal" data-target="#deletePhysicianModal"><span class="fa fa-trash"></span>&nbsp;&nbsp;Delete</asp:LinkButton>&nbsp;&nbsp;                
                <asp:LinkButton CssClass="btn btn-primary" ID="btnAddress" runat="server" Width="110px" data-toggle="modal" data-target="#viewAddressModal"><span class="fa fa-globe"></span>&nbsp;&nbsp;Address</asp:LinkButton>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12 table-responsive">
                <asp:GridView CssClass="table table-bordered table-hover" ID="GridViewPhysicians" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="physicianId" DataSourceID="SqlDataSourcePhysicians" GridLines="Vertical" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" OnSelectedIndexChanged="GridViewPhysicians_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:CommandField ButtonType="Button" ControlStyle-CssClass="btn btn-dark" ShowSelectButton="True" />
                        <asp:BoundField DataField="physicianId" HeaderText="Physician Id" ReadOnly="True" SortExpression="physicianId" />
                        <asp:BoundField DataField="addressId" HeaderText="Address Id" SortExpression="addressId" />
                        <asp:BoundField DataField="physicianName" HeaderText="Physician Name" SortExpression="physicianName" />
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
                <asp:SqlDataSource ID="SqlDataSourcePhysicians" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT * FROM [Physicians]"></asp:SqlDataSource>
            </div>            
        </div>
    </div>

    <!-- Add New Physician Modal-->
    <div class="modal fade" id="addPhysicianModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#0a5b64, #139aa9); color: white">
                    <h5 class="modal-title">Add New Physician</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="lbl1" runat="server" Text="Physician Id"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox Enabled="false" ID="txPhysicianId" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxPhysicianId" runat="server" ErrorMessage="" ControlToValidate="txPhysicianId" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label1" runat="server" Text="Physician Name"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txPhysicianName" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxPhysicianName" runat="server" ErrorMessage="" ControlToValidate="txPhysicianName" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label9" runat="server" Text="Physician Address"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:RadioButtonList ID="rbListAddress" runat="server" AutoPostBack="false" ValidationGroup="groupAdd" onclick="addressValidation()" RepeatDirection="Horizontal" RepeatLayout="Table" RepeatColumns="2" Width="100%">
                                    <asp:ListItem Text="New" Selected="True" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Existing" Value="2"></asp:ListItem>
                                </asp:RadioButtonList>

                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label2" runat="server" Text="New Address ID"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txNewAddressId" runat="server" Enabled="false" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxAddressId" runat="server" ErrorMessage="" ControlToValidate="txNewAddressId" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label12" runat="server" Text="Existing Address ID"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:DropDownList CssClass="btn btn-light" ID="ddAddress" Width="200px" runat="server" Enabled="False" DataSourceID="SqlDataSourceAddressList" DataTextField="addressId" DataValueField="addressId" AppendDataBoundItems="true" ValidationGroup="groupAdd">
                                    <asp:ListItem Value="0" Text="---   Select   ---" Selected="True"></asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceAddressList" runat="server" ConnectionString="<%$ ConnectionStrings:PharmacyConnectionString %>" SelectCommand="SELECT [addressId] FROM [Addresses]"></asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="rfvddAddress" runat="server" ErrorMessage="" ControlToValidate="ddAddress" InitialValue="0" ValidationGroup="groupAdd" Enabled="false"><img src="Images/Required.png"/></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="lblAddressLine1" runat="server" Text="Line 01"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txAddressLine1" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxAddressLine1" runat="server" ErrorMessage="" ControlToValidate="txAddressLine1" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="lblAddressLine2" runat="server" Text="Line 02"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txAddressLine2" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxAddressLine2" runat="server" ErrorMessage="" ControlToValidate="txAddressLine2" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="lblAddressLine3" runat="server" Text="Line 03"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txAddressLine3" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxAddressLine3" runat="server" ErrorMessage="" ControlToValidate="txAddressLine3" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="lblCity" runat="server" Text="City"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txCity" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxCity" runat="server" ErrorMessage="" ControlToValidate="txCity" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="lblZipPostCode" runat="server" Text="Zip/Post Code"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txZipPostCode" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxZipPostCode" runat="server" ErrorMessage="" ControlToValidate="txZipPostCode" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="lblStateProvince" runat="server" Text="Province"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txStateProvince" runat="server" ValidationGroup="groupAdd"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxStateProvince" runat="server" ErrorMessage="" ControlToValidate="txStateProvince" ValidationGroup="groupAdd"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button type="submit" runat="server" CssClass="btn btn-dark btn-lg btn-block login-button" Text="Submit" ID="btnAddPhysicianSubmit" ValidationGroup="groupAdd" OnClick="btnAddPhysicianSubmit_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Physician Modal-->
    <div class="modal fade" id="updatePhysicianModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#0a5b64, #139aa9); color: white">
                    <h5 class="modal-title">Update Physician</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label3" runat="server" Text="Customer Id"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox Enabled="false" ID="txUpdatePhysicianId" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdatePhysicianId" runat="server" ErrorMessage="" ControlToValidate="txUpdatePhysicianId" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label4" runat="server" Text="Customer Name"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdatePhysicianName" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdatePhysicianName" runat="server" ErrorMessage="" ControlToValidate="txUpdatePhysicianName" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;                        
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label8" runat="server" Text="Address ID"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateAddressId" runat="server" Enabled="false" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateAddressId" runat="server" ErrorMessage="" ControlToValidate="txUpdateAddressId" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label14" runat="server" Text="Line 01"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateAddressLine1" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateAddressLine1" runat="server" ErrorMessage="" ControlToValidate="txUpdateAddressLine1" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label15" runat="server" Text="Line 02"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateAddressLine2" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateAddressLine2" runat="server" ErrorMessage="" ControlToValidate="txUpdateAddressLine2" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label16" runat="server" Text="Line 03"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateAddressLine3" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateAddressLine3" runat="server" ErrorMessage="" ControlToValidate="txUpdateAddressLine3" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label17" runat="server" Text="City"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateCity" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateCity" runat="server" ErrorMessage="" ControlToValidate="txUpdateCity" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label18" runat="server" Text="Zip/Post Code"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateZipPostCode" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateZipPostCode" runat="server" ErrorMessage="" ControlToValidate="txUpdateZipPostCode" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label19" runat="server" Text="Province"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txUpdateStateProvince" runat="server" ValidationGroup="groupUpdate"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvtxUpdateStateProvince" runat="server" ErrorMessage="" ControlToValidate="txUpdateStateProvince" ValidationGroup="groupUpdate"><img src="Images/Required.png" /></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button type="submit" runat="server" CssClass="btn btn-dark btn-lg btn-block login-button" Text="Submit" ID="btnUpdatePhysicianSubmit" ValidationGroup="groupUpdate" OnClick="btnUpdatePhysicianSubmit_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>

    <!-- View Address Modal-->
    <div class="modal fade" id="viewAddressModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#0a5b64, #139aa9); color: white">
                    <h5 class="modal-title">View Address</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="color: white">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label22" runat="server" Text="Address ID"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txViewAddressId" runat="server" Enabled="false" ValidationGroup="groupView"></asp:TextBox>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label23" runat="server" Text="Line 01"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txViewAddressLine1" Enabled="false" runat="server" ValidationGroup="groupView"></asp:TextBox>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label24" runat="server" Text="Line 02"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txViewAddressLine2" Enabled="false" runat="server" ValidationGroup="groupView"></asp:TextBox>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label25" runat="server" Text="Line 03"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txViewAddressLine3" Enabled="false" runat="server" ValidationGroup="groupView"></asp:TextBox>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label26" runat="server" Text="City"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txViewCity" Enabled="false" runat="server" ValidationGroup="groupView"></asp:TextBox>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label27" runat="server" Text="Zip/Post Code"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txViewZipPostCode" Enabled="false" runat="server" ValidationGroup="groupView"></asp:TextBox>
                            </div>
                        </div>
                        &nbsp;
                        <div class="row">
                            <div class="col-sm-5">
                                <asp:Label ID="Label28" runat="server" Text="Province"></asp:Label>
                            </div>
                            <div class="col-sm-7">
                                <asp:TextBox ID="txViewStateProvince" Enabled="false" runat="server" ValidationGroup="groupView"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button class="close" data-dismiss="modal" runat="server" CssClass="btn btn-dark btn-lg btn-block login-button" Text="Close" ID="btnViewClose" ValidationGroup="groupView"></asp:Button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Physician Modal -->
    <div class="modal fade" id="deletePhysicianModal" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-success" style="background: linear-gradient(#0a5b64, #139aa9); color: white">
                    <h5 class="modal-title">Delete Confirmation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete
                    <asp:Label runat="server" ID="lblDeletePhysicianId"></asp:Label>
                    <asp:Label runat="server" ID="lblDeletePhysicianName"></asp:Label>
                    ?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    <asp:Button type="submit" runat="server" CssClass="btn btn-danger" Text="Delete" ID="btnDeletePhysicianSubmit" OnClick="btnDeletePhysicianSubmit_Click"></asp:Button>
                </div>
            </div>
        </div>
    </div>

    <!-- Java Script -->
    <script type="text/javascript">
        function addressValidation() {
            var rbList = document.getElementById("<%=rbListAddress.ClientID%>");
            var rbListItem = rbList.getElementsByTagName('input');
            if (rbListItem[1].checked) {
                document.getElementById("<%=txAddressLine1.ClientID%>").style.display = 'none';
                document.getElementById("<%=txAddressLine2.ClientID%>").style.display = 'none';
                document.getElementById("<%=txAddressLine3.ClientID%>").style.display = 'none';
                document.getElementById("<%=txCity.ClientID%>").style.display = 'none';
                document.getElementById("<%=txZipPostCode.ClientID%>").style.display = 'none';
                document.getElementById("<%=txStateProvince.ClientID%>").style.display = 'none';

                document.getElementById("<%=lblAddressLine1.ClientID%>").style.display = 'none';
                document.getElementById("<%=lblAddressLine2.ClientID%>").style.display = 'none';
                document.getElementById("<%=lblAddressLine3.ClientID%>").style.display = 'none';
                document.getElementById("<%=lblCity.ClientID%>").style.display = 'none';
                document.getElementById("<%=lblZipPostCode.ClientID%>").style.display = 'none';
                document.getElementById("<%=lblStateProvince.ClientID%>").style.display = 'none';

                document.getElementById("<%=rfvtxAddressLine1.ClientID%>").style.display = 'none';
                document.getElementById("<%=rfvtxAddressLine2.ClientID%>").style.display = 'none';
                document.getElementById("<%=rfvtxAddressLine3.ClientID%>").style.display = 'none';
                document.getElementById("<%=rfvtxCity.ClientID%>").style.display = 'none';
                document.getElementById("<%=rfvtxZipPostCode.ClientID%>").style.display = 'none';
                document.getElementById("<%=rfvtxStateProvince.ClientID%>").style.display = 'none';

                document.getElementById("<%=rfvddAddress.ClientID%>").enabled = true;
                document.getElementById("<%=rfvddAddress.ClientID%>").style.display = '';

                document.getElementById("<%=rfvtxAddressLine1.ClientID%>").enabled = false;
                document.getElementById("<%=rfvtxAddressLine2.ClientID%>").enabled = false;
                document.getElementById("<%=rfvtxAddressLine3.ClientID%>").enabled = false;
                document.getElementById("<%=rfvtxCity.ClientID%>").enabled = false;
                document.getElementById("<%=rfvtxZipPostCode.ClientID%>").enabled = false;
                document.getElementById("<%=rfvtxStateProvince.ClientID%>").enabled = false;

                document.getElementById("<%=ddAddress.ClientID%>").disabled = false;
                document.getElementById("<%=txNewAddressId.ClientID%>").style.color = "#eeeded";
            }
            else {
                document.getElementById("<%=txAddressLine1.ClientID%>").style.display = '';
                document.getElementById("<%=txAddressLine2.ClientID%>").style.display = '';
                document.getElementById("<%=txAddressLine3.ClientID%>").style.display = '';
                document.getElementById("<%=txCity.ClientID%>").style.display = '';
                document.getElementById("<%=txZipPostCode.ClientID%>").style.display = '';
                document.getElementById("<%=txStateProvince.ClientID%>").style.display = '';

                document.getElementById("<%=lblAddressLine1.ClientID%>").style.display = '';
                document.getElementById("<%=lblAddressLine2.ClientID%>").style.display = '';
                document.getElementById("<%=lblAddressLine3.ClientID%>").style.display = '';
                document.getElementById("<%=lblCity.ClientID%>").style.display = '';
                document.getElementById("<%=lblZipPostCode.ClientID%>").style.display = '';
                document.getElementById("<%=lblStateProvince.ClientID%>").style.display = '';

                document.getElementById("<%=rfvtxAddressLine1.ClientID%>").style.display = '';
                document.getElementById("<%=rfvtxAddressLine2.ClientID%>").style.display = '';
                document.getElementById("<%=rfvtxAddressLine3.ClientID%>").style.display = '';
                document.getElementById("<%=rfvtxCity.ClientID%>").style.display = '';
                document.getElementById("<%=rfvtxZipPostCode.ClientID%>").style.display = '';
                document.getElementById("<%=rfvtxStateProvince.ClientID%>").style.display = '';

                document.getElementById("<%=rfvddAddress.ClientID%>").enabled = false;
                document.getElementById("<%=rfvddAddress.ClientID%>").style.display = 'none';

                document.getElementById("<%=rfvtxAddressLine1.ClientID%>").enabled = true;
                document.getElementById("<%=rfvtxAddressLine2.ClientID%>").enabled = true;
                document.getElementById("<%=rfvtxAddressLine3.ClientID%>").enabled = true;
                document.getElementById("<%=rfvtxCity.ClientID%>").enabled = true;
                document.getElementById("<%=rfvtxZipPostCode.ClientID%>").enabled = true;
                document.getElementById("<%=rfvtxStateProvince.ClientID%>").enabled = true;

                document.getElementById("<%=ddAddress.ClientID%>").selectedIndex = 0;
                document.getElementById("<%=ddAddress.ClientID%>").disabled = true;
                document.getElementById("<%=txNewAddressId.ClientID%>").style.color = "Gray";
            }
        }
    </script>
</asp:Content>
