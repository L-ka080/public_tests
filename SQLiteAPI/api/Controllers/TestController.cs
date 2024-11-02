using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

[Route("api/test")]
[ApiController]
public class TestController : ControllerBase
{
    readonly private ITestRepository _testRepo;
    // private readonly IUserRepository _userRepo;
    readonly private UserManager<User> _userManager;
    readonly private IUserTestRepo _userTestsRepo;

    public TestController(ITestRepository testRepo, UserManager<User> usersController, IUserTestRepo userTestsRepo)
    {
        _testRepo = testRepo;
        // _userRepo = userRepo;
        _userManager = usersController;
        _userTestsRepo = userTestsRepo;
    }

    [HttpGet]
    public async Task<IActionResult> GetAllAsync()
    {
        List<Test> tests = await _testRepo.GetAllAsync();
        List<TestDTO> testDTOs = tests.Select(selection => selection.ToTestDTO()).ToList();

        return Ok(testDTOs);
    }

    [HttpGet("user/{userId}")]
    public async Task<IActionResult> GetAllByUser([FromRoute] string userId)
    {
        List<Test> userTests = await _testRepo.GetAllAsync(userId);

        List<TestDTO> testDTOs = userTests.Select(test => test.ToTestDTO()).ToList();

        return Ok(testDTOs);
    }

    [HttpGet("{testId:int}")]
    public async Task<IActionResult> GetById([FromRoute] int testId)
    {
        Test? test = await _testRepo.GetByIdAsync(testId);

        if (test == null) return NotFound();

        return Ok(test.ToTestDTO());
    }

    [HttpPost("new")]
    [ActionName("GetById")]
    [Authorize]
    public async Task<IActionResult> Create(CreateTestRequestDTO createTest)
    {
        // if (!await _userRepo.IsExists(userId)) return BadRequest("User does not exists");
        if (!ModelState.IsValid) return BadRequest();

        string userName = User.GetUserName();

        User? user = await _userManager.FindByNameAsync(userName);
        if (user == null) NotFound();

        Test testModel = createTest.ToTestFromCreate();

        await _testRepo.CreateAsync(testModel);

        UserTests newTestConnection = new();
        newTestConnection.TestID = testModel.ID;
        newTestConnection.UserID = user!.Id;
        
        await _userTestsRepo.CreateAsync(newTestConnection);

        return CreatedAtAction(nameof(GetById), new { id = testModel }, testModel.ToTestDTO());
    }

    // [HttpPut("{testId:int}/result/new")]
    // [ActionName("GetById")]
    // [Authorize]
    // public async Task<IActionResult> AddNewResult([FromRoute] int testId, AddTestResultDTO requestModel) {
    //     if (!ModelState.IsValid) return BadRequest();

    //     Result newResult = requestModel.FromAddNewToResult();
    //     Test? test = await _testRepo.AddNewResult(testId, newResult);

    //     if (test == null) return BadRequest("Test with this id does not exists");

    //     User? user = await _userManager.FindByNameAsync(requestModel.UserName);

    //     if (user == null) return BadRequest();

    //     await _userResultRepo.CreateAsync(user, newResult);

    //     return Ok();
    // }

    [HttpPut]
    [Route("{testId:int}")]
    public async Task<IActionResult> Update([FromRoute] int testId, [FromBody] UpdateTestRequestDTO updateTest)
    {
        Test? updatedTestModel = await _testRepo.UpdateAsync(testId, updateTest);

        if (updatedTestModel == null) return NotFound();

        return Ok(updatedTestModel.ToTestDTO());
    }

    [HttpDelete]
    [Route("{testId:int}")]
    public async Task<IActionResult> Delete([FromRoute] int testId)
    {
        Test? deletedTestModel = await _testRepo.DeleteAsync(testId);

        if (deletedTestModel == null) return NotFound();

        return Ok(deletedTestModel.ToTestDTO());
    }
}