using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tripsia.DAL;

namespace tripsia.BLL
{
    public class ReviewAir
    {
        public int? Uid { get; set; }
        public string Subject { get; set; }
        public string Description { get; set; }
        public int? Rating { get; set; }

        public ReviewAir() { }

        public ReviewAir(int? uid, string subject, string description, int? rating)
        {
            this.Uid = uid;
            this.Subject = subject;
            this.Description = description;
            this.Rating = rating;
        }
        public bool Create()
        {
            ReviewAirDAO da = new ReviewAirDAO();
            return da.Insert(this);
        }
    }
    
}