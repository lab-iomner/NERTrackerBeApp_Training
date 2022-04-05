﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using NerTracker.Data;

#nullable disable

namespace NerTracker.Migrations
{
    [DbContext(typeof(NerTrackerDbContext))]
    partial class NerTrackerDbContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.3")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder, 1L, 1);

            modelBuilder.Entity("NerTracker.Entities.BenefTracker", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int>("DFemme18_349")
                        .HasColumnType("int");

                    b.Property<int>("DFemme35Plus")
                        .HasColumnType("int");

                    b.Property<int>("DHomme18_349")
                        .HasColumnType("int");

                    b.Property<int>("DHomme35Plus")
                        .HasColumnType("int");

                    b.Property<string>("GrantId")
                        .HasColumnType("nvarchar(450)");

                    b.Property<int>("IFemme18_349")
                        .HasColumnType("int");

                    b.Property<int>("IFemme35Plus")
                        .HasColumnType("int");

                    b.Property<int>("IHomme18_349")
                        .HasColumnType("int");

                    b.Property<int>("IHomme35Plus")
                        .HasColumnType("int");

                    b.Property<DateTime>("SynchronizedOn")
                        .HasColumnType("datetime2");

                    b.HasKey("Id");

                    b.HasIndex("GrantId");

                    b.ToTable("BenefTrackers");
                });

            modelBuilder.Entity("NerTracker.Entities.Commune", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<int>("DepartementId")
                        .HasColumnType("int");

                    b.Property<string>("Designation")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("DepartementId");

                    b.ToTable("Communes");
                });

            modelBuilder.Entity("NerTracker.Entities.Departement", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Designation")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("RegionId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.HasKey("Id");

                    b.HasIndex("RegionId");

                    b.ToTable("Departements");
                });

            modelBuilder.Entity("NerTracker.Entities.GrantData", b =>
                {
                    b.Property<string>("Number")
                        .HasColumnType("nvarchar(450)");

                    b.Property<int>("ObjectiveId")
                        .HasColumnType("int");

                    b.Property<string>("RegionId")
                        .IsRequired()
                        .HasColumnType("nvarchar(450)");

                    b.Property<int>("ServiceTypeId")
                        .HasColumnType("int");

                    b.Property<string>("Status")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Summary")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Title")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Number");

                    b.HasIndex("ObjectiveId");

                    b.HasIndex("RegionId");

                    b.HasIndex("ServiceTypeId");

                    b.ToTable("GrantDatas");
                });

            modelBuilder.Entity("NerTracker.Entities.Objective", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Code")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Objectives");
                });

            modelBuilder.Entity("NerTracker.Entities.Region", b =>
                {
                    b.Property<string>("Id")
                        .HasColumnType("nvarchar(450)");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Regions");
                });

            modelBuilder.Entity("NerTracker.Entities.ServiceType", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"), 1L, 1);

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("ServiceTypes");
                });

            modelBuilder.Entity("NerTracker.Entities.BenefTracker", b =>
                {
                    b.HasOne("NerTracker.Entities.GrantData", "Grant")
                        .WithMany("BenefTrackers")
                        .HasForeignKey("GrantId");

                    b.Navigation("Grant");
                });

            modelBuilder.Entity("NerTracker.Entities.Commune", b =>
                {
                    b.HasOne("NerTracker.Entities.Departement", "Departement")
                        .WithMany("Communes")
                        .HasForeignKey("DepartementId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Departement");
                });

            modelBuilder.Entity("NerTracker.Entities.Departement", b =>
                {
                    b.HasOne("NerTracker.Entities.Region", "Region")
                        .WithMany()
                        .HasForeignKey("RegionId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Region");
                });

            modelBuilder.Entity("NerTracker.Entities.GrantData", b =>
                {
                    b.HasOne("NerTracker.Entities.Objective", "Objective")
                        .WithMany()
                        .HasForeignKey("ObjectiveId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("NerTracker.Entities.Region", "Region")
                        .WithMany()
                        .HasForeignKey("RegionId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("NerTracker.Entities.ServiceType", "ServiceType")
                        .WithMany()
                        .HasForeignKey("ServiceTypeId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Objective");

                    b.Navigation("Region");

                    b.Navigation("ServiceType");
                });

            modelBuilder.Entity("NerTracker.Entities.Departement", b =>
                {
                    b.Navigation("Communes");
                });

            modelBuilder.Entity("NerTracker.Entities.GrantData", b =>
                {
                    b.Navigation("BenefTrackers");
                });
#pragma warning restore 612, 618
        }
    }
}
