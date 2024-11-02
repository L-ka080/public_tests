public static class TestMappers
{
    public static TestDTO ToTestDTO(this Test testModel)
    {
        return new TestDTO()
        {
            ID = testModel.ID,
            Title = testModel.Title,
            TestSettings = testModel.TestSettings,
            QuestionData = testModel.QuestionData,
            CreatedOn = testModel.CreatedOn,
            Results = testModel.Results?.Select(answer => answer.ToResultDTO()).ToList(),
        };
    }

    public static TestResultsDTO ToTestResultsDTO(this Test testModel)
    {
        return new TestResultsDTO() {
            // FIXME Разработать функцию для этого дела
        };
    }

    public static Test ToTestFromCreate(this CreateTestRequestDTO requestBody)
    {
        return new Test()
        {
            Title = requestBody.Title,
            TestSettings = requestBody.TestSettings,
            QuestionData = requestBody.QuestionData,
            CreatedOn = DateTime.Now.ToUnixTimestamp(),
            Results = []
        };
    }

    public static Test ToTestFromUpdate(this UpdateTestRequestDTO requestBody)
    {
        return new Test()
        {
            Title = requestBody.Title,
            TestSettings = requestBody.TestSettings,
            QuestionData = requestBody.QuestionData
        };
    }
}