namespace NerTracker.Entities
{
    public class BenefTracker
    {
        public int Id { get; set; }

        public string? GrantId { get; set; }
        public GrantData? Grant { get; set; }

        public int DHomme18_349 { get; set; }

        public int DHomme35Plus { get; set; }

        public int DFemme18_349 { get; set; }

        public int DFemme35Plus { get; set; }

        public int IHomme18_349 { get; set; }

        public int IHomme35Plus { get; set; }

        public int IFemme18_349 { get; set; }

        public int IFemme35Plus { get; set; }

        public DateTime SynchronizedOn { get; set; }
    }
}
