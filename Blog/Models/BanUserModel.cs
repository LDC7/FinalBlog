using Blog.Properties;
using System.ComponentModel.DataAnnotations;

namespace Blog.Models
{
    public class BanUserModel
    {
        public int UserId { set; get; }

        [Display(Name = nameof(Resources.PERIOD), ResourceType = typeof(Resources))]
        [Range(typeof(int), "1", "9999999", ErrorMessage = "Неверный период")]
        public int? Period { set; get; }

        [Display(Name = nameof(Resources.REASON), ResourceType = typeof(Resources))]
        [MaxLength(50)]
        public string Reason { set; get; }
    }
}