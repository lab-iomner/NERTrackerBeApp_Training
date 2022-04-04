using Microsoft.EntityFrameworkCore;
using Polly;
using System.ComponentModel.DataAnnotations;

namespace NerTracker.Components
{
    public partial class BaseEdit
    {
        BaseEditModel _model = new BaseEditModel();

        protected override void OnParametersSet()
        {
            _model = IsNew() ? new BaseEditModel() : new BaseEditModel()
            {
                BenefFemme = Model.DFemme18_349 + Model.DFemme35Plus,
                BenefHomme = Model.DHomme18_349 + Model.DHomme35Plus,
                GrantNumber = Model.GrantId,
                ServiceTypeId = Model.Grant!.ServiceTypeId,
                ObjectifId = Model.Grant!.ObjectiveId,
                RegionId = Model.Grant!.RegionId
            };
        }

        protected async override Task OnAfterRenderAsync(bool firstRender)
        {
            if (firstRender)
            {
                await Policy.Handle<Exception>()
                    .WaitAndRetryAsync(5, n => TimeSpan.FromMilliseconds(100 * n), (ex, attempt) => _isBusy = false)
                    .ExecuteAsync(() => InitializeData());
                StateHasChanged();
            }
        }

        async Task InitializeData()
        {
            _servcieTypes = await NerTrackerDbContext
                    .ServiceTypes.Select(x => x.Name)
                    .ToListAsync();
        }
    }

    public class BaseEditModel
    {
        public int RegionId { get; set; }

        [Required(ErrorMessage = "Veuillez spécifier une region")]
        public string Region { get; set; } = null!;

        public string? GrantNumber { get; set; }

        public int ServiceTypeId { get; set; }
        public string ServiceType { get; set; } = null!;

        public int ObjectifId { get; set; }
        public string Objectif { get; set; } = null!;

        public int BenefHomme { get; set; }

        public int BenefFemme { get; set; }
    }
}
