
using Microsoft.EntityFrameworkCore;

public class UserTestsRepository : IUserTestRepo
{
    private readonly ApplicationDBContext _context;

    public UserTestsRepository(ApplicationDBContext context)
    {
        _context = context;
    }

    public async Task<List<Test>> GetUserTest(User user)
    {
        return await _context.UserTests.Where(ut => ut.UserID == user.Id)
            .Select(test => new Test
            {
                ID = test.Test.ID,
                QuestionData = test.Test.QuestionData,
                CreatedOn = test.Test.CreatedOn,
                TestSettings = test.Test.TestSettings,
                Title = test.Test.Title,
                // Results = test.Test.Results,
            }).ToListAsync();
    }


    public async Task<UserTests> CreateAsync(UserTests userTests)
    {
        await _context.UserTests.AddAsync(userTests);
        await _context.SaveChangesAsync();
        return userTests;
    }
}