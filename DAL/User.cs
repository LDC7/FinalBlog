namespace DAL
{
    public class User
    {
        public int UserId { set; get; }
        public string Status { set; get; }
        public string Nickname { set; get; }
        public string Email { set; get; }

        public User() { }

        public User(int id, string status, string nickname, string email)
        {
            this.UserId = id;
            this.Status = status;
            this.Nickname = nickname;
            this.Email = email;
        }
    }
}
