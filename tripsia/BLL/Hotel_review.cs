using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using tripsia.DAL;

namespace tripsia.BLL
{
    public class Hotel_review
    {
        public int review_Id { get; set; }
        public int hotel_id { get; set; }
        public int user_id { get; set; }
        public string name { get; set; }
        public string review { get; set; }
        public Hotel_review()
        {

        }

        public Hotel_review(int Review_id, int Hotel_id, int User_id, string Name, string Review)
        {
            review_Id = Review_id;
            hotel_id = Hotel_id;
            user_id = User_id;
            name = Name;
            review = Review;
        }
        public int AddReview()
        {
            Hotel_reviewDAO dao = new Hotel_reviewDAO();
            return (dao.Insert(this));
        }
        public Hotel_review GetHotelReviewById(string review_id)
        {
            Hotel_reviewDAO customerdao = new Hotel_reviewDAO();
            return customerdao.SelectById(review_id);
        }
    }
}