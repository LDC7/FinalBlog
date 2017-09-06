using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class Article
    {
        public int ArticleId { set; get; }
        public int UserId { set; get; }
        public string Nickname { set; get; }
        public string Status { set; get; }
        public int Rating { set; get; }
        public DateTime UploadDate { set; get; }
        public string Title { set; get; }
        public string Text { set; get; }

        public Article() { }

        public Article(int articleId, int userId, string nickname, string status, int rating, DateTime date, string title, string text)
        {
            this.ArticleId = articleId;
            this.UserId = userId;
            this.Nickname = nickname;
            this.Status = status;
            this.Rating = rating;
            this.UploadDate = date;
            this.Title = title;
            this.Text = text;
        }

        public Article(int articleId, int userId, string status, int rating, DateTime date, string title, string text)
        {
            this.ArticleId = articleId;
            this.UserId = userId;
            this.Nickname = null;
            this.Status = status;
            this.Rating = rating;
            this.UploadDate = date;
            this.Title = title;
            this.Text = text;
        }
    }
}
