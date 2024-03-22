<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Food.User.Profile" %>

<%@ Import Namespace="Food" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <%
        string imageUrl = Session["imageUrl"].ToString();
    %>


    <section class="book_sesion layout_padding"> 
        <div class="container">
            <div class="heading_container">

                <h2>Thông tin  User</h2>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-body">
                            <div class="card-title mb-4">
                                <div class="d-flex justify-content-start">
                                    <div class="image-container">
                                        <img src="<%= Food.Utils.GetImageUrl(imageUrl) %>" id="imgProfile" style="width:150px;height:150px;"
                                            class="img-thumbnail"/>
                                        <div class="middle pt-2">
                                            <a href="Registration.aspx?id=<%Response.Write(Session["userId"]); %>" class ="btn btn-warning">
                                                <i class="fa fa-pencil"></i> Sửa User
                                            </a>

                                        </div>
                                    </div>

                                    <div class="userData ml-3">
                                        <h2 class="d-block" style="font-size: 1.5rem; font-weight: bold">
                                            <a href="javascript:void(0);"> Họ Tên: <%Response.Write(Session["name"]); %></a>
                                        </h2>
                                        <h6 class="d-block">
                                            <a href="javascript:void(0)">
                                                <asp:Label ID="lblUsername" runat="server" ToolTip="Unique Username">
                                                    Tên: <%Response.Write(Session["username"]); %>
                                                </asp:Label>
                                            </a>
                                        </h6>
                                         <h6 class="d-block">
                                            <a href="javascript:void(0)">
                                                <asp:Label ID="lblEmail" runat="server" ToolTip="User Email">
                                                    Email: <%Response.Write(Session["email"]); %>
                                                </asp:Label>
                                            </a>
                                        </h6>
                                          <h6 class="d-block">
                                            <a href="javascript:void(0)">
                                                <asp:Label ID="lblCreatedDate" runat="server" ToolTip="Account Create on">
                                                    Thời Gian: <%Response.Write(Session["createdDate"]); %>
                                                </asp:Label>
                                            </a>
                                        </h6>

                                    </div> 

                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <ul class=" nav nav-tabs mb-4" id="myTab" role="tablist">
                                        <li class="nav-item">
                                            <a class="nav-link active text-info" id ="basicInfo-tab" data-toggle="tab" href="#basicInfo" role="tab"
                                                aria-control="basicInfo" aria-selected="true"> <i class="fa fa-id-badge mr-2"></i>Thông Tin</a>
                                             
                                        </li>
                                          <li class="nav-item">
                                            <a class="nav-link  text-info" id ="connectedServices-tab" data-toggle="tab" href="#connectedServices"
                                                role="tab"
                                                aria-control="connectedServices" aria-selected="false"> 
                                                <i class="fa fa-clock-o mr-2"></i>Lịch Sử Mua Hàng</a>
                                             
                                        </li>

                                    </ul>

                                    <div class="tab-content ml-1 " id="myTabContent">
                                        <%--Basic User Info Starts--%>
                                        <div class="tab-pane fade show active " id="basicInfo" role="tabpanel" aria-labelledby="basicInfo-tab">
                                            <asp:Repeater ID="rUserProfile" runat="server">
                                                <ItemTemplate>
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight:bold;">Họ Và Tên</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Name") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                     <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight:bold;"> Tên</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Username") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight:bold;">Số Điện Thoại</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Mobile") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                     <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight:bold;">Email</label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Email") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                     <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight:bold;"> Mã Zip </label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("PostCode") %>
                                                        </div>
                                                    </div>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-sm-3 col-md-2 col-5">
                                                            <label style="font-weight:bold;"> Địa Chỉ </label>
                                                        </div>
                                                        <div class="col-md-8 col-6">
                                                            <%# Eval("Address") %>
                                                        </div>
                                                    </div>
                                                    <hr />

                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                         <%--Basic User Info Ends--%>

                                       <%-- Order History Starts--%>
                                        <div class="tab-pane fade" id="connectedServices" role="tabpanel" aria-labelledby="connectedServices-tab">
                                           
                                            <asp:Repeater ID="rPurchaseHistory" runat="server" OnItemDataBound="rPurchaseHistory_ItemDataBound">
                                                <ItemTemplate>
                                                    <div class="container">
                                                        <div class="row pt-1 pb-1" style="background-color:lightgray">
                                                            <div class="col-4">
                                                                <span class="badge badge-pill badge-dark text-white">
                                                                    <%# Eval("SrNo") %>
                                                                </span>
                                                                Hình Thức Thanh Toán: <%# Eval("PaymentMode").ToString() == "cod" ? "Thanh Toán Khi Nhận Hàng" : Eval("PaymentMode").ToString().ToUpper() %>

                                                            </div>
                                                            <div class="col-6">
                                                                <%# string.IsNullOrEmpty( Eval("CardNo").ToString()) ? "" : "Số Thẻ: " + Eval("CardNo") %>
                                                            </div>
                                                            <div class="col-2" style="text-align:end">
                                                                <a href="Invoice.aspx?id=<%# Eval("PaymentId") %>" class="btn btn-info btn-sm">
                                                                    <i class="fa fa-download mr-2"></i> Hóa Đơn</a>
                                                            </div>
                                                        </div>
                                                        <asp:HiddenField ID="hdnPaymentId" runat="server" Value='<%# Eval("PaymentId") %>'/>

                                                        <asp:Repeater ID="rOrders" runat="server">
                                                            <HeaderTemplate>
                                                                <table class="table data-table-export table-responsive-sm table-bordered table-hover">
                                                                    <thead class="bg-dark text-white" >
                                                                        <tr>
                                                                            <th>Tên Món</th>
                                                                            <th>Đơn Giá</th>
                                                                            <th>Số Lượng</th>
                                                                            <th>Tổng Tiền</th>
                                                                            <th>Mã Đơn</th>
                                                                            <th>Trạng Thái</th>                                                                          
                                                                        </tr>  
                                                                      </thead>
                                                                    <tbody>
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblPrice" runat="server" Text='<%# string.IsNullOrEmpty( Eval("Price").ToString()) ? "" : Eval("Price") + " VND" %>' ></asp:Label> 
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblTotalPrice" runat="server" Text='<%# Eval("TotalPrice") %>'></asp:Label> VND
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblOrderNo" runat="server" Text='<%# Eval("OrderNo") %>'></asp:Label>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'
                                                                             CssClass='<%# Eval("Status").ToString() == "Ðã Giao" ? "badge badge-success" : "badge badge-warning" %>'></asp:Label>

                                                                           
                                                                    </td>
                                                                </tr>
                                                               
                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                              
                                                                </tbody>
                                                                </table>
                                                            </FooterTemplate>
                                                        </asp:Repeater>

                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>

                                        </div>
                                        <%-- Order History End--%>

                                    </div>

                                </div>

                            </div>

                        </div>
                    </div>
                </div>

            </div>

        </div>
    </section>



</asp:Content>
