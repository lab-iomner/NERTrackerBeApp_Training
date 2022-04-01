using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace NerTracker.Migrations
{
    public partial class MiseAjourPKGrant : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_BenefTrackers_GrantDatas_GrantNumber",
                table: "BenefTrackers");

            migrationBuilder.DropUniqueConstraint(
                name: "AK_GrantDatas_Number",
                table: "GrantDatas");

            migrationBuilder.DropPrimaryKey(
                name: "PK_GrantDatas",
                table: "GrantDatas");

            migrationBuilder.DropColumn(
                name: "Id",
                table: "GrantDatas");

            migrationBuilder.RenameColumn(
                name: "GrantNumber",
                table: "BenefTrackers",
                newName: "GrantId");

            migrationBuilder.RenameIndex(
                name: "IX_BenefTrackers_GrantNumber",
                table: "BenefTrackers",
                newName: "IX_BenefTrackers_GrantId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_GrantDatas",
                table: "GrantDatas",
                column: "Number");

            migrationBuilder.AddForeignKey(
                name: "FK_BenefTrackers_GrantDatas_GrantId",
                table: "BenefTrackers",
                column: "GrantId",
                principalTable: "GrantDatas",
                principalColumn: "Number");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_BenefTrackers_GrantDatas_GrantId",
                table: "BenefTrackers");

            migrationBuilder.DropPrimaryKey(
                name: "PK_GrantDatas",
                table: "GrantDatas");

            migrationBuilder.RenameColumn(
                name: "GrantId",
                table: "BenefTrackers",
                newName: "GrantNumber");

            migrationBuilder.RenameIndex(
                name: "IX_BenefTrackers_GrantId",
                table: "BenefTrackers",
                newName: "IX_BenefTrackers_GrantNumber");

            migrationBuilder.AddColumn<int>(
                name: "Id",
                table: "GrantDatas",
                type: "int",
                nullable: false,
                defaultValue: 0)
                .Annotation("SqlServer:Identity", "1, 1");

            migrationBuilder.AddUniqueConstraint(
                name: "AK_GrantDatas_Number",
                table: "GrantDatas",
                column: "Number");

            migrationBuilder.AddPrimaryKey(
                name: "PK_GrantDatas",
                table: "GrantDatas",
                column: "Id");

            migrationBuilder.AddForeignKey(
                name: "FK_BenefTrackers_GrantDatas_GrantNumber",
                table: "BenefTrackers",
                column: "GrantNumber",
                principalTable: "GrantDatas",
                principalColumn: "Number");
        }
    }
}
