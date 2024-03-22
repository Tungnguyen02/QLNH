using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Food.Connetion;

namespace Food.Admin
{
    public partial class Category : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)//Nếu đây là lần đầu tiên trang được tải (IsPostBack = false), thì nó sẽ đặt giá trị của biến Session "breadCrum" thành "Category
            {
                //Session["breadCrum"] = "Category";// kiểm tra xem người dùng đã đăng nhập hay chưa.
                Session["breadCrum"] = "Thể Loại";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    getCategories();
                }
               
            }          
            lblMsg.Visible = false; 
        }
        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;//giá trị rỗng
            bool isValidToExecute = false;
            int categoryId = Convert.ToInt32(hdnId.Value);//thuộc tính giấu kín hdnId của trang và chuyển đổi sang kiểu int.
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Category_Crud", con);//đối tượng SqlCommand cũng được tạo và được gọi Stored Procedure có tên là "Category_Crud"
            cmd.Parameters.AddWithValue("@Action", categoryId == 0 ? "INSERT" : "UPDATE");//thêm mới,cập nhật tùy vào giá trị id
            cmd.Parameters.AddWithValue("@CategoryId", categoryId);
            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
            if(fuCategoryImage.HasFile)//kiểm tra xem tệp có hợp lệ hay k
            {
                if(Utils.IsValidExtension(fuCategoryImage.FileName))
                {
                    Guid obj  = Guid.NewGuid();
                    fileExtension = Path.GetExtension(fuCategoryImage.FileName);
                    imagePath = "Images/Category/" + obj.ToString()+ fileExtension;
                    fuCategoryImage.PostedFile.SaveAs(Server.MapPath("~/Images/Category/") + obj.ToString() + fileExtension);//nếu hớp lệ sử dụng phương thức SaveAs để lưu
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath); //lưu vào imagePath và truyền vào tham số ImageUrl của Stored Procedure
                    isValidToExecute = true;//sValidToExecute cũng được thiết lập thành true để cho phép thực thi Stored Procedure.

                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Please select .jpg, .jpeg or .png image";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExecute = false;

                }   
            }
            else// không chọn tệp hình ảnh
            {
                isValidToExecute = true;
            }

            if (isValidToExecute)
            {                
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = categoryId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Cập Nhật Thành Công!";//Nếu thực thi thành công, một thông báo sẽ được hiển thị cho người dùng
                    lblMsg.CssClass = "alert alert-success";
                    getCategories();//hiển thị
                    clear();


                }
                catch(Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error -" + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";

                }
                finally
                {
                    con.Close();
                }

            }



        }

        private void getCategories()//lấy danh sách các danh mục sản phẩm từ cơ sở dữ liệu
        {
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Category_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");//gọi Stored Procedure có tên là "Category_Crud" với tham số Action được thiết lập là "SELECT"
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);//SqlDataAdapter được tạo để lấy dữ liệu từ cơ sở dữ liệu.
            dt = new DataTable();//lưu vào đối tượng DataTable
            sda.Fill(dt);
            rCategory.DataSource = dt;//thuộc tính DataSource và được ràng buộc với các điều khiển trên trang bằng phương thức DataBind.
            rCategory.DataBind();


        }

        private void clear()
        {
            txtName.Text = string.Empty;//xóa txtName bằng cách thiết lập giá trị của nó thành chuỗi rỗng
            cbIsActive.Checked = false;//kiểm tra chọn cbIsActive được thiết lập thành false để bỏ chọn
            hdnId.Value = "0";
            btnAddOrUpdate.Text = "Add";
            imgCategory.ImageUrl = String.Empty;
        }
        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();

        }
       
        protected void rCategory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            lblMsg.Visible = false;//ẩn thông báo lblMsg trên trang
            con = new SqlConnection(Connetion.GetConnectionString());// kết nối trong lớp Connection
            if (e.CommandName == "edit")
            {
                //con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("Category_Crud", con);
                cmd.Parameters.AddWithValue("@Action",  "GETBYID");//gọi Stored Procedure có tên là "Category_Crud" với tham số Action được thiết lập là "GETBYID"
                cmd.Parameters.AddWithValue("@CategoryId",e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtName.Text = dt.Rows[0]["Name"].ToString();//hiển thị tên của danh mục sản phẩm
                cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);// kích hoạt của danh mục sản phẩm
                imgCategory.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ?
                        "../Images/No_image.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();//hiển thị hình ảnh của danh mục sản phẩm nếu có
                imgCategory.Height = 200;
                imgCategory.Width = 200;
                hdnId.Value = dt.Rows[0]["CategoryId"].ToString();// lưu trữ mã danh mục sản phẩm được chọn
                btnAddOrUpdate.Text = "Update";
                LinkButton btn = e.Item.FindControl("lnkEdit") as LinkButton;
                btn.CssClass = "badge badge-warning";
            
            
            }
            else if (e.CommandName == "delete")
            {
                //con = new SqlConnection(Connetion.GetConnectionString());
                cmd = new SqlCommand("Category_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@CategoryId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Đã xóa danh mục thành công!";//thành công thông báo
                    lblMsg.CssClass = "alert alert-success";
                    getCategories();//hiển thị lại trên trang
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error-" + ex.Message;
                    lblMsg.CssClass = "alert alert-success";
                }
                finally
                {
                    con.Close();
                }
            }
            
        }
        protected void rCategory_ItemDataBound(object sender, RepeaterItemEventArgs e)//sử dụng để thay đổi hiển thị của điều khiển Label
        {
           if(e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lbl = e.Item.FindControl("lblIsActive") as Label;//Đối tượng Label được tìm kiếm bằng cách sử dụng phương thức FindControl và được lưu trữ trong biến lbl
                if (lbl.Text == "True")
                {
                    lbl.Text = "Hoạt Động";
                    lbl.CssClass = "badge badge-success";

                }
                else
                {
                    lbl.Text = "Không Hoạt Động";
                    lbl.CssClass = "badge badge-danger";
                }
            }


        }

    }
}