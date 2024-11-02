using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

[Route("api/test/result")]
[ApiController]
public class ResultController : ControllerBase
{
    readonly private IResultRepository _resultRepo;
    readonly private ITestRepository _testRepo;
    // private readonly IUserRepository _userRepo;
    // private readonly 
    readonly private UserManager<User> _userManager;
    readonly private IUserResultRepo _userResultsRepo;
    public ResultController(IResultRepository resultRepo, ITestRepository testRepo, UserManager<User> userManager, IUserResultRepo userResultRepo)
    {
        _testRepo = testRepo;
        // _userRepo = userRepo;
        _resultRepo = resultRepo;
        _userManager = userManager;
        _userResultsRepo = userResultRepo;
    }

    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        List<Result> results = await _resultRepo.GetAllAsync();

        List<ResultDTO> resultDTOs = results.Select(selection => selection.ToResultDTO()).ToList();

        return Ok(resultDTOs);
    }

    [HttpGet("{resultId}")]
    public async Task<IActionResult> GetById([FromRoute] int resultId)
    {
        Result? result = await _resultRepo.GetByIdAsync(resultId);

        if (result == null) return NotFound();

        return Ok(result.ToResultDTO());
    }

    [HttpPost("{testId:int}")]
    [ActionName("GetById")]
    [Authorize]
    public async Task<IActionResult> Create([FromRoute] int testId, CreateResultDTO requestBody)
    {
        string? userName = User.GetUserName();
        User? user = await _userManager.FindByNameAsync(userName);

        if (user == null) return BadRequest();
        
        if (!await _testRepo.IsExists(testId)) return BadRequest("Test by this ID does not exists");

        Result resultModel = requestBody.ToResultFromCreate(testId);

        await _resultRepo.CreateAsync(resultModel);

        await _userResultsRepo.CreateAsync(user, resultModel);

        await _testRepo.AddNewResult(resultModel.TestID, resultModel);

        return CreatedAtAction(nameof(GetById), new { id = resultModel }, resultModel.ToResultDTO());
    }

    [HttpPut]
    [Route("{resultId:int}")]
    public async Task<IActionResult> Update([FromRoute] int resultId, [FromBody] UpdateResultDTO updateResult)
    {
        Result? updateResultModel = await _resultRepo.UpdateAsync(resultId, updateResult);

        if (updateResultModel == null) return NotFound();

        return Ok(updateResultModel.ToResultDTO());
    }

    [HttpDelete]
    [Route("{resultId:int}")]
    public async Task<IActionResult> Delete([FromRoute] int resultId)
    {
        Result? deletedAnswerModel = await _resultRepo.DeleteAsync(resultId);

        if (deletedAnswerModel == null) return NotFound();

        return Ok(deletedAnswerModel.ToResultDTO());
    }

    [HttpGet]
    [Route("{testId:int}")]
    // [Authorize]
    public async Task<IActionResult> GetByUser([FromRoute] int testId) {
        // string UserName = User.GetUserName();
        // User? user = await _userManager.FindByNameAsync(UserName);

        // if (user == null) return Unauthorized();

        List<ResultDTO> resultList = await _resultRepo.GetAllByTestAsync(testId);

        return Ok(resultList);
    }
}