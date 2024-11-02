public class UserDTO
{
    public int? ID { get; set; }
    public string? Username { get; set; }
    public string? Email { get; set; }
    public string? Name { get; set; }
    public string? LastName { get; set; }
    public List<TestDTO>? TestDTOs { get; set; }
    public List<ResultDTO>? ResultDTOs { get; set; }
}