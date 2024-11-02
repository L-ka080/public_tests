
using Microsoft.EntityFrameworkCore;

public class UserResultsRepository : IUserResultRepo
{
    public readonly ApplicationDBContext _context;

    public UserResultsRepository(ApplicationDBContext context)
    {
        _context = context;
    }

    public async Task<List<Result>> GetUserResult(User user)
    {
        return await _context.UserResults.Where(ur => ur.UserID == user.Id)
            .Select(result => new Result
            {
                ID = result.Result.ID,
                CreatedOn = result.Result.CreatedOn,
                UserName = result.Result.UserName,
                ResultData = result.Result.ResultData,
                TestID = result.Result.TestID,
                Test = result.Result.Test,
            }).ToListAsync();
    }

    public async Task<UserResults?> CreateAsync(User user, Result result) {
        UserResults newConnection = new() {
            ResultID = result.ID,
            UserID = user.Id
        };
        
        await _context.UserResults.AddAsync(newConnection);

        await _context.SaveChangesAsync();
        return newConnection;
    }
}