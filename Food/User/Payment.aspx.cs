using Org.BouncyCastle.Asn1.X9;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Security.Policy;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using VNPAY_CS_ASPX;
using static Food.Connetion;
using static iTextSharp.text.pdf.AcroFields;

namespace Food.User
{





    public partial class Payment : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader dr, dr1;
        DataTable dt;
        SqlTransaction transaction = null;
        string _name = string.Empty; string _cardNo = string.Empty; string _expiryDate = string.Empty;
        string _cvv = string.Empty; string _address = string.Empty; string _paymentMode = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)//kiểm tra xem trang có được tải lên lần đầu tiên (IsPostBack = false) hay không
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }


        protected void lbCardSubmit_Click(object sender, EventArgs e)//thanh toán bằng thẻ
        {
            _name = txtName.Text.Trim();
            _cardNo = txtCardNo.Text.Trim();
            _cardNo = string.Format("************{0}", txtCardNo.Text.Trim().Substring(12, 4));//hiển thị 12 chữ số đầu tiên của số thẻ và chỉ hiển thị 4 chữ số cuối cùng
            _expiryDate = txtExpMonth.Text.Trim() + "/" + txtExpYear.Text.Trim();
            _cvv = txtCvv.Text.Trim();
            _address = txtAddress.Text.Trim();
            _paymentMode = "card";
            if (Session["userId"] != null)
            {
                OrderPayment(_name, _cardNo, _expiryDate, _cvv, _address, _paymentMode);

            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void lbCodSubmit_Click(object sender, EventArgs e)
        {
            _address = txtCODAddress.Text.Trim();
            _paymentMode = "cod";
            if (Session["userId"] != null)
            {

                string vnp_Returnurl = "http://localhost:52262/User/Cart.aspx"; //URL nhan ket qua tra ve 
                string vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html"; //URL thanh toan cua VNPAY 
                string vnp_TmnCode = "HX4MR722"; //Ma website
                string vnp_HashSecret = "ORHPLOERJVRTGIFHQMWGGDSZPFKDDWZR"; //Chuoi bi mat

                //Build URL for VNPAY
                VnPayLibrary vnpay = new VnPayLibrary();
                vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
                vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
                vnpay.AddRequestData("vnp_IpAddr", "127.0.0.1");
                vnpay.AddRequestData("vnp_Version", VnPayLibrary.VERSION);
                vnpay.AddRequestData("vnp_BankCode", "NCB");
                vnpay.AddRequestData("vnp_CurrCode", "VND");
                vnpay.AddRequestData("vnp_Command", "pay");
                vnpay.AddRequestData("vnp_Locale", "vn");
                vnpay.AddRequestData("vnp_OrderType", "Thanh toan online"); //default value: other

                Console.WriteLine(Session["grandTotalPrice"]);
                vnpay.AddRequestData("vnp_Amount", (Convert.ToDecimal(Session["grandTotalPrice"].ToString().Replace(",", "."))).ToString()); //Số tiền thanh toán. Số tiền không mang các ký tự phân tách thập phân, phần nghìn, ký tự tiền tệ. Để gửi số tiền thanh toán là 100,000 VND (một trăm nghìn VNĐ) thì merchant cần nhân thêm 100 lần (khử phần thập phân), sau đó gửi sang VNPAY là: 10000000
                vnpay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss"));
                vnpay.AddRequestData("vnp_TxnRef", DateTime.Now.Ticks.ToString()); // Mã tham chiếu của giao dịch tại hệ thống của merchant. Mã này là duy nhất dùng để phân biệt các đơn hàng gửi sang VNPAY. Không được trùng lặp trong ngày
                vnpay.AddRequestData("vnp_OrderInfo", "Thanh toan don hang:" + DateTime.Now.Ticks);

                string paymentUrl = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);

                Response.Redirect(paymentUrl);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        public void OrderPayment(string name, string cardNo, string expiryDate, string cvv, string address, string paymentMode)
        {
            int paymentId; int productId; int quantity;
            dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[7] {
                new DataColumn("OrderNo", typeof(string)),
                new DataColumn("ProductId", typeof(int)),
                new DataColumn("Quantity", typeof(int)),
                new DataColumn("UserId", typeof(int)),
                new DataColumn("Status", typeof(string)),
                new DataColumn("PaymentId", typeof(int)),
                new DataColumn("OrderDate", typeof(DateTime)),
            });
            con = new SqlConnection(Connetion.GetConnectionString());
            con.Open();
            #region Sql Transaction
            transaction = con.BeginTransaction();
            cmd = new SqlCommand("Save_Payment", con, transaction);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@CardNo", cardNo);
            cmd.Parameters.AddWithValue("@ExpiryDate ", expiryDate);
            cmd.Parameters.AddWithValue("@Cvv", cvv);
            cmd.Parameters.AddWithValue("@Address", address);
            cmd.Parameters.AddWithValue("@PaymentMode", paymentMode);
            cmd.Parameters.Add("@InsertedId", SqlDbType.Int);
            cmd.Parameters["@InsertedId"].Direction = ParameterDirection.Output;
            try
            {
                cmd.ExecuteNonQuery();
                paymentId = Convert.ToInt32(cmd.Parameters["@InsertedId"].Value);

                #region Getting Cart Item's
                //con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("Cart_Crud", con, transaction);
                cmd.Parameters.AddWithValue("@Action", "SELECT");
                cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                cmd.CommandType = CommandType.StoredProcedure;
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    productId = (int)dr["ProductId"];
                    quantity = (int)dr["Quantity"];
                    // Update product QUantity
                    //updateQuantity();
                    UpdateQuantity(productId, quantity, transaction, con);
                    //update Priduct Quantity emd

                    //Delete Cart item
                    DeleteCartItem(productId, transaction, con);
                    //delete cart item end

                    dt.Rows.Add(Food.Utils.GetUniqueId(), productId, quantity, (int)Session["userId"], "Chưa Giao",

                        paymentId, Convert.ToDateTime(DateTime.Now));
                }
                dr.Close();
                #endregion Getting Cart Item's

                #region Order Details
                if (dt.Rows.Count > 0)
                {
                    cmd = new SqlCommand("Save_Orders", con, transaction);
                    cmd.Parameters.AddWithValue("@tblOrders", dt);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();
                }

                #endregion Order Details

                transaction.Commit();

                /*                lblMsg.Visible = true;
                                lblMsg.Text = "Đặt Món Thành Công!!";
                                lblMsg.CssClass = "alert alert-success";*/
                // Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?id=" + paymentId);
                // Trong mã code-behind của bạn
            }
            catch (Exception e)
            {
                try
                {
                    transaction.Rollback();

                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('" + ex.Message + "');</script>");
                }
            }
            #endregion Sql Transaction 
            finally
            {
                con.Close();
            }
        }

        //public void order()
        //{
        //    int productId; int quantity;
        //    dt = new DataTable();
        //    dt.Columns.AddRange(new DataColumn[7] {
        //        new DataColumn("OrderNo", typeof(string)),
        //        new DataColumn("ProductId", typeof(int)),
        //        new DataColumn("Quantity", typeof(int)),
        //        new DataColumn("UserId", typeof(int)),
        //        new DataColumn("Status", typeof(string)),
        //        new DataColumn("PaymentId", typeof(int)),
        //        new DataColumn("OrderDate", typeof(DateTime)),
        //    });
        //    con = new SqlConnection(Connetion.GetConnectionString());
        //    con.Open();
        //    #region Sql Transaction
        //    transaction = con.BeginTransaction();
        //    try
        //    {
        //        cmd = new SqlCommand("Cart_Crud", con, transaction);

        //        #region Getting Cart Item's
        //        //con = new SqlConnection(Connetion.GetConnectionString());
        //        cmd.Parameters.AddWithValue("@Action", "SELECT");
        //        cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        dr = cmd.ExecuteReader();
        //        while (dr.Read())
        //        {
        //            productId = (int)dr["ProductId"];
        //            quantity = (int)dr["Quantity"];
        //            // Update product QUantity
        //            //updateQuantity();
        //            UpdateQuantity(productId, quantity, transaction, con);
        //            //update Priduct Quantity emd

        //            //Delete Cart item
        //            DeleteCartItem(productId, transaction, con);
        //            //delete cart item end

        //            dt.Rows.Add(Food.Utils.GetUniqueId(), productId, quantity, (int)Session["userId"], "Chua Giao",

        //                    null, Convert.ToDateTime(DateTime.Now));
        //        }
        //        dr.Close();
        //        #endregion Getting Cart Item's

        //        #region Order Details
        //        if (dt.Rows.Count > 0)
        //        {
        //            cmd = new SqlCommand("Save_Orders", con, transaction);
        //            cmd.Parameters.AddWithValue("@tblOrders", dt);
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.ExecuteNonQuery();
        //        }

        //        #endregion Order Details

        //        transaction.Commit();

        //        /*                lblMsg.Visible = true;
        //                        lblMsg.Text = "Đặt Món Thành Công!!";
        //                        lblMsg.CssClass = "alert alert-success";*/
        //        // Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?id=" + paymentId);
        //        // Trong mã code-behind của bạn
        //    }
        //    catch (Exception e)
        //    {
        //        try
        //        {
        //            transaction.Rollback();

        //        }
        //        catch (Exception ex)
        //        {
        //            Response.Write("<script>alert('" + ex.Message + "');</script>");
        //        }
        //    }
        //    #endregion Sql Transaction 
        //    finally
        //    {
        //        con.Close();
        //    }
        //}

        //void payment(string name, string cardNo, string expiryDate, string cvv, string address, string paymentMode)
        //{
        //    int paymentId; int productId; int quantity;
        //    dt = new DataTable();
        //    dt.Columns.AddRange(new DataColumn[7] {
        //        new DataColumn("OrderNo", typeof(string)),
        //        new DataColumn("ProductId", typeof(int)),
        //        new DataColumn("Quantity", typeof(int)),
        //        new DataColumn("UserId", typeof(int)),
        //        new DataColumn("Status", typeof(string)),
        //        new DataColumn("PaymentId", typeof(int)),
        //        new DataColumn("OrderDate", typeof(DateTime)),
        //    });
        //    con = new SqlConnection(Connetion.GetConnectionString());
        //    con.Open();
        //    #region Sql Transaction
        //    transaction = con.BeginTransaction();
        //    cmd = new SqlCommand("Save_Payment", con, transaction);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    cmd.Parameters.AddWithValue("@Name", name);
        //    cmd.Parameters.AddWithValue("@CardNo", cardNo);
        //    cmd.Parameters.AddWithValue("@ExpiryDate ", expiryDate);
        //    cmd.Parameters.AddWithValue("@Cvv", cvv);
        //    cmd.Parameters.AddWithValue("@Address", address);
        //    cmd.Parameters.AddWithValue("@PaymentMode", paymentMode);
        //    cmd.Parameters.Add("@InsertedId", SqlDbType.Int);
        //    cmd.Parameters["@InsertedId"].Direction = ParameterDirection.Output;
        //    try
        //    {
        //        cmd.ExecuteNonQuery();
        //        paymentId = Convert.ToInt32(cmd.Parameters["@InsertedId"].Value);

        //        #region Getting Cart Item's
        //        //con = new SqlConnection(Connetion.GetConnectionString());
        //        cmd = new SqlCommand("Cart_Crud", con, transaction);
        //        cmd.Parameters.AddWithValue("@Action", "SELECT");
        //        cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        dr = cmd.ExecuteReader();
        //        while (dr.Read())
        //        {
        //            productId = (int)dr["ProductId"];
        //            quantity = (int)dr["Quantity"];
        //            // Update product QUantity
        //            //updateQuantity();
        //            UpdateQuantity(productId, quantity, transaction, con);
        //            //update Priduct Quantity emd

        //            //Delete Cart item
        //            DeleteCartItem(productId, transaction, con);
        //            //delete cart item end

        //            dt.Rows.Add(Food.Utils.GetUniqueId(), productId, quantity, (int)Session["userId"], "Chua Giao",
        //                paymentId, Convert.ToDateTime(DateTime.Now));
        //        }
        //        dr.Close();
        //        #endregion Getting Cart Item's

        //        #region Order Details
        //        if (dt.Rows.Count > 0)
        //        {
        //            cmd = new SqlCommand("Save_Orders", con, transaction);
        //            cmd.Parameters.AddWithValue("@tblOrders", dt);
        //            cmd.CommandType = CommandType.StoredProcedure;
        //            cmd.ExecuteNonQuery();
        //        }

        //        #endregion Order Details

        //        transaction.Commit();
        //        lblMsg.Visible = true;
        //        lblMsg.Text = "Đặt Món Thành Công!!";
        //        lblMsg.CssClass = "alert alert-success";
        //        Response.AddHeader("REFRESH", "1;URL=Invoice.aspx?id=" + paymentId);

        //    }
        //    catch (Exception e)
        //    {
        //        try
        //        {
        //            transaction.Rollback();

        //        }
        //        catch (Exception ex)
        //        {
        //            Response.Write("<script>alert('" + ex.Message + "');</script>");
        //        }

        //    }
        //    #endregion Sql Transaction 
        //    finally
        //    {
        //        con.Close();
        //    }
        //}

        void UpdateQuantity(int _productId, int _quantity, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            int dbQuantity;
            cmd = new SqlCommand("Product_Crud", sqlConnection, sqlTransaction);
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@ProductId", _productId);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                dr1 = cmd.ExecuteReader();
                while (dr1.Read())
                {
                    dbQuantity = (int)dr1["Quantity"];

                    if (dbQuantity > _quantity && dbQuantity > 2)
                    {
                        dbQuantity = dbQuantity - _quantity;
                        cmd = new SqlCommand("Product_Crud", sqlConnection, sqlTransaction);
                        cmd.Parameters.AddWithValue("@Action", "QTYUPDATE");
                        cmd.Parameters.AddWithValue("@Quantity", dbQuantity);
                        cmd.Parameters.AddWithValue("@ProductId", _productId);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();

                    }
                }
                dr1.Close();

            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        void DeleteCartItem(int _productId, SqlTransaction sqlTransaction, SqlConnection sqlConnection)
        {
            cmd = new SqlCommand("Cart_Crud", sqlConnection, sqlTransaction);
            cmd.Parameters.AddWithValue("@Action", "DELETE");
            cmd.Parameters.AddWithValue("@ProductId", _productId);
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

    }
}