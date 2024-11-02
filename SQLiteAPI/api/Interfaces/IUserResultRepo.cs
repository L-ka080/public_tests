public interface IUserResultRepo
{
    Task<List<Result>> GetUserResult(User user);
    Task<UserResults?> CreateAsync(User user, Result result);
}