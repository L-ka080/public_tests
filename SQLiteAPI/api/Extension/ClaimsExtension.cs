using System.Security.Claims;

public static class ClaimsExtension
{
    public static string GetUserName(this ClaimsPrincipal user)
    {
        return user.Claims.SingleOrDefault(u => u.Type.Equals("http://schemas.xmlsoap.org/ws/2005/05/identity/claims/givenname")).Value;
    }
}