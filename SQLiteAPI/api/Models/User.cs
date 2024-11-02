using Microsoft.AspNetCore.Identity;

public class User : IdentityUser
{
    public string Name { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;

    // public List<Test>? Tests { get; set; }
    public List<UserTests>? UserTests { get; set; } = [];
    public List<UserResults>? UserResults { get; set; } = [];

    // public List<UserTests>? UserTests { get; set; }
    // public List<Result>? Results { get; set; }
}