<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="OrderStatus.aspx.cs" Inherits="Food.Admin.OrderStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <script>
         window.onload = function () {
             var seconds = 5;
             setTimeout(function () {
                 document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";

            }, seconds * 1000);

         };
     </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pcoded-inner-content pt-0">
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false" ></asp:Label>
        </div>
        <div class="main-body">
            <div class="page-wrapper">

                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">
                                        <div class="col-sm-6 col-md-8 col-lg-8">
                                            <h4 class="sub-title">Danh Sách Đặt Hàng</h4>

                                             <div class ="card-block table-border-style">
                                                 <div class="table-responsive">

                                                     <asp:Repeater ID="rOrderStatus" runat="server"  OnItemCommand="rOrderStatus_ItemCommand">
                                                         <HeaderTemplate>
                                                             <table class="table data-table-export table-hover nowrap" >
                                                                 <thead>
                                                                 <tr>
                                                                     <th class="table-plus">Mã Đơn</th>
                                                                     <th>Ngày Đặt</th>
                                                                     <th>Trạng Thái</th>
                                                                     <th>Tên Món</th>
                                                                     <th>Tổng Tiền</th>
                                                                     <th>Hình Thức Thanh Toán:</th>
                                                                     <th class="datatable-nosort">Edit</th>
                                                                 </tr>
                                                                 </thead>
                                                             <tbody>
                                                         </HeaderTemplate>
                                                         <ItemTemplate>
                                                             <tr>
                                                                 <td class="table-plus"><%# Eval("OrderNo") %></td>
                                                                 <td> <%# Eval("OrderDate") %> </td>
                                                                 <td>
                                                                     <asp:Label ID="lblStatus" runat="server" text='<%# Eval("Status") %>' 
                                                                         CssClass='<%# Eval("Status").ToString() == "Ðã Giao" ? "badge badge-success" : "badge badge-warning" %>'>

                                                                     </asp:Label>
                                                                  </td>
                                                                 <td><%# Eval("Name") %></td>
                                                                 <td><%# Eval("TotalPrice") %> VND</td>
                                                                 <td><%# Eval("PaymentMode") %></td>
                                                                 <td>
                                                                     <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CssClass="badge badge-primary"
                                                                         CommandArgument='<%# Eval("OrderDetailsId") %>' CommandName="edit">
                                                                            <i class="ti-pencil"></i>
                                                                     </asp:LinkButton>
                                                                 </td>
                                                             </tr>
                                                         </ItemTemplate>
                                                         <FooterTemplate>
                                                             </tbody>
                                                             </table>

                                                         </FooterTemplate>
                                                     </asp:Repeater>
                                                 </div>

                                             </div>

                                           

                                        </div>

                                         <div class="col-sm-6 col-md-4 col-lg-4 mobile-inputs">
                                              <asp:Panel ID="pUpdateOrderStatus" runat="server">
                                               <h4 class="sub-title">Cập Nhật Trạng Thái</h4>
                                               <div>
                                                <div class="form-group">
                                                    <label>Tình Trạng</label>
                                                    <div>
                                                        <asp:DropDownList ID="ddlOrderStatus" runat="server" CssClass="form-control">
                                                            <asp:ListItem Value="0">Chọn trạng thái </asp:ListItem>
                                                            <asp:ListItem>Chua Giao</asp:ListItem>
                                                            <asp:ListItem>Đang Giao</asp:ListItem>
                                                            <asp:ListItem>Ðã Giao</asp:ListItem>
                                                        </asp:DropDownList>
                                                          <asp:RequiredFieldValidator ID="rfvDdlOrderStatus" runat="server" ForeColor="Red" ControlToValidate="ddlOrderStatus"
                                                              Errormessage="Trạng thái đơn hàng là bắt buộc" SetFocusOnError="true" Display="Dynamic" InitialValue="0"></asp:RequiredFieldValidator>
                                                            <asp:HiddenField ID="hdnId" runat="server" Value="0" />
                                                        
                                                    </div>
                                                </div>
                                               
                                                <div class="pb-5">
                                                    <asp:Button ID="btnUpdate" runat="server" Text="Cập nhật" CssClass="btn btn-primary"
                                                        OnClick="btnUpdate_Click"/>
                                                    &nbsp;
                                                    <asp:Button ID="btnCancel" runat="server" Text="Hủy" CssClass="btn btn-primary" 
                                                    OnClick="btnCancel_Click"/>

                                                </div>
                                                <div>
                                                    <asp:Image ID="imgCategory" runat="server" CssClass="img-thumbnail" />
                                                </div>

                                            </div>
                                              </asp:Panel>                                                                                                                                                                          
                                         </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>

    </div>

</asp:Content>
