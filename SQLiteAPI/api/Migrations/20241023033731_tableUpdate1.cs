using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace api.Migrations
{
    /// <inheritdoc />
    public partial class tableUpdate1 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_UserTestsConnections_AspNetUsers_UserId",
                table: "UserTestsConnections");

            migrationBuilder.DropForeignKey(
                name: "FK_UserTestsConnections_Tests_TestId",
                table: "UserTestsConnections");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "1c867c9b-7112-48c1-877b-4e21fb42b930");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "ff1181d2-933a-44d3-a650-070d73b34649");

            migrationBuilder.DropColumn(
                name: "Time",
                table: "Tests");

            migrationBuilder.RenameColumn(
                name: "TestId",
                table: "UserTestsConnections",
                newName: "TestID");

            migrationBuilder.RenameColumn(
                name: "UserId",
                table: "UserTestsConnections",
                newName: "UserID");

            migrationBuilder.RenameIndex(
                name: "IX_UserTestsConnections_TestId",
                table: "UserTestsConnections",
                newName: "IX_UserTestsConnections_TestID");

            migrationBuilder.RenameColumn(
                name: "TestType",
                table: "Tests",
                newName: "TestSettings");

            migrationBuilder.CreateTable(
                name: "UserResultsConnections",
                columns: table => new
                {
                    UserID = table.Column<string>(type: "TEXT", nullable: false),
                    ResultID = table.Column<int>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserResultsConnections", x => new { x.UserID, x.ResultID });
                    table.ForeignKey(
                        name: "FK_UserResultsConnections_AspNetUsers_UserID",
                        column: x => x.UserID,
                        principalTable: "AspNetUsers",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_UserResultsConnections_Results_ResultID",
                        column: x => x.ResultID,
                        principalTable: "Results",
                        principalColumn: "ID",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "5f7daac2-1b12-475a-a136-a20800727e30", null, "Admin", "ADMIN" },
                    { "de888687-d2ae-44ff-9972-1691fb211ee6", null, "User", "USER" }
                });

            migrationBuilder.CreateIndex(
                name: "IX_UserResultsConnections_ResultID",
                table: "UserResultsConnections",
                column: "ResultID");

            migrationBuilder.AddForeignKey(
                name: "FK_UserTestsConnections_AspNetUsers_UserID",
                table: "UserTestsConnections",
                column: "UserID",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserTestsConnections_Tests_TestID",
                table: "UserTestsConnections",
                column: "TestID",
                principalTable: "Tests",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_UserTestsConnections_AspNetUsers_UserID",
                table: "UserTestsConnections");

            migrationBuilder.DropForeignKey(
                name: "FK_UserTestsConnections_Tests_TestID",
                table: "UserTestsConnections");

            migrationBuilder.DropTable(
                name: "UserResultsConnections");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "5f7daac2-1b12-475a-a136-a20800727e30");

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: "de888687-d2ae-44ff-9972-1691fb211ee6");

            migrationBuilder.RenameColumn(
                name: "TestID",
                table: "UserTestsConnections",
                newName: "TestId");

            migrationBuilder.RenameColumn(
                name: "UserID",
                table: "UserTestsConnections",
                newName: "UserId");

            migrationBuilder.RenameIndex(
                name: "IX_UserTestsConnections_TestID",
                table: "UserTestsConnections",
                newName: "IX_UserTestsConnections_TestId");

            migrationBuilder.RenameColumn(
                name: "TestSettings",
                table: "Tests",
                newName: "TestType");

            migrationBuilder.AddColumn<int>(
                name: "Time",
                table: "Tests",
                type: "INTEGER",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[,]
                {
                    { "1c867c9b-7112-48c1-877b-4e21fb42b930", null, "Admin", "ADMIN" },
                    { "ff1181d2-933a-44d3-a650-070d73b34649", null, "User", "USER" }
                });

            migrationBuilder.AddForeignKey(
                name: "FK_UserTestsConnections_AspNetUsers_UserId",
                table: "UserTestsConnections",
                column: "UserId",
                principalTable: "AspNetUsers",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_UserTestsConnections_Tests_TestId",
                table: "UserTestsConnections",
                column: "TestId",
                principalTable: "Tests",
                principalColumn: "ID",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
