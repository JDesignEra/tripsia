using System;

namespace tripsia.BLL
{

    public partial class Flights
    {
        public string type { get; set; }
        public Feature[] features { get; set; }
        public Results results { get; set; }
    }

    public partial class Results
    {
        public DateTime publishTime { get; set; }
        public string status { get; set; }
        public int total { get; set; }
    }

    public partial class Feature
    {
        public string id { get; set; }
        public string type { get; set; }
        public Geometry geometry { get; set; }
        public Properties properties { get; set; }
    }

    public partial class Geometry
    {
        public string type { get; set; }
        public float[] coordinates { get; set; }
    }

    public partial class Properties
    {
        public string airline { get; set; }
        public Arrival arrival { get; set; }
        public string callsign { get; set; }
        public Departure departure { get; set; }
        public string flightStatus { get; set; }
        public string iataFlightNumber { get; set; }
        public DateTime timestampProcessed { get; set; }
        public Aircraftdescription aircraftDescription { get; set; }
        public Positionreport positionReport { get; set; }
    }

    public partial class Arrival
    {
        public Aerodrome aerodrome { get; set; }
        public Runwaytime runwayTime { get; set; }
    }

    public partial class Aerodrome
    {
        public string initial { get; set; }
        public string scheduled { get; set; }
    }

    public partial class Runwaytime
    {
        public DateTime initial { get; set; }
        public DateTime estimated { get; set; }
    }

    public partial class Departure
    {
        public Aerodrome1 aerodrome { get; set; }
        public Runwaytime1 runwayTime { get; set; }
    }

    public partial class Aerodrome1
    {
        public string actual { get; set; }
        public string scheduled { get; set; }
    }

    public partial class Runwaytime1
    {
        public DateTime initial { get; set; }
        public DateTime actual { get; set; }
    }

    public partial class Aircraftdescription
    {
        public string aircraftCode { get; set; }
        public string aircraftRegistration { get; set; }
    }

    public partial class Positionreport
    {
        public int track { get; set; }
        public string source { get; set; }
        public int altitude { get; set; }
        public DateTime captureTimestamp { get; set; }
    }

}