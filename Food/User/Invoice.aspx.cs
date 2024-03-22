using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

using iTextSharp.text.pdf;
using iTextSharp.text;
using System.IO;
using System.Net;

namespace Food.User
{
    public partial class Invoice : System.Web.UI.Page
    {

        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
                     

            if (!IsPostBack)//kiểm tra xem trang có đang được load lần đầu tiên
            {
                if (Session["userId"] != null)//kiểm tra xem người dùng đã đăng nhập hay cưaa
                {
                    if (Request.QueryString["id"] != null)//không null
                    {
                        rOrderItem.DataSource = GetOrderDetails();//gọi phương thức GetOrderDetails để lấy chi tiết đơn hàn
                        rOrderItem.DataBind();

                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        DataTable GetOrderDetails()//lấy chi tiết về đơn hàng dựa trên PaymentId và UserId
        {
            double grandTotal = 0;
            con = new SqlConnection(Connetion.GetConnectionString());
            cmd = new SqlCommand("Invoice", con);
            cmd.Parameters.AddWithValue("@Action", "INVOICBYID");// gọi Stored Procedure "Invoice" với tham số Action được thiết lập là "INVOICBYID"
            cmd.Parameters.AddWithValue("@PaymentId", Convert.ToInt32(Request.QueryString["id"]));
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);//SqlDataAdapter được tạo và sử dụng để lấy dữ liệu từ cơ sở dữ liệu và lưu vào đối tượng DataTable
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)//Nếu DataTable có hàng
            {
               foreach(DataRow drow in dt.Rows)
                {
                    grandTotal += Convert.ToDouble(drow["TotalPrice"]);//lấy giá trị trong cột TotalPrice của mỗi hàng và cộng dồn vào grandTotal.
                }
            }

            DataRow dr = dt.NewRow();
            dr["TotalPrice"] = grandTotal; //thiết lập giá trị của cột TotalPrice là tổng giá trị đơn hàng
            dt.Rows.Add(dr);//
            return dt;
        }

        protected void lbDowloadInvoice_Click(object sender, EventArgs e)
        {
            try
            {
                string downloadPath = @"E:\LTW\HOADONN.pdf";// đặt đường dẫn,lưu trữ trong biến downloadPath
                DataTable dtbl = GetOrderDetails();//gọi phương thức GetOrderDetails để lấy chi tiết đơn hàng và lưu chúng vào đối tượng DataTable dtbl
                ExportToPdf(dtbl, downloadPath, "HOA DON");//ExportToPdf() được gọi để tạo tệp PDF từ DataTable và lưu trữ nó tại đường dẫn được xác định bởi downloadPath.

                WebClient client = new WebClient();
                Byte[] buffer = client.DownloadData(downloadPath);
                if(buffer != null)
                {
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-length", buffer.Length.ToString());
                    Response.BinaryWrite(buffer);

                }
            }
            catch(Exception ex)
            {

                lblMsg.Visible = true;
                lblMsg.Text = "Error Message:- " + ex.Message.ToString();
            }
        }


        void ExportToPdf(DataTable dtblTable, String strPdfPath, string strHeader)
        {
            FileStream fs = new FileStream(strPdfPath, FileMode.Create, FileAccess.Write, FileShare.None);
            Document document = new Document();
            document.SetPageSize(PageSize.A4);
            PdfWriter writer = PdfWriter.GetInstance(document, fs);
            document.Open();

            //Report Header
            BaseFont bfntHead = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            Font fntHead = new Font(bfntHead, 16, 1, Color.GRAY);
            Paragraph prgHeading = new Paragraph();
            prgHeading.Alignment = Element.ALIGN_CENTER;
            prgHeading.Add(new Chunk(strHeader.ToUpper(), fntHead));
            document.Add(prgHeading);

            //Author
            Paragraph prgAuthor = new Paragraph();
            BaseFont btnAuthor = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            Font fntAuthor = new Font(btnAuthor, 8, 2, Color.GRAY);
            prgAuthor.Alignment = Element.ALIGN_RIGHT;
            prgAuthor.Add(new Chunk("ORDER: AM THUC VIET NAM", fntAuthor));
            prgAuthor.Add(new Chunk("\nORDER DATE : " + dtblTable.Rows[0]["OrderDate"].ToString(), fntAuthor));
            document.Add(prgAuthor);

            //Add a line seperation
            Paragraph p = new Paragraph(new Chunk(new iTextSharp.text.pdf.draw.LineSeparator(0.0F, 100.0F, Color.BLACK, Element.ALIGN_LEFT, 1)));
            document.Add(p);

            //Add line break
            document.Add(new Chunk("\n", fntHead));

            //Write the table
            PdfPTable table = new PdfPTable(dtblTable.Columns.Count - 2);
            //Table header
            BaseFont btnColumnHeader = BaseFont.CreateFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
            Font fntColumnHeader = new Font(btnColumnHeader, 9, 1, Color.WHITE);
            for (int i = 0; i < dtblTable.Columns.Count - 2; i++)
            {
                PdfPCell cell = new PdfPCell();
                cell.BackgroundColor = Color.GRAY;
                cell.AddElement(new Chunk(dtblTable.Columns[i].ColumnName.ToUpper(), fntColumnHeader));
                table.AddCell(cell);
            }
            //table Data
            Font fntColumnData = new Font(btnColumnHeader, 8, 1, Color.BLACK);
            for (int i = 0; i < dtblTable.Rows.Count; i++)
            {
                for (int j = 0; j < dtblTable.Columns.Count - 2; j++)
                {
                    PdfPCell cell = new PdfPCell();
                    cell.AddElement(new Chunk(dtblTable.Rows[i][j].ToString(), fntColumnData));
                    table.AddCell(cell);
                }
            }

            document.Add(table);
            document.Close();
            writer.Close();
            fs.Close();
        }



    }
}