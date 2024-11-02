public interface ITestRepository
{
    Task<List<Test>> GetAllAsync();
    Task<List<Test>> GetAllAsync(string userId);
    Task<Test?> GetByIdAsync(int testId);

    Task<Test> CreateAsync(Test testModel);

    Task<Test?> UpdateAsync(int testId, UpdateTestRequestDTO updateTest);
    Task<Test?> DeleteAsync(int testId);
    Task<Test?> AddNewResult(int testId, Result newResult);
    Task<bool> IsExists(int testId);

    // Task<List<Test>> GetAllByUserIdAsync(int userId);
    // List<Test> GetAllByUserId(int userId);
}