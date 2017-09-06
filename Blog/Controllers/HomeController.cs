using AutoMapper;
using Blog.Models;
using Blog.Properties;
using DAL;
using System.Collections.Generic;
using System.Configuration;
using System.Data.Common;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;

namespace Blog.Controllers
{
    public class HomeController : Controller
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["Default"].ConnectionString;
        private static DbProviderFactory factory = DbProviderFactories.GetFactory(ConfigurationManager.ConnectionStrings["Default"].ProviderName);
        private static BlogsDAL dal = new BlogsDAL(factory, connectionString);

        [AllowAnonymous]
        public ActionResult Index(int page = 1)
        {
            List<Article> allArticles = dal.GetAllArticles();
            int pageSize = 5;
            IEnumerable<Article> articlesPerPages = allArticles.Skip((page - 1) * pageSize).Take(pageSize);
            PageInfo pageInfo = new PageInfo { PageNumber = page, PageSize = pageSize, TotalItems = allArticles.Count };
            IndexViewModel ivm = new IndexViewModel { PageInfo = pageInfo, Articles = articlesPerPages };

            return View(ivm);
        }

        public ActionResult OpenArticle(int id)
        {
            SessionOutOfTime();
            Mapper.Initialize(cfg => cfg.CreateMap<DAL.Article, Models.ArticleModel>());
            ArticleModel am = Mapper.Map<DAL.Article, Models.ArticleModel>(dal.GetArticle(id));
            am.Tags = dal.GetTags(id);
            am.Comments = dal.GetComments(id);
            am.UserCanChangeRating = dal.CheckUserVote(dal.GetUserIdByNick(User.Identity.Name), am.ArticleId);

            return View(am);
        }

        public ActionResult CreateArticle()
        {
            if (SessionOutOfTime())
            {
                return View();
            }

            return RedirectToAction("LogIn", "Auth");
        }

        public ActionResult CreatingArticle(CreateArticleModel cam)
        {
            if (SessionOutOfTime())
            {
                string[] buf = new string[0];
                if (cam.Tags != string.Empty)
                {
                    buf = cam.Tags.Split(',');
                    for (int i = 0; i < buf.Length; i++)
                        buf[i].Trim();
                }

                int aid = dal.AddArticleWithTags(dal.GetUserIdByNick(cam.Nickname), cam.Title, cam.Text, buf);

                return RedirectToActionPermanent("OpenArticle", new { id = aid });
            }

            return RedirectToAction("LogIn", "Auth");
        }

        [HttpPost]
        public ActionResult Commenting(CommentModel comment)
        {
            int userid = dal.GetUserIdByNick(comment.Nickname);
            if (SessionOutOfTime())
            {
                dal.AddComment(userid, comment.ArticleId, comment.CommentText);

                return RedirectToActionPermanent("OpenArticle", new { id = comment.ArticleId });
            }

            return RedirectToAction("LogIn", "Auth");
        }

        public ActionResult Manage(string nick = null, int page = 1)
        {
            if (SessionOutOfTime())
            {
                User user;
                if (nick == null)
                {
                    user = dal.GetUser(User.Identity.Name);
                }
                else
                {
                    user = dal.GetUser(nick);
                }
                dal.CheckUserStatus(user.Email);
                List<Article> usersArticles = dal.GetUserArticles(user.UserId);
                int pageSize = 4;
                IEnumerable<Article> articlesPerPages = usersArticles.Skip((page - 1) * pageSize).Take(pageSize);
                PageInfo pageInfo = new PageInfo { PageNumber = page, PageSize = pageSize, TotalItems = usersArticles.Count };
                ManageUserViewModel muvm = new ManageUserViewModel
                {
                    Nickname = user.Nickname,
                    Status = user.Status,
                    UserId = user.UserId,
                    PageInfo = pageInfo,
                    Articles = articlesPerPages
                };

                return View(muvm);
            }

            return RedirectToAction("LogIn", "Auth");
        }

        public ActionResult SearchByTag(int tagId, int page = 1)
        {
            List<Article> articles = dal.GetArticleByTag(tagId);
            int pageSize = 4;
            IEnumerable<Article> articlesPerPages = articles.Skip((page - 1) * pageSize).Take(pageSize);
            PageInfo pageInfo = new PageInfo { PageNumber = page, PageSize = pageSize, TotalItems = articles.Count };
            SearchViewModel svm = new SearchViewModel
            {
                PageInfo = pageInfo,
                Articles = articlesPerPages,
                Method = "SearchByTag",
                Text = dal.GetTag(tagId),
                tagid = tagId
            };

            return View("SearchResult", svm);
        }

        public ActionResult SearchText(string searchText, int page = 1)
        {
            List<Article> articles = dal.GetArticleByText(searchText);
            int pageSize = 4;
            IEnumerable<Article> articlesPerPages = articles.Skip((page - 1) * pageSize).Take(pageSize);
            PageInfo pageInfo = new PageInfo { PageNumber = page, PageSize = pageSize, TotalItems = articles.Count };
            SearchViewModel svm = new SearchViewModel
            {
                PageInfo = pageInfo,
                Articles = articlesPerPages,
                Method = "SearchText",
                Text = searchText,
                tagid = -1
            };

            return View("SearchResult", svm);
        }

        [Authorize(Roles = "moder")]
        public ActionResult BanUser(int uid)
        {
            if (SessionOutOfTime())
            {
                BanUserModel bum = new BanUserModel();
                bum.UserId = uid;

                return PartialView("Partial/BlockUser", bum);
            }

            return RedirectToAction("LogIn", "Auth");
        }

        [HttpPost]
        [Authorize(Roles = "moder")]
        public ActionResult BaningUser(BanUserModel bum)
        {
            if (SessionOutOfTime())
            {
                dal.BlockUser(bum.UserId, bum.Period, bum.Reason);
                string unick = dal.GetUser(bum.UserId).Nickname;

                return RedirectToActionPermanent("Manage", new { nick = unick });
            }

            return RedirectToAction("LogIn", "Auth");
        }

        [Authorize(Roles = "moder")]
        public ActionResult UnBanUser(int uid)
        {
            if (SessionOutOfTime())
            {
                Mapper.Initialize(cfg => cfg.CreateMap<DAL.BlockedUser, Models.BlockedUserModel>());
                BlockedUserModel bum = Mapper.Map<DAL.BlockedUser, Models.BlockedUserModel>(dal.GetBlockedUser(uid));

                return PartialView("Partial/UnBlockUser", bum);
            }

            return RedirectToAction("LogIn", "Auth");
        }

        [HttpPost]
        [Authorize(Roles = "moder")]
        public ActionResult UnBaningUser(int id)
        {
            if (SessionOutOfTime())
            {
                dal.UnBlockUser(id);

                return RedirectToActionPermanent("Manage", new { nick = dal.GetUser(id).Nickname });
            }

            return RedirectToAction("LogIn", "Auth");
        }

        [Authorize(Roles = "moder")]
        public ActionResult BlockedArticles(int page = 1)
        {
            if (SessionOutOfTime())
            {
                List<Article> allArticles = dal.GetBlockedArticles();
                int pageSize = 4;
                IEnumerable<Article> articlesPerPages = allArticles.Skip((page - 1) * pageSize).Take(pageSize);
                PageInfo pageInfo = new PageInfo { PageNumber = page, PageSize = pageSize, TotalItems = allArticles.Count };
                IndexViewModel ivm = new IndexViewModel { PageInfo = pageInfo, Articles = articlesPerPages };

                return View("Index", ivm);
            }

            return RedirectToAction("LogIn", "Auth");
        }

        public ActionResult DeleteArticle(int articleId)
        {
            if (SessionOutOfTime())
            {
                dal.DeleteArticle(articleId);
                dal.DeleteUselessTags();

                return RedirectToAction("Index");
            }

            return RedirectToAction("LogIn", "Auth");
        }

        public ActionResult DeleteComment(int commentId, int articleId)
        {
            if (SessionOutOfTime())
            {
                dal.DeleteComment(commentId);
            }

            return RedirectToActionPermanent("OpenArticle", new { id = articleId });
        }

        public ActionResult ChangeRating(int aid, bool plus, string nick)
        {
            if (SessionOutOfTime())
            {
                if (plus)
                {
                    dal.AddRating(dal.GetUserIdByNick(nick), aid, 1);
                }
                else
                {
                    dal.AddRating(dal.GetUserIdByNick(nick), aid, -1);
                }
            }

            return RedirectToActionPermanent("OpenArticle", new { id = aid });
        }

        [Authorize(Roles = "admin")]
        public ActionResult ChangeUserStatus(int id)
        {
            if (SessionOutOfTime())
            {
                ChangeStatus m = new ChangeStatus();
                m.Id = id;
                m.Redirect = "ChangingUserStatus";
                m.Title = Resources.CHANGE_USER_STATUS;
                m.StatusList = new List<string>();
                m.SelectedStatus = Resources.USER;
                m.StatusList.Add(Resources.USER);
                m.StatusList.Add(Resources.MODERATOR_USER);
                m.StatusList.Add(Resources.ADMINISTRATOR_USER);

                return PartialView("Partial/ChangeStatus", m);
            }

            return RedirectToAction("LogIn", "Auth");
        }

        [HttpPost]
        [Authorize(Roles = "admin")]
        public ActionResult ChangingUserStatus(ChangeStatus m)
        {
            if (SessionOutOfTime())
            {
                if (m.SelectedStatus == Resources.ADMINISTRATOR_USER)
                {
                    dal.ChangeUserStatus(m.Id, "admin");
                }
                if (m.SelectedStatus == Resources.MODERATOR_USER)
                {
                    dal.ChangeUserStatus(m.Id, "moder");
                }
                if (m.SelectedStatus == Resources.USER)
                {
                    dal.ChangeUserStatus(m.Id, "user");
                }
            }

            return RedirectToActionPermanent("Manage", new { nick = dal.GetUser(m.Id).Nickname });
        }

        [Authorize(Roles = "moder")]
        public ActionResult ChangeArticleStatus(int id)
        {
            if (SessionOutOfTime())
            {
                ChangeStatus m = new ChangeStatus();
                m.Id = id;
                m.Redirect = "ChangingArticleStatus";
                m.Title = Resources.CHANGE_USER_STATUS;
                m.StatusList = new List<string>();
                m.SelectedStatus = Resources.DEFAULT;
                m.StatusList.Add(Resources.DEFAULT);
                m.StatusList.Add(Resources.READONLY);
                m.StatusList.Add(Resources.BLOCKED_ARTICLE);

                return PartialView("Partial/ChangeStatus", m);
            }

            return RedirectToActionPermanent("OpenArticle", new { id = id });
        }

        [HttpPost]
        [Authorize(Roles = "moder")]
        public ActionResult ChangingArticleStatus(ChangeStatus m)
        {
            if (SessionOutOfTime())
            {
                if (m.SelectedStatus == Resources.DEFAULT)
                {
                        dal.ChangeArticleStatus(m.Id, "Default");
                }
                if (m.SelectedStatus == Resources.READONLY)
                {
                    dal.ChangeArticleStatus(m.Id, "ReadOnly");
                }
                if (m.SelectedStatus == Resources.BLOCKED_ARTICLE)
                {
                    dal.ChangeArticleStatus(m.Id, "Blocked");
                }
            }

            return RedirectToActionPermanent("OpenArticle", new { id = m.Id });
        }

        private bool SessionOutOfTime()
        {
            if (User.Identity.IsAuthenticated)
            {
                dal.CheckUserStatus((dal.GetUser(User.Identity.Name)).Email);
                if (!dal.CheckSession(dal.GetUserIdByNick(User.Identity.Name)))
                {
                    FormsAuthentication.SignOut();
                    return false;
                }
            }
            else
            {
                return false;
            }

            return true;
        }
    }
}