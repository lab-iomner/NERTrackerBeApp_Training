using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace NerTracker.Migrations
{
    public partial class InitialisationDelaBD : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Departements",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Designation = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Departements", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Communes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Designation = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DepartementId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Communes", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Communes_Departements_DepartementId",
                        column: x => x.DepartementId,
                        principalTable: "Departements",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Communes_DepartementId",
                table: "Communes",
                column: "DepartementId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Communes");

            migrationBuilder.DropTable(
                name: "Departements");
        }
    }
}
