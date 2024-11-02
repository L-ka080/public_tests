public interface IResultRepository
{
    Task<List<Result>> GetAllAsync();

    Task<Result?> GetByIdAsync(int answerId);

    Task<Result> CreateAsync(Result answerModel);
    Task<Result?> UpdateAsync(int answerId, UpdateResultDTO answerDTO);
    Task<Result?> DeleteAsync(int answerId);

    Task<List<ResultDTO>> GetAllByTestAsync(int testID);
}