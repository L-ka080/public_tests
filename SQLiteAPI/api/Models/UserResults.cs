using System.ComponentModel.DataAnnotations.Schema;

[Table ("UserResultsConnections")]
public class UserResults
{
    public string UserID;
    public User User;
    
    public int? ResultID;
    public Result Result;
}