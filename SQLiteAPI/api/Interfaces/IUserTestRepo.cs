public interface IUserTestRepo
{
    Task<List<Test>> GetUserTest(User user);
    Task<UserTests> CreateAsync(UserTests userTests);
}