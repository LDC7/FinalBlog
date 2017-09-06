using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;

namespace DAL
{
    public class BlogsDAL
    {
        private string connectionString;
        private DbProviderFactory factory;

        public BlogsDAL(DbProviderFactory fac, string connectStr)
        {
            connectionString = connectStr;
            factory = fac;
        }

        public string CheckUserStatus(string email)
        {
            string status;

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetUserId";
                com.Parameters.Add(DBParam("Email", email));

                int userId = (int)com.ExecuteScalar();

                com.CommandText = "CheckUserStatus";
                com.Parameters.Clear();
                com.Parameters.Add(DBParam("UserId", userId));

                status = (string)com.ExecuteScalar();
            }

            return status;
        }

        public int GetUserId(string email)
        {
            int userId;

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetUserId";
                com.Parameters.Add(DBParam("Email", email));

                userId = (int)com.ExecuteScalar();
            }

            return userId;
        }

        public void CreateSession(int userId)
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "CreateSession";
                com.Parameters.Add(DBParam("UserId", userId));

                com.ExecuteNonQuery();
            }
        }

        public bool CheckSession(int userId)
        {
            bool flag = false;

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "CheckSession";
                com.Parameters.Add(DBParam("UserId", userId));

                flag = (bool)com.ExecuteScalar();
            }

            return flag;
        }

        public bool AuthUser(string email, string pword)
        {
            bool flag = false;

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "AuthUser";
                com.Parameters.Add(DBParam("Email", email));
                com.Parameters.Add(DBParam("Password", pword));

                flag = (bool)com.ExecuteScalar();
            }

            return flag;
        }

        public int AddArticleWithTags(int userId, string title, string text, string[] tags)
        {
            List<int> tagIds = new List<int>();
            int articleId;

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;

                com.CommandText = "AddArticle";

                com.Parameters.Add(DBParam("UserId", userId));
                com.Parameters.Add(DBParam("Title", title));
                com.Parameters.Add(DBParam("Text", text));
                articleId = (int)com.ExecuteScalar();

                com.Parameters.Clear();

                com.CommandText = "AddTag";

                foreach(string tag in tags)
                {
                    if (tag != string.Empty)
                    {
                        com.Parameters.Add(DBParam("TagText", tag));
                        tagIds.Add((int)com.ExecuteScalar());
                        com.Parameters.Clear();
                    }
                }

                com.CommandText = "AddTagRelation";

                foreach(int tagId in tagIds)
                {
                    com.Parameters.Add(DBParam("ArticleId", articleId));
                    com.Parameters.Add(DBParam("TagId", tagId));
                    com.ExecuteNonQuery();
                    com.Parameters.Clear();
                }

            }

            return articleId;
        }

        public void AddComment(int userId, int articleId, string text)
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "AddComment";
                com.Parameters.Add(DBParam("UserId", userId));
                com.Parameters.Add(DBParam("ArticleId", articleId));
                com.Parameters.Add(DBParam("Text", text));

                com.ExecuteNonQuery();
            }
        }

        public void AddRating(int userId, int articleId, int rating)
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "AddRating";
                com.Parameters.Add(DBParam("UserId", userId));
                com.Parameters.Add(DBParam("ArticleId", articleId));
                com.Parameters.Add(DBParam("Rating", ((Int16)rating)));

                com.ExecuteNonQuery();
            }
        }

        public int AddUser(string nick, string email, string pword)
        {
            int id;
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "AddUser";
                com.Parameters.Add(DBParam("Nick", nick));
                com.Parameters.Add(DBParam("Email", email));
                com.Parameters.Add(DBParam("Password", pword));

                id = (int)com.ExecuteScalar();
            }

            return id;
        }

        public void BlockUser(int userId, int? period, string reason)
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "BlockUser";
                com.Parameters.Add(DBParam("UserId", userId));
                com.Parameters.Add(DBParam("Period", period));
                com.Parameters.Add(DBParam("Reason", reason));

                com.ExecuteNonQuery();
            }
        }

        public void ChangeArticleStatus(int articleId, string status)
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "ChageArticleStatus";
                com.Parameters.Add(DBParam("ArticleId", articleId));
                com.Parameters.Add(DBParam("Status", status));

                com.ExecuteNonQuery();
            }
        }

        public void ChangeUserStatus(int userId, string status)
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "ChangeUserStatus";
                com.Parameters.Add(DBParam("UserId", userId));
                com.Parameters.Add(DBParam("NewStatus", status));

                com.ExecuteNonQuery();
            }
        }

        public void DeleteArticle(int articleId)
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "DeleteArticle";
                com.Parameters.Add(DBParam("ArticleId", articleId));

                com.ExecuteNonQuery();
            }
        }

        public void DeleteComment(int commentId)
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "DeleteComment";
                com.Parameters.Add(DBParam("CommentId", commentId));

                com.ExecuteNonQuery();
            }
        }

        public void DeleteSession(int userId)
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "DeleteSession";
                com.Parameters.Add(DBParam("UserId", userId));

                com.ExecuteNonQuery();
            }
        }

        public void DeleteUselessTags()
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "DeleteUselessTags";

                com.ExecuteNonQuery();
            }
        }

        public Article GetArticle(int articleId)
        {
            Article article;
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetArticle";
                com.Parameters.Add(DBParam("ArticleId", articleId));

                using (IDataReader reader = com.ExecuteReader())
                {
                    reader.Read();
                    article = new Article((int)reader["PK_ArticleID"]
                        , (int)reader["FK_UserID"]
                        , (string)reader["Nickname"]
                        , (string)reader["Status"]
                        , (int)reader["Rating"]
                        , (DateTime)reader["UploadDate"]
                        , (string)reader["Title"]
                        , (string)reader["ArticleText"]);
                }
            }

            return article;
        }

        public Dictionary<int, string> GetTags(int articleId)
        {
            var tagDictionary = new Dictionary<int, string>();
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetTags";
                com.Parameters.Add(DBParam("ArticleId", articleId));

                using(IDataReader reader = com.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        tagDictionary.Add((int)reader["PK_TagID"], (string)reader["TagText"]);
                    }
                }
            }

            return tagDictionary;
        }

        public User GetUser(int userId)
        {
            User user;
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetUserInfo";
                com.Parameters.Add(DBParam("UserId", userId));

                using (IDataReader reader = com.ExecuteReader())
                {
                    reader.Read();
                    user = new User((int)reader["PK_UserID"]
                        , (string)reader["Status"]
                        , (string)reader["Nickname"]
                        , (string)reader["Email"]);
                }
            }

            return user;
        }

        public User GetUser(string nickname)
        {
            User user;
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetUserByNick";
                com.Parameters.Add(DBParam("Nick", nickname));

                using (IDataReader reader = com.ExecuteReader())
                {
                    reader.Read();
                    user = new User((int)reader["PK_UserID"]
                        , (string)reader["Status"]
                        , (string)reader["Nickname"]
                        , (string)reader["Email"]);
                }
            }

            return user;
        }

        public void UnBlockUser(int userId)
        {
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "UnBlockUser";
                com.Parameters.Add(DBParam("UserId", userId));

                com.ExecuteNonQuery();
            }
        }

        public List<Article> GetAllArticles()
        {
            var list = new List<Article>();

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetAllArticles";

                using (IDataReader reader = com.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new Article(
                            (int)reader["PK_ArticleID"]
                            , (int)reader["FK_UserID"]
                            , (string)reader["Nickname"]
                            , (string)reader["Status"]
                            , (int)reader["Rating"]
                            , (DateTime)reader["UploadDate"]
                            , (string)reader["Title"]
                            , (string)reader["ArticleText"]));
                    }
                }
            }

            return list;
        }

        public List<Comment> GetComments(int articleId)
        {
            var list = new List<Comment>();

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetComments";
                com.Parameters.Add(DBParam("ArticleId", articleId));

                using (IDataReader reader = com.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new Comment(
                            (int)reader["PK_CommentID"]
                            , (int)reader["FK_ArticleID"]
                            , (int)reader["FK_UserID"]
                            , (string)reader["Nickname"]
                            , (DateTime)reader["CommentDate"]
                            , (string)reader["CommentText"]));
                    }
                }
            }

            return list;
        }

        public int GetUserIdByNick(string nickname)
        {
            int? userId;

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetUserIdByNick";
                com.Parameters.Add(DBParam("Nick", nickname));

                userId = checkOnDBNull<int?>(com.ExecuteScalar());
            }
            if (!userId.HasValue)
            {
                userId = -1;
            }

            return (int)userId;
        }

        public List<Article> GetUserArticles(int userId)
        {
            var list = new List<Article>();

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetUserArticles";
                com.Parameters.Add(DBParam("UserId", userId));

                using (IDataReader reader = com.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new Article(
                            (int)reader["PK_ArticleID"]
                            , (int)reader["FK_UserID"]
                            , (string)reader["Status"]
                            , (int)reader["Rating"]
                            , (DateTime)reader["UploadDate"]
                            , (string)reader["Title"]
                            , (string)reader["ArticleText"]));
                    }
                }
            }

            return list;
        }

        public List<Article> GetArticleByTag(int tagId)
        {
            var list = new List<Article>();

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetArticleByTag";
                com.Parameters.Add(DBParam("TagId", tagId));

                using (IDataReader reader = com.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new Article(
                            (int)reader["PK_ArticleID"]
                            , (int)reader["FK_UserID"]
                            , (string)reader["Nickname"]
                            , (string)reader["Status"]
                            , (int)reader["Rating"]
                            , (DateTime)reader["UploadDate"]
                            , (string)reader["Title"]
                            , (string)reader["ArticleText"]));
                    }
                }
            }

            return list;
        }

        public string GetTag(int tagId)
        {
            string tag;

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetTag";
                com.Parameters.Add(DBParam("TagId", tagId));

                tag = (string)com.ExecuteScalar();
            }

            return tag;
        }

        public List<Article> GetArticleByText(string seartchText)
        {
            var list = new List<Article>();

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetArticleByText";
                com.Parameters.Add(DBParam("SearchText", seartchText));

                using (IDataReader reader = com.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new Article(
                            (int)reader["PK_ArticleID"]
                            , (int)reader["FK_UserID"]
                            , (string)reader["Nickname"]
                            , (string)reader["Status"]
                            , (int)reader["Rating"]
                            , (DateTime)reader["UploadDate"]
                            , (string)reader["Title"]
                            , (string)reader["ArticleText"]));
                    }
                }
            }

            return list;
        }

        public List<Article> GetBlockedArticles()
        {
            var list = new List<Article>();

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetBlockedArticles";

                using (IDataReader reader = com.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new Article(
                            (int)reader["PK_ArticleID"]
                            , (int)reader["FK_UserID"]
                            , (string)reader["Nickname"]
                            , (string)reader["Status"]
                            , (int)reader["Rating"]
                            , (DateTime)reader["UploadDate"]
                            , (string)reader["Title"]
                            , (string)reader["ArticleText"]));
                    }
                }
            }

            return list;
        }
                
        public bool CheckUserVote(int userId, int articleId)
        {
            bool flag;

            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "CheckUserVote";
                com.Parameters.Add(DBParam("UserId", userId));
                com.Parameters.Add(DBParam("ArticleId", articleId));

                flag = (bool)com.ExecuteScalar();
            }

            return flag;
        }

        public BlockedUser GetBlockedUser(int userId)
        {
            BlockedUser user = new BlockedUser();
            using (var connection = factory.CreateConnection())
            {
                connection.ConnectionString = connectionString;
                connection.Open();

                var com = connection.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "GetBlockUser";
                com.Parameters.Add(DBParam("UserId", userId));

                using (IDataReader reader = com.ExecuteReader())
                {
                    reader.Read();
                    user.UserId = (int)reader["FK_UserID"];
                    user.BlockDate = checkOnDBNull<DateTime?>(reader["BlockDate"]);
                    user.ReleaseDate = checkOnDBNull<DateTime?>(reader["ReleaseDate"]);
                    user.Reason = checkOnDBNull<string>(reader["Reason"]);
                }
            }

            return user;
        }




        private T checkOnDBNull<T>(object obj)
        {
            if (obj == DBNull.Value)
            {
                return default(T);
            }
            else
            {
                return (T)obj;
            }
        }

        private IDbDataParameter DBParam(string str, object obj)
        {
            if (obj == null) obj = DBNull.Value;
            IDbDataParameter dbparam = new SqlParameter(str, obj);
            return dbparam;
        }
    }
}
