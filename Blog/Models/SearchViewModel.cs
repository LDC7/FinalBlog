using DAL;
using System.Collections.Generic;

namespace Blog.Models
{
    public class SearchViewModel
    {
        public string Method { set; get; }
        public string Text { set; get; }

        //только для поиска по тегу
        public int tagid { set; get; }

        public IEnumerable<Article> Articles { get; set; }
        public PageInfo PageInfo { get; set; }
    }
}