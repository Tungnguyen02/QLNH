<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Food.User.Contact" %>
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
      <!-- book section -->
  <section class="book_section layout_padding">
    <div class="container">
      <div class="heading_container">
          <div class="align-self-end">
                    <asp:Label runat="server" ID="lblMsg" ></asp:Label>
                </div>
        <h2>
         Đóng góp ý kiến
        </h2>
      </div>
      <div class="row">
        <div class="col-md-6">
          <div class="form_container">
           
              <div>
                
                  <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Họ và Tên"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is requierd" ControlToValidate ="txtName"
                      ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
              </div>

              <div>
                  <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                  <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is requierd" ControlToValidate ="txtEmail"
                      ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
               
              </div>
              <div>
               
                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Chủ Đề"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvSubject" runat="server" ErrorMessage="Subject is requierd" ControlToValidate ="txtSubject"
                      ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
              </div>
              <div>
                     <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" placeholder="Nội Dung"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="rfvMessage" runat="server" ErrorMessage="Subject is requierd" ControlToValidate ="txtMessage"
                      ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
              </div>
             
              <div class="btn_box">
                  <asp:Button ID="btnSubmit" runat="server" Text="Gửi" CssClass ="btn btn-warning rounded-pill pl-4 pr-4 text-white"
                    OnClick="btnSubmit_Click" />
              </div>
           
          </div>
        </div>
         <div class="col-md-6">
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3918.420664029547!2d106.78252777475284!3d10.855574789298046!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3175276e7ea103df%3A0xb6cf10bb7d719327!2sThu%20Duc%20Campus%20Hutech%20khu%20E!5e0!3m2!1svi!2s!4v1686894389091!5m2!1svi!2s" width="600" height="434" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
       </div>
         <%--    <div class="col-md-6">
          <div class="map_container ">
            <div id="googleMap"></div>
          </div>
        </div>--%>
      </div>
    </div>
  </section>
  <!-- end book section -->

</asp:Content>
