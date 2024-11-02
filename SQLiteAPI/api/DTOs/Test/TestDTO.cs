public class TestDTO
{
    public int ID { get; set; }
    public string? Title { get; set; } = string.Empty;
    public string? TestSettings { get; set; } = string.Empty;
    public string? QuestionData { get; set; } = string.Empty;
    public int CreatedOn { get; set; }
    public string? UserID { get; set; } = string.Empty;
    public List<ResultDTO>? Results { get; set; } = [];
}