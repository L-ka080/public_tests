using System.ComponentModel.DataAnnotations;
using Microsoft.EntityFrameworkCore;

public class RegisterDTO
{
    [Required]
    public string UserName { get; set; } = string.Empty;

    [Required]
    [EmailAddress]
    public string Email { get; set; } = string.Empty;

    [Required]
    public string Password { get; set; } = string.Empty;
}