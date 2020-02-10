using System;
using System.Data;
using tripsia.DAL;

namespace tripsia.BLL
{
    public class HotelReviews
    {
        public int? id { get; set; }
        public string review { get; set; }
        public string pid { get; set; }
        public int? uid { get; set; }
        public float? rating { get; set; }
        public DateTime? dateTime { get; set; }

        public HotelReviews() { }

        public HotelReviews(int? id = null, string review = null, string pid = null, int? uid = null, float? rating = null, DateTime? dateTime = null)
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
            HotelReviewsDAO da = new HotelReviewsDAO();
            return da.Insert(this);
        }

        public bool UpdateById()
        {
            HotelReviewsDAO da = new HotelReviewsDAO();
            return da.UpdateById(this);
        }

        public DataTable getByPidSortByDate()
        {
            HotelReviewsDAO da = new HotelReviewsDAO();
            return da.SelectByPidSortByDate(this);
        }

        public DataTable getByUidSortByDate()
        {
            HotelReviewsDAO da = new HotelReviewsDAO();
            return da.SelectByUidSortByDate(this);
        }

        public bool DeleteById()
        {
            HotelReviewsDAO da = new HotelReviewsDAO();
            return da.DeleteById(this);
        }
    }
}