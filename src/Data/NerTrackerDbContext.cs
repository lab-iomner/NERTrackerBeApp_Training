using Microsoft.EntityFrameworkCore;
using NerTracker.Entities;

namespace NerTracker.Data
{
    public class NerTrackerDbContext:DbContext
    {
        public NerTrackerDbContext(DbContextOptions<NerTrackerDbContext> options)
             : base(options)
        {

        }
        public DbSet<Commune> Communes { get; set; } = null!;

        public DbSet<Departement> Departements { get; set; } = null!;

        public DbSet<Region> Regions { get; set; } = null!;

        public DbSet<BenefTracker> BenefTrackers { get; set; } = null!;

        public DbSet<GrantData> GrantDatas { get; set; } = null!;

        public DbSet<Objective> Objectives { get; set; } = null!;

        public DbSet<ServiceType> ServiceTypes { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Region>().HasKey(x => x.Id);

            modelBuilder.Entity<GrantData>().HasKey(x => x.Number);

            //modelBuilder.Entity<BenefTracker>()
            //    .HasOne(b => b.Grant)
            //    .WithMany(b => b.BenefTrackers)
            //    .HasForeignKey(g => g.GrantNumber)
            //    .HasPrincipalKey(b => b.Number);
        }
    }
}
