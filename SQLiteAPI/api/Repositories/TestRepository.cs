
using Microsoft.EntityFrameworkCore;

public class TestRepository : ITestRepository
{
    private readonly ApplicationDBContext _context;
    public TestRepository(ApplicationDBContext context)
    {
        _context = context;
    }

    public async Task<Test> CreateAsync(Test testModel)
    {
        await _context.Tests.AddAsync(testModel);
        await _context.SaveChangesAsync();
        return testModel;
    }

    public async Task<List<Test>> GetAllAsync()
    {
        return await _context.Tests.Include(test => test.Results).ToListAsync();
    }

    public async Task<List<Test>> GetAllAsync(string userId)
    {
        // .Select(t => t.UserID == userId)
        List<Test> allTests = await _context.Tests.ToListAsync();
        List<Test> userTests = [];

        return userTests;
    }

    public async Task<Test?> GetByIdAsync(int testId)
    {
        return await _context.Tests.Include(test => test.Results).FirstOrDefaultAsync(test => test.ID == testId);
    }

    public async Task<Test?> UpdateAsync(int testId, UpdateTestRequestDTO updateTest)
    {
        Test? originalTest = await _context.Tests.FirstOrDefaultAsync(test => test.ID == testId);

        if (originalTest == null) return null;

        originalTest.Title = updateTest.Title;
        originalTest.QuestionData = updateTest.QuestionData;

        await _context.SaveChangesAsync();
        return originalTest;
    }
    public async Task<Test?> DeleteAsync(int testId)
    {
        Test? originalTest = await _context.Tests.FirstOrDefaultAsync(test => test.ID == testId);

        if (originalTest == null) return null;

        _context.Tests.Remove(originalTest);
        await _context.SaveChangesAsync();
        return originalTest;
    }
    public async Task<Test?> AddNewResult(int testId, Result newResult)
    {
        Test? test = await _context.Tests.FirstOrDefaultAsync(test => test.ID == testId);

        if (test == null) return null;

            test.Results.Add(newResult);

            await _context.SaveChangesAsync();

        return test;
    }

    public async Task<bool> IsExists(int testId)
    {
        return await _context.Tests.AnyAsync(t => t.ID == testId);
    }


}