using Microsoft.AspNetCore.Identity;

namespace BlazorApp1.Entities
{
    public class UserRole
    {
        public const string Guest = "Visiteur";

        public const string Benef = "Beneficiare";

        public const string Moderator = "Moderateur";

        public const string Admin = "Admin";

        public const string SuperAdmin = "SuperAdmin";
    }
    public class NerTrackerUser:IdentityUser
    {
        public string? Firstname { get; set; }
        public string? Lastname { get; set; }
        public string Role { get; set; } = UserRole.Guest;
    }
}
