using System.Collections.Generic;
using System.Web.Mvc;

namespace Blog.Models
{
    public class ChangeStatus
    {
        
        public int Id { set; get; }
        public string Title { set; get; }
        public string SelectedStatus { set; get; }
        public List<string> StatusList;
        public string Redirect { set; get; }
    }
}