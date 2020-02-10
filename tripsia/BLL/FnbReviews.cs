using System;
using System.Data;
using tripsia.DAL;

namespace tripsia.BLL
{
    public class FnbReviews
    {
        public int? id { get; set; }
        public string review { get; set; }
        public string pid { get; set; }
        public int? uid { get; set; }
        public float? rating { get; set; }
        public DateTime? dateTime { get; set; }

        public FnbReviews() { }

        public FnbReviews(int? id = null, string review = null, string pid = null, int? uid = null, float? rating = null, DateTime? dateTime = null)
        {
            this.id = id;
            this.review = review;
            this.pid = pid;
            this.uid = uid;
            this.rating = rating;
            this.dateTime = dateTime;
        }

        public bool Create()
        {
            FnbReviewsDAO da = new FnbReviewsDAO();
            return da.Insert(this);
        }

        public DataTable getByPidSortByDate()
        {
            FnbReviewsDAO da = new FnbReviewsDAO();
            return da.SelectByPidSortByDate(this);
        }

        public DataTable getByUidSortByDate()
        {
            FnbReviewsDAO da = new FnbReviewsDAO();
            return da.SelectByUidSortByDate(this);
        }
    }
}