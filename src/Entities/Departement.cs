namespace NerTracker.Entities
{
    public class Departement
    {
        public int Id { get; set; }

        public string Designation { get; set; } = null!;

        public string RegionId { get; set; } = null!;
        public Region? Region { get; set; }

        public ICollection<Commune> Communes { get; set; } = new List<Commune>();
    }
}
