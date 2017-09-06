using Blog.Properties;
using System.ComponentModel.DataAnnotations;

namespace Blog.Models
{
    public class CreateArticleModel
    {
        public string Nickname { set; get; }

        [Required]
        [MaxLength(50)]
        [Display(Name = nameof(Resources.TITLE), ResourceType = typeof(Resources))]
        public string Title { set; get; }

        [Required]
        [MaxLength(4000)]
        [Display(Name = nameof(Resources.TEXT), ResourceType = typeof(Resources))]
        public string Text { set; get; }

        [MaxLength(1000)]
        [Display(Name = nameof(Resources.TAGS), ResourceType = typeof(Resources))]
        public string Tags { set; get; }
    }
}