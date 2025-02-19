﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Food.User.Registration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

     <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";

            }, seconds * 1000);

        };
    </script>
    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgUser.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>


    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="book_section layout_padding">
        <div class="container">
            <div class="heading_container">
                <div class="align-self-end">
                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>
                <asp:Label ID="lblHeaderMsg" runat="server" Text="<h2>Đăng Ký Người Dùng</h2>"></asp:Label>
            </div>
            <div class="row">

                <div class="col-md-6">
                    <div class="form_container">

                        <div>
                           
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revName" runat="server" ErrorMessage="Tên chỉ được kí tự"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z\s]+$"
                                ControlToValidate="txtName"></asp:RegularExpressionValidator>
                             <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Nhập Học Và Tên"
                                Tooltip="Full Name"></asp:TextBox>
                        </div>

                         <div>
                            <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ErrorMessage="UserName is required" 
                                ControlToValidate="txtUserName" ForeColor="Red" Display="Dynamic" ></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control" placeholder="Nhập Tên Tài Khoản "
                                Tooltip="UserName"></asp:TextBox>
                        </div>

                         <div>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is required" 
                                ControlToValidate="txtEmail" ForeColor="Red" Display="Dynamic" ></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Nhập Email "
                                Tooltip="Email" TextMode="Email"></asp:TextBox>
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Mobile No is required"
                                ControlToValidate="txtMobile" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revMobile" runat="server" ErrorMessage="Số điện thọai phải đủ 10 số"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{10}$"
                                ControlToValidate="txtMobile"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Nhập Số Điện Thoại"
                                Tooltip="Mobile Number" TextMode="Number"></asp:TextBox>
                        </div>

                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form_container">

                         <div>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                                ErrorMessage="Address is required" ControlToValidate="txtAddress"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Nhập Địa Chỉ"
                                Tooltip="Address" TextMode="MultiLine"></asp:TextBox>
                     
                        </div>

                         <div>
                            <asp:RequiredFieldValidator ID="rfvPostCode" runat="server" ErrorMessage="Post/Zip Code is required" 
                                ControlToValidate="txtPostCode" ForeColor="Red" Display="Dynamic" ></asp:RequiredFieldValidator>
                             <asp:RegularExpressionValidator ID="revPostCode" runat="server" ErrorMessage="Post/Mã Zip phải có 5 chữ số"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{5}$"
                                ControlToValidate="txtPostCode"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtPostCode" runat="server" CssClass="form-control" placeholder="Nhập Mã Zip "
                                Tooltip="Post/Zip Code" TextMode="Number"></asp:TextBox>
                        </div>

                         <div>
                           <asp:FileUpload ID="fuUserImage" runat="server" CssClass="form-control" ToolTip="User Image" 
                               omchange="ImagePreview(this);" />
                        </div>

                        <div>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is required"
                                ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Nhập Mật Khẩu"
                                Tooltip="Password " TextMode="Password" ></asp:TextBox>
                        </div>

                    </div>
                </div>

                <div class="row pl-4">
                    <div class="btn_box">
                        <asp:Button ID="btnRegister" runat="server" Text="Đăng Ký" CssClass="btn btn-success rounded-pill pl-4 pr-4 text-white"
                            onClick="btnRegister_Click"/>
                        <asp:Label ID="lblAlreadyUser" runat="server" CssClass="pl-3 text-black-100"
                            Text="<a href='Login.aspx'>Đăng Nhập..</a>">
                        </asp:Label>
                    </div>
                </div>

                <div class="row p-5">
                    <div style="align-items:center">
                         <asp:Image ID="imgUser" runat="server" CssClass="img-thumbnail" />
                    </div>

                </div>

            </div>
        </div>
    </section>




</asp:Content>
