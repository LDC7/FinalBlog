using System;

namespace Blog.Models
{
    public class BlockedUserModel
    {
        public int UserId { set; get; }
        public DateTime? BlockDate { set; get; }
        public DateTime? ReleaseDate { set; get; }
        public string Reason { set; get; }
    }
}