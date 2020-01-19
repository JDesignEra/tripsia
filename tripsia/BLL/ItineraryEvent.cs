using System;
using System.Data;
using System.Globalization;
using tripsia.DAL;

namespace tripsia.BLL
{
    public class ItineraryEvent
    {
        private TextInfo txtInfo = new CultureInfo("en-US", false).TextInfo;
        public int? id { get; set; }
        public int? iid { get; set; }
        public string title { get; set; }
        public string description { get; set; }
        public DateTime? dateTime { get; set; }

        public ItineraryEvent() { }

        public ItineraryEvent(int? id = null, int? iid = null, string title = null, string description = null, DateTime? dateTime = null)
        {
            this.id = id;
            this.iid = iid;
            this.title = title != null ? txtInfo.ToTitleCase(title) : null;
            this.description = description;
            this.dateTime = dateTime;
        }

        public bool Create()
        {
            ItineraryEventDAO da = new ItineraryEventDAO();
            return da.Insert(this);
        }

        public bool UpdateById()
        {
            ItineraryEventDAO da = new ItineraryEventDAO();
            return da.UpdateById(this);
        }

        public DataTable getByDate()
        {
            ItineraryEventDAO da = new ItineraryEventDAO();
            return da.getByDate(this);
        }


        public DataTable getDateNoDupeByIid()
        {
            ItineraryEventDAO da = new ItineraryEventDAO();
            return da.SelectDateNoDupeByIid(this);
        }

        public bool DeleteByIid()
        {
            ItineraryEventDAO da = new ItineraryEventDAO();
            return da.DeleteByIid(this);
        }
    }
}