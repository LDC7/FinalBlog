using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class Comment
    {
        public int CommentId { set; get; }
        public int ArticleId { set; get; }
        public int UserId { set; get; }
        public string Nickname { set; get; }
        public DateTime Date { set; get; }
        public string Text { set; get; }

        public Comment() { }

        public Comment( int commentId, int articleId, int userId, string nickname, DateTime date, string text)
        {
            this.CommentId = commentId;
            this.ArticleId = articleId;
            this.UserId = userId;
            this.Nickname = nickname;
            this.Date = date;
            this.Text = text;
        }
    }
}
