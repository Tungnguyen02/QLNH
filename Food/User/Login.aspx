<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Food.User.Login" %>
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

    <section class="book_sesion layout_padding">
            <div class ="container">
                <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label runat="server" ID="lblMsg" ></asp:Label>
                </div>
                <h2>Đăng Nhập</h2>
            </div>
                <div class="row">
                    <div class="col-md-6">
                        <div class="form_container">
                            <img id="userLogin" src="../Images/login.jpg" alt="" class="img-thumbnail"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                            <div class="form_container">
                                <div>
                                    <label for="rfvUsername">Tên Đăng Nhập</label>
                                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Username is required"
                                        ControlTovalidate="txtUsername" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Size="Small"></asp:RequiredFieldValidator>
                                     <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placehoder="Enter Username"></asp:TextBox>
                                </div>
                                <br />
                                <div>
                                    <label for="RequiredFieldValidator1">Mật Khẩu</label>                                   
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="password id required"
                                        ControlTovalidate="txtPassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"  Font-Size="Small"></asp:RequiredFieldValidator>
                                     <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placehoder="Enter Password" TextMode="Password"></asp:TextBox>
                                </div>
                                <br />
                                <div class="btn_box">
                                    <asp:Button ID="btnLogin" runat="server" Text="Đăng Nhập" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white" 
                                        Onclick="btnLogin_Click"/>

                                    <span class="pl-3 text-info"><a href="Registration.aspx">Đăng Ký...</a> </span>

                                </div>
                            </div>
                    </div>
                 </div>
            </div>
    </section>

</asp:Content>
