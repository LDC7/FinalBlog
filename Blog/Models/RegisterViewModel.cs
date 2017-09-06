using Blog.Properties;
using System.ComponentModel.DataAnnotations;

namespace Blog.Models
{
    public class RegisterViewModel
    {
        [Required]
        [EmailAddress]
        [Display(Name = nameof(Resources.EMAIL), ResourceType = typeof(Resources))]
        public string Email { get; set; }

        [Required]
        [MaxLength(20)]
        [Display(Name = nameof(Resources.NICKNAME), ResourceType = typeof(Resources))]
        public string Nickname { set; get; }

        [Required]
        [DataType(DataType.Password)]
        [MinLength(3)]
        [Display(Name = nameof(Resources.PASSWORD), ResourceType = typeof(Resources))]
        public string Password { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Confirm password")]
        [Compare("Password", ErrorMessage = "The password and confirmation password do not match.")]
        public string ConfirmPassword { get; set; }
    }
}