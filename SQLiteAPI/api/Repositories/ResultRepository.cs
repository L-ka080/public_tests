
using Microsoft.EntityFrameworkCore;

public class ResultRepository : IResultRepository
{
    private readonly ApplicationDBContext _context;
    public ResultRepository(ApplicationDBContext context)
    {
        _context = context;
    }

    public async Task<List<Result>> GetAllAsync()
    {
        return await _context.Results.ToListAsync();
    }

    public async Task<Result?> GetByIdAsync(int resultId)
    {
        return await _context.Results.FindAsync(resultId);
    }

    public async Task<Result> CreateAsync(Result resultModel)
    {
        await _context.Results.AddAsync(resultModel);
        await _context.SaveChangesAsync();
        return resultModel;
    }
    public async Task<Result?> UpdateAsync(int answerId, UpdateResultDTO updateResult)
    {
        Result? originalResult = await _context.Results.FirstOrDefaultAsync(answer => answer.ID == answerId);

        if (originalResult == null) return null;

        originalResult.ResultData = updateResult.ResultData;

        await _context.SaveChangesAsync();
        return originalResult;
    }
    public async Task<Result?> DeleteAsync(int answerId)
    {
        Result? originalResult = await _context.Results.FirstOrDefaultAsync(answer => answer.ID == answerId);

        if (originalResult == null) return null;

        _context.Results.Remove(originalResult);

        await _context.SaveChangesAsync();
        return originalResult;
    }

    public async Task<List<ResultDTO>> GetAllByTestAsync(int testID)
    {
        return await _context.Results
            .Where(result => result.TestID == testID)
            .Select(result => result.ToResultDTO()).ToListAsync();
    }
}