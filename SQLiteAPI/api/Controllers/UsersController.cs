using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using SignInResult = Microsoft.AspNetCore.Identity.SignInResult;

[Route("api/user")]
public class UsersController : ControllerBase
{
    readonly private UserManager<User> _userManager;
    readonly private ITokenService _tokenService;
    readonly private SignInManager<User> _signInManager;

    public UsersController(UserManager<User> userManager, ITokenService tokenService, SignInManager<User> signinManager)
    {
        _userManager = userManager;
        _tokenService = tokenService;
        _signInManager = signinManager;
    }

    [HttpPost("register")]
    public async Task<IActionResult> Register(RegisterDTO registerDTO)
    {
        try
        {
            if (!ModelState.IsValid) return BadRequest(ModelState);

            User user = new()
            {
                UserName = registerDTO.UserName,
                Email = registerDTO.Email
            };

            IdentityResult createdUser = await _userManager.CreateAsync(user, registerDTO.Password);

            if (createdUser.Succeeded)
            {
                var roleResult = await _userManager.AddToRoleAsync(user, "User");
                if (roleResult.Succeeded)
                {
                    return Ok(new NewUserDTO()
                    {
                        UserName = user.UserName,
                        Email = user.Email,
                        Token = _tokenService.CreateToken(user)
                    });
                }
                else
                {
                    return BadRequest(roleResult.Errors);
                }
            }
            else
            {
                return BadRequest(createdUser.Errors);
            }
        }
        catch (Exception exc)
        {
            return StatusCode(500, exc);
        }
    }

    [HttpPost("login")]
    public async Task<IActionResult> Login(LoginDTO loginDTO)
    {
        if (!ModelState.IsValid) return BadRequest();

        User? user = await _userManager.Users.FirstOrDefaultAsync(user => user.UserName == loginDTO.UserName);

        if (user == null)
        {
            return Unauthorized("Username or password is not correct");
        }

        SignInResult result = await _signInManager.CheckPasswordSignInAsync(user, loginDTO.Password, false);

        if (!result.Succeeded) return Unauthorized("Username or password is not correct");

        return Ok(new NewUserDTO()
        {
            UserName = user.UserName ?? "",
            Email = user.Email ?? "",
            Token = _tokenService.CreateToken(user)
        });
    }

    [HttpPost("verify")]
    public async Task<IActionResult> Verify(LoginDTO loginDTO)
    {
        if (!ModelState.IsValid) return BadRequest("Something with the data is wrong");

        User? user = await _userManager.Users.FirstOrDefaultAsync(user => user.UserName == loginDTO.UserName);

        if (user != null)
        {
            return BadRequest("Username already taken");
        }
        else
        {
            return Ok();
        }
    }

    // [HttpPost("getUserData")]
    // [Authorize]
    // public Task<IActionResult> GetUserData()
    // {
    //     String userName = User.GetUserName();

    //     User? user = _userManager.Users.FirstOrDefault(user => user.UserName == userName);

    //     return Task.FromResult<IActionResult>(user == null ? BadRequest() : Ok(user.ToGetUserDTO()));
    // }
}