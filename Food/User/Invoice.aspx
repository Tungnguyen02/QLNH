<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Invoice.aspx.cs" Inherits="Food.User.Invoice" %>
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

    <section class="book_section layout_padding">

        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                        <asp:Label ID="lblMsg" runat="server" Visible="false" ></asp:Label>

                </div>
            </div>
          </div>


         <div class="container">
             <asp:Repeater  ID="rOrderItem" runat ="server">
                 <HeaderTemplate>
                     <table class="table table-responsive-sm table-bordered table-hover" id="tblInvoice">
                         <thead class="bg-dark text-white">
                             <tr>
                                 <th>Số Thứ Tự</th>
                                 <th>Mã Hiệu Đơn</th>
                                 <th>Tên Món</th>
                                 <th>Đơn Giá </th>
                                 <th>Số Lượng</th>
                                 <th>Tổng Tiền</th>
                             </tr>
                         </thead>
                         <tbody>
                    
                 </HeaderTemplate>
                 <ItemTemplate>
                     <tr>
                         <td> <%# Eval("Srno") %></td>
                          <td> <%# Eval("OrderNo") %></td>
                          <td> <%# Eval("Name") %></td>
                          <td>
                              <%# string.IsNullOrEmpty( Eval("Price").ToString() ) ? "" : Eval("Price") + " VND" %>
                          </td> 
                          <td> <%# Eval("Quantity") %></td>                    
                          <td> <%# Eval("TotalPrice") %> VND</td>
                          
                     </tr>
                     
                 </ItemTemplate>
                 <FooterTemplate>
                     </tbody>
                     </table>
                 </FooterTemplate>
             </asp:Repeater>

             <div class="text-center">
                 <asp:LinkButton ID ="lbDowloadInvoice" runat="server" Css="btn btn-info"
                     OnClick="lbDowloadInvoice_Click">
                     <i class="fa fa-file-pdf-o mr-2"></i>Download Hóa Đơn
                 </asp:LinkButton>

             </div>

         </div>
     </section>


</asp:Content>
