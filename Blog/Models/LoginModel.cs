using System.ComponentModel.DataAnnotations;

namespace Blog.Models
{
    public class LoginModel
    {
        [Required]
        [EmailAddress]
        [MaxLength(50)]
        public string Email { set; get; }

        [Required]
        [MaxLength(20)]
        [MinLength(3)]
        public string Password { set; get; }
    }
}