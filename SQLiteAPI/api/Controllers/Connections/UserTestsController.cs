
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/test/user")]
public class UserTestsController : ControllerBase
{
    private readonly UserManager<User> _userManager;
    private readonly ITestRepository _testRepo;
    private readonly IUserTestRepo _userTestRepo;

    public UserTestsController(UserManager<User> userManager, ITestRepository testRepo, IUserTestRepo userTestRepo)
    {
        _userManager = userManager;
        _testRepo = testRepo;
        _userTestRepo = userTestRepo;
    }

    [HttpGet]
    [Authorize]
    public async Task<IActionResult> GetUserTest()
    {
        string userName = User.GetUserName();
        User? user = await _userManager.FindByNameAsync(userName);

        if (user == null) return NotFound();

        List<Test>? userTests = await _userTestRepo.GetUserTest(user);

        return Ok(userTests);
    }

    [HttpPost]
    [Authorize]
    public async Task<IActionResult> Create(int testId)
    {
        string userName = User.GetUserName();
        User? user = await _userManager.FindByNameAsync(userName);
        Test? test = await _testRepo.GetByIdAsync(testId);

        if (user == null || test == null) return BadRequest();

        List<Test>? userTests = await _userTestRepo.GetUserTest(user);

        if (userTests.Any(t => t.ID == testId)) return BadRequest();

        UserTests newUserTestConnection = new()
        {
            UserID = user.Id,
            TestID = test.ID
        };

        await _userTestRepo.CreateAsync(newUserTestConnection);

        if (newUserTestConnection == null) return StatusCode(500, "Could not create");
        
        else return Created();
    }
}