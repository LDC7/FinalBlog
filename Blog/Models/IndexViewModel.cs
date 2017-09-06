using DAL;
using System.Collections.Generic;

namespace Blog.Models
{
    public class IndexViewModel
    {
        public IEnumerable<Article> Articles { get; set; }
        public PageInfo PageInfo { get; set; }
    }
}