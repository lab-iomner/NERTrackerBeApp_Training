using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace NerTracker.Migrations
{
    public partial class AddMoreTables : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "RegionId",
                table: "Departements",
                type: "nvarchar(450)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "Objectives",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Code = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Objectives", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Regions",
                columns: table => new
                {
                    Id = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Regions", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "ServiceTypes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_ServiceTypes", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "GrantDatas",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Number = table.Column<string>(type: "nvarchar(450)", nullable: false),
                    Title = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Summary = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Status = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ObjectiveId = table.Column<int>(type: "int", nullable: false),
                    RegionId = table.Column<int>(type: "int", nullable: false),
                    RegionId1 = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    ServiceTypeId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_GrantDatas", x => x.Id);
                    table.UniqueConstraint("AK_GrantDatas_Number", x => x.Number);
                    table.ForeignKey(
                        name: "FK_GrantDatas_Objectives_ObjectiveId",
                        column: x => x.ObjectiveId,
                        principalTable: "Objectives",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_GrantDatas_Regions_RegionId1",
                        column: x => x.RegionId1,
                        principalTable: "Regions",
                        principalColumn: "Id");
                    table.ForeignKey(
                        name: "FK_GrantDatas_ServiceTypes_ServiceTypeId",
                        column: x => x.ServiceTypeId,
                        principalTable: "ServiceTypes",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "BenefTrackers",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    GrantNumber = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    DHomme18_349 = table.Column<int>(type: "int", nullable: false),
                    DHomme35Plus = table.Column<int>(type: "int", nullable: false),
                    DFemme18_349 = table.Column<int>(type: "int", nullable: false),
                    DFemme35Plus = table.Column<int>(type: "int", nullable: false),
                    IHomme18_349 = table.Column<int>(type: "int", nullable: false),
                    IHomme35Plus = table.Column<int>(type: "int", nullable: false),
                    IFemme18_349 = table.Column<int>(type: "int", nullable: false),
                    IFemme35Plus = table.Column<int>(type: "int", nullable: false),
                    SynchronizedOn = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BenefTrackers", x => x.Id);
                    table.ForeignKey(
                        name: "FK_BenefTrackers_GrantDatas_GrantNumber",
                        column: x => x.GrantNumber,
                        principalTable: "GrantDatas",
                        principalColumn: "Number");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Departements_RegionId",
                table: "Departements",
                column: "RegionId");

            migrationBuilder.CreateIndex(
                name: "IX_BenefTrackers_GrantNumber",
                table: "BenefTrackers",
                column: "GrantNumber");

            migrationBuilder.CreateIndex(
                name: "IX_GrantDatas_ObjectiveId",
                table: "GrantDatas",
                column: "ObjectiveId");

            migrationBuilder.CreateIndex(
                name: "IX_GrantDatas_RegionId1",
                table: "GrantDatas",
                column: "RegionId1");

            migrationBuilder.CreateIndex(
                name: "IX_GrantDatas_ServiceTypeId",
                table: "GrantDatas",
                column: "ServiceTypeId");

            migrationBuilder.AddForeignKey(
                name: "FK_Departements_Regions_RegionId",
                table: "Departements",
                column: "RegionId",
                principalTable: "Regions",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Departements_Regions_RegionId",
                table: "Departements");

            migrationBuilder.DropTable(
                name: "BenefTrackers");

            migrationBuilder.DropTable(
                name: "GrantDatas");

            migrationBuilder.DropTable(
                name: "Objectives");

            migrationBuilder.DropTable(
                name: "Regions");

            migrationBuilder.DropTable(
                name: "ServiceTypes");

            migrationBuilder.DropIndex(
                name: "IX_Departements_RegionId",
                table: "Departements");

            migrationBuilder.DropColumn(
                name: "RegionId",
                table: "Departements");
        }
    }
}
