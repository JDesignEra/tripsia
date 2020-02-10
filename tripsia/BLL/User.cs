using tripsia.DAL;

namespace tripsia.BLL
{
    public class User
    {
        public int? id { get; set; }
        public string email { get; set; }
        public string password { get; set; }
        public string name { get; set; }

        public User() { }

        public User(int? id = null, string email = null, string password = null, string name = null)
        {
            this.id = id;
            this.email = email;
            this.password = password;
            this.name = name;
        }

        public bool CreateUser()
        {
            UserDAO da = new UserDAO();
            return da.Insert(this);
        }

        public User Login()
        {
            UserDAO da = new UserDAO();
            return da.SelectByEmailAndPassword(this);
        }

        public User GetUserById()
        {
            UserDAO da = new UserDAO();
            return da.SelectById(this);
        }

        public User GetUserByEmail()
        {
            UserDAO da = new UserDAO();
            return da.SelectByEmail(this);
        }

        public User UpdateUserById()
        {
            UserDAO da = new UserDAO();
            return da.UpdateById(this);
        }

        public User UpdateUserPasswordById()
        {
            UserDAO da = new UserDAO();
            return da.UpdatePasswordById(this);
        }
    }
}