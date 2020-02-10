namespace tripsia.BLL
{
    public partial class TranslateLanguages
    {
        public Data data { get; set; }
    }

    public partial class Data
    {
        public Language[] languages { get; set; }
    }

    public partial class Language
    {
        public string language { get; set; }
        public string name { get; set; }
    }
}