using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/result")]
public class UserResultsController : ControllerBase
{
    private readonly UserManager<User> _userManager;
    private readonly IResultRepository _resultRepo;
    private readonly IUserResultRepo _userResultRepo;

    public UserResultsController(UserManager<User> userManager, IResultRepository resultRepo, IUserResultRepo userResultRepo)
    {
        _userManager = userManager;
        _resultRepo = resultRepo;
        _userResultRepo = userResultRepo;
    }

    [HttpGet]
    [Authorize]
    public async Task<IActionResult> GetUserResult()
    {
        string userName = User.GetUserName();
        User? user = await _userManager.FindByNameAsync(userName);

        if (user == null) return BadRequest();

        List<Result>? userResults = await _userResultRepo.GetUserResult(user);

        List<ResultDTO> resultList = [];

        foreach (Result result in userResults)
        {
            resultList.Add(result.ToResultDTO());
        }

        return Ok(userResults);
    }

    // [HttpGet]
    // [Authorize]
    // public async Task<IActionResult> GetUserResultByTest(int testId) {
    //     string userName = User.GetUserName();
    //     User? user = await _userManager.FindByNameAsync(userName);

    //     if (user == null) return BadRequest();

    //     List<Result>? userResults = await _userResultRepo.GetUserResultByTest(user, testId);
    // }
}