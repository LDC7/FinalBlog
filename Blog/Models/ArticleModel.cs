using System;
using System.Collections.Generic;
using DAL;

namespace Blog.Models
{
    public class ArticleModel
    {
        public int ArticleId { set; get; }
        public int UserId { set; get; }
        public string Nickname { set; get; }
        public string Status { set; get; }
        public int Rating { set; get; }
        public DateTime UploadDate { set; get; }
        public string Title { set; get; }
        public string Text { set; get; }

        public Dictionary<int, string> Tags { set; get; }
        public List<Comment> Comments { set; get; }

        public bool UserCanChangeRating { set; get; }
    }
}