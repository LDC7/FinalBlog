using System;

namespace DAL
{ 
    public class BlockedUser
    {
        public int UserId { set; get; }
        public DateTime? BlockDate { set; get; }
        public DateTime? ReleaseDate { set; get; }
        public string Reason { set; get; }
    }
}