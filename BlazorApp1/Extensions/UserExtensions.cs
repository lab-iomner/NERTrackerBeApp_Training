using BlazorApp1.Entities;
using Microsoft.AspNetCore.Identity;

namespace BlazorApp1.Extensions
{
    public static partial class UserExtensions
    {
        public static string? PassGenerate(this NerTrackerUser user, string password)
        {
            if (password is { Length: < 5 })
                return null;
            var passHash = new PasswordHasher<NerTrackerUser>();
            return passHash.HashPassword(user, password);
        }
    }
}