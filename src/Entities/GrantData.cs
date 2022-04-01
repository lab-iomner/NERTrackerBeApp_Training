namespace NerTracker.Entities
{
    public class GrantData
    {
        public string Number { get; set; } = null!;

        public string Title { get; set; } = null!;

        public string? Summary { get; set; }

        public string? Status { get; set; }

        public int ObjectiveId { get; set; }
        public Objective? Objective { get; set; }

        public int RegionId { get; set; }
        public Region? Region { get; set; }

        public int ServiceTypeId { get; set; }
        public ServiceType? ServiceType { get; set; }

        public ICollection<BenefTracker> BenefTrackers { get; set; } = new List<BenefTracker>();

    }
}
