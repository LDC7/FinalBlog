using Blog.Properties;
using DAL;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Blog.Models
{
    public class ManageUserViewModel
    {
        public int UserId { set; get; }

        [Display(Name = nameof(Resources.STATUS), ResourceType = typeof(Resources))]
        public string Status { set; get; }

        [Display(Name = nameof(Resources.NICKNAME), ResourceType = typeof(Resources))]
        public string Nickname { set; get; }

        public IEnumerable<Article> Articles { get; set; }
        public PageInfo PageInfo { get; set; }
    }
}