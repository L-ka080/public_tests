using System.ComponentModel.DataAnnotations.Schema;

[Table("UserTestsConnections")]
public class UserTests
{
    public string? UserID { get; set; }
    public int TestID { get; set; }
    public User User { get; set; }
    public Test Test { get; set; }
}