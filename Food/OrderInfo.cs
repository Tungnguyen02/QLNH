using System;

namespace Food
{
    public class OrderInfo
    {
        public long OrderId { get; set; }
        public decimal Amount { get; set; }
        public string Status { get; set; }
        public string OrderDesc { get; set; }
        public DateTime CreatedDate { get; set; }

        public OrderInfo()
        {

        }
    }
}