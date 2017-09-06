using Blog.Models;
using Blog.Properties;
using DAL;
using System.Configuration;
using System.Data.Common;
using System.Web.Mvc;
using System.Web.Security;

namespace Blog.Controllers
{
    public class AuthController : Controller
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["Default"].ConnectionString;
        private static DbProviderFactory factory = DbProviderFactories.GetFactory(ConfigurationManager.ConnectionStrings["Default"].ProviderName);
        private static BlogsDAL dal = new BlogsDAL(factory, connectionString);

        [AllowAnonymous]
        public ActionResult LogIn()
        {
            ViewBag.Massage = "";
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult LogIn(LoginModel model)
        {
            if (dal.AuthUser(model.Email, model.Password))
            {
                dal.CheckUserStatus(model.Email);
                int id = dal.GetUserId(model.Email);
                dal.DeleteSession(id);
                dal.CreateSession(id);
                FormsAuthentication.SetAuthCookie(dal.GetUser(dal.GetUserId(model.Email)).Nickname, true);

                return RedirectToAction("Index", "Home");
            }
            ViewBag.Massage = Resources.WRONG_LOGIN_OR_PASSWORD;

            return View();
        }

        public ActionResult LogOut()
        {
            dal.DeleteSession(dal.GetUserIdByNick(User.Identity.Name));
            FormsAuthentication.SignOut();

            return Redirect("~/");
        }

        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterViewModel model)
        {
            if (ModelState.IsValid)
            {
                dal.AddUser(model.Nickname, model.Email, model.Password);
                return RedirectToAction("LogIn");
            }

            return View(model);
        }
    }
}