using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.AspNetCore.Identity;

[Table("Results")]
public class Result
{
    public int ID { get; set; }
    public int CreatedOn { get; set; }
    public string ResultData { get; set; } = string.Empty;
    public string UserName {get; set;} = string.Empty;

    // public List<TestResults>? TestResults { get; set; } = [];

    // public string? UserID { get; set; } = string.Empty;
    // public User? User { get; set; }

    // public string? UserID { get; set; } = string.Empty;
    // public User? User { get; set; }
    public List<UserResults>? UserResults = [];
    public int TestID { get; set; }
    public Test Test { get; set; }
}