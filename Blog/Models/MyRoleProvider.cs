using DAL;
using System;
using System.Configuration;
using System.Data.Common;
using System.Web.Security;

namespace Blog.Models
{
    public class MyRoleProvider : RoleProvider
    {
        private static string connectionString = ConfigurationManager.ConnectionStrings["Default"].ConnectionString;
        private static DbProviderFactory factory = DbProviderFactories.GetFactory(ConfigurationManager.ConnectionStrings["Default"].ProviderName);
        private static BlogsDAL dal = new BlogsDAL(factory, connectionString);

        public override string[] GetRolesForUser(string nick)
        {
            int uid = dal.GetUserIdByNick(nick);
            if (uid == -1)
            {
                return new string[] { "guest" };
            }
            else
            {
                string role = dal.GetUser(uid).Status;
                if (role == "admin")
                {
                    return new string[] { role, "moder" };
                }
                return new string[] { role };
            }
        }




        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get
            {
                throw new NotImplementedException();
            }
            set
            {
                throw new NotImplementedException();
            }
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            throw new NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }
    }
}