namespace tripsia.BLL
{
    public partial class Translate
    {
        public Data data { get; set; }
    }

    public partial class Data
    {
        public Translation[] translations { get; set; }
    }

    public partial class Translation
    {
        public string translatedText { get; set; }
        public string detectedSourceLanguage { get; set; }
    }

}