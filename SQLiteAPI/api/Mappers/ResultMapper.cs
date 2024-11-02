public static class ResultMapper
{
    public static ResultDTO ToResultDTO(this Result resultModel)
    {
        return new ResultDTO()
        {
            ID = resultModel.ID,
            // TestID = resultModel.TestID,
            // TestTitle = resultModel.Test.Title,
            // UserID = resultModel.UserID,
            UserName = resultModel.UserName,
            ResultData = resultModel.ResultData,
            CreatedOn = resultModel.CreatedOn
        };
    }

    public static Result ToResultFromCreate(this CreateResultDTO requestBody, int testId)
    {
        return new Result()
        {
            TestID = testId,
            UserName = requestBody.UserName,
            CreatedOn = DateTime.Now.ToUnixTimestamp(),
            ResultData = requestBody.ResultData,
        };
    }

    public static Result FromAddNewToResult(this AddTestResultDTO requestModel) {
        return new Result() {
            CreatedOn = requestModel.CreatedOn,
            ResultData = requestModel.ResultData
        };
    }
}