public class AddTestResultDTO
{
    public string UserName = string.Empty;
    public int CreatedOn = DateTime.Now.ToUnixTimestamp();
    public string? ResultData;
}