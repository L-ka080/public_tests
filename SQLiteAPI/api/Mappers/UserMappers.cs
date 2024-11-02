public static class UserMappers
{
    public static UserDTO ToUserDTO(this User userModel)
    {
        return new UserDTO()
        {
            Username = userModel.UserName,
            Email = userModel.Email,
            Name = userModel.Name,
            LastName = userModel.LastName,
            // TestDTOs = userModel.Tests?.Select(t => t.ToTestDTO()).ToList(),
            // ResultDTOs = userModel.Results?.Select(r => r.ToAnswerDTO()).ToList()
        };
    }

    // public static GetUserDTO ToGetUserDTO(this User userModel, string token)
    // {
    //     return new GetUserDTO() {
    //         UserName = userModel.UserName,
    //         Email = userModel.Email,
    //         Token = token
    //     };
    // }
}