using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Food.Admin;



namespace Food.User
{
    public partial class Menu : System.Web.UI.Page
    {

        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)//kiểm tra xem trang có được tải lên lần đầu tiên (IsPostBack = false) hay không
            {
                getCategories();
                getProducts();
                
            }
        }

       private void getCategories()//truy vấn danh sách các danh mục sản phẩm từ cơ sở dữ liệu
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Category_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "ACTIVECAT");//gọi Stored Procedure có tên là "Category_Crud" với tham số Action được thiết lập là "ACTIVECAT".
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);//lấy dữ liệu từ cơ sở dữ liệu và lưu vào đối tượng DataTable.
            dt = new DataTable();
            sda.Fill(dt);
            rCategory.DataSource = dt;// danh sách các danh mục sản phẩm được gán cho đối tượng Repeater Control rCategory bằng cách thiết lập thuộc tính DataSource
            rCategory.DataBind();//hiển thị trên trang bằng phương thức DataBind


        }

        private void getProducts()
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "ACTIVEPROD");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rProducts.DataSource = dt;
            rProducts.DataBind();


        }

        protected void rProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (Session["userId"] != null)//kiểm tra xem người dùng đã đăng nhập hay chưa
            {
                bool isCartItemUpdated = false;
                int i = isItemExistIntCart(Convert.ToInt32(e.CommandArgument));//kiểm tra xem sản phẩm đã tồn tại trong giỏ hàng
                if (i == 0)
                {
                    //Adding new item in cart
                    con = new SqlConnection(Connetion.GetConnectionString());
                    cmd = new SqlCommand("Cart_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "INSERT");//thêm một mục mới vào giỏ hàng bằng cách gọi Stored Procedure "Cart_Crud" với tham số Action được thiết lập là "INSERT".
                    cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@Quantity", 1);
                    cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error - " + ex.Message + "');<script>");
                    }
                    finally
                    {
                        con.Close();
                    }
                }
                else
                {
                    // Adding existing item into cart
                    Food.Utils utils = new Food.Utils();//đã tồn tại trong giỏ hàng, phương thức sẽ cập nhật số lượng sản phẩm trong giỏ hàng bằng cách gọi phương thức updateCartQuantity() từ lớp Utils.
                    isCartItemUpdated = utils.updateCartQuantity(i + 1, Convert.ToInt32(e.CommandArgument), Convert.ToInt32(Session["userId"]));

                }
                lblMsg.Visible = true;
                lblMsg.Text = "Thêm Vào Giỏ Hàng Thành Công!";
                lblMsg.CssClass = "alert alert-success";
                Response.AddHeader("REFRESH", "1;URL=Cart.aspx");//làm mới sau một giây để chuyển đến trang giỏ hàng
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }


   


        int isItemExistIntCart(int productId)//kiẻm tra sp có tồn tại trong giỏ hàng hay khong
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYID");// gọi Stored Procedure có tên là "Cart_Crud" với tham số Action được thiết lập là "GETBYID"
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);//lấy thông tin về số lượng sản phẩm trong giỏ hàng của người dùng và sản phẩm được yêu cầu.
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);//lấy dữ liệu từ cơ sở dữ liệu và lưu vào đối tượng DataTable.
            dt = new DataTable();
            sda.Fill(dt);
            int quantity = 0;
            if(dt.Rows.Count >0)
            {
                quantity = Convert.ToInt32(dt.Rows[0]["Quantity"]);
            }
            return quantity;
        }




      


    }
}