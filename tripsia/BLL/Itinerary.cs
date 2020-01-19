using System.Data;
using System.Globalization;
using tripsia.DAL;

namespace tripsia.BLL
{
    public class Itinerary
    {
        private TextInfo txtinfo = new CultureInfo("en-US", false).TextInfo;
        public int? id { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public int? uid { get; set; }

        public Itinerary() { }

        public Itinerary(int? id = null, string title = null, string description = null, string eids = null, int? uid = null)
        {
            this.id = id;
            this.title = title != null ? txtinfo.ToTitleCase(title) : null;
            this.description = description;
            this.uid = uid;
        }

        public bool Create()
        {
            ItineraryDAO da = new ItineraryDAO();
            return da.Insert(this);
        }

        public bool Update()
        {
            ItineraryDAO da = new ItineraryDAO();
            return da.UpdateByUidAndTitle(this);
        }

        public DataTable GetByUid()
        {
            ItineraryDAO da = new ItineraryDAO();
            return da.SelectByUid(this);
        }

        public bool DeleteByIid()
        {
            ItineraryDAO da = new ItineraryDAO();

            new ItineraryEvent(iid: this.id).DeleteByIid();

            return da.DeleteItinerary(this);
        }
    }
}