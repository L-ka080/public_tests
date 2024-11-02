using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

public class ApplicationDBContext : IdentityDbContext<User>
{
    public ApplicationDBContext(DbContextOptions contextOptions) : base(contextOptions)
    {

    }

    public DbSet<Test> Tests { get; set; }
    public DbSet<Result> Results { get; set; }
    public DbSet<UserTests> UserTests { get; set; }
    public DbSet<UserResults> UserResults { get; set; }

    protected override void OnModelCreating(ModelBuilder builder)
    {
        base.OnModelCreating(builder);

        builder.Entity<UserTests>(x => x.HasKey(k => new { k.UserID, k.TestID }));

        builder.Entity<UserTests>()
            .HasOne(ut => ut.User)
            .WithMany(u => u.UserTests)
            .HasForeignKey(ut => ut.UserID);

        builder.Entity<UserTests>()
            .HasOne(ut => ut.Test)
            .WithMany(u => u.UserTests)
            .HasForeignKey(ut => ut.TestID);

        builder.Entity<UserResults>(x => x.HasKey(k => new { k.UserID, k.ResultID }));

        builder.Entity<UserResults>()
            .HasOne<User>()
            .WithMany(u => u.UserResults)
            .HasForeignKey(ur => ur.UserID);

        builder.Entity<UserResults>()
            .HasOne<Result>()
            .WithMany(r => r.UserResults)
            .HasForeignKey(ur => ur.ResultID);

        List<IdentityRole> roles = new()
    {
            new IdentityRole {
                Name = "Admin",
                NormalizedName = "ADMIN"
            },
            new IdentityRole {
                Name = "User",
                NormalizedName ="USER"
            },
    };

        builder.Entity<IdentityRole>().HasData(roles);


    }
}