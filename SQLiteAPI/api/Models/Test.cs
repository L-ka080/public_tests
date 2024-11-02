using System.ComponentModel.DataAnnotations.Schema;

[Table("Tests")]
public class Test
{
    public int ID { get; set; }
    public string Title { get; set; } = string.Empty;
    // public string? TestType { get; set; } = string.Empty;
    // public int Time { get; set; }
    public int CreatedOn { get; set; } = DateTime.Now.ToUnixTimestamp();
    public string? QuestionData { get; set; } = string.Empty;
    public string? TestSettings {get; set; } = string.Empty;

    public List<UserTests>? UserTests { get; set; }

    public List<Result> Results { get; set; } = [];
}