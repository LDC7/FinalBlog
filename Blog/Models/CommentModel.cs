using System.ComponentModel.DataAnnotations;

namespace Blog.Models
{
    public class CommentModel
    {
        public int ArticleId { set; get; }
        public string Nickname { set; get; }

        [MinLength(1)]
        [MaxLength(1000)]
        public string CommentText { set; get; }
    }
}