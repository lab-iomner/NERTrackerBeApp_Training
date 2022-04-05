using Microsoft.AspNetCore.Components;
using Microsoft.EntityFrameworkCore;
using NerTracker.Data;
using NerTracker.Entities;
using Polly;
using Radzen;

namespace NerTracker.Components
{
    public partial class BaseEditNouveau
    {
        BaseEditModel _model = new();
        IEnumerable<ServiceType> _servcieTypes = new List<ServiceType>();
        IEnumerable<Objective> _objectifs = new List<Objective>();
        IEnumerable<Region> _regions = new List<Region>();
        IEnumerable<GrantData> _grantDatas = new List<GrantData>();
        List<string> _grantNames = new();

        bool _isSmall = false;
        bool _isBusy = false;
        bool IsNew() => Model is null || Model.Id <= 0;

        [Inject] 
        public NerTrackerDbContext NerTrackerDbContext { get; set; } = null!;
        [Inject] DialogService DialogService { get; set; } = null!;

        [Inject] NavigationManager NavigationManager { get; set; }

        void Cancel(bool canRefresh = false) => DialogService.Close(canRefresh);
        [Parameter] public EventCallback<bool> CanRefresh { get; set; }

        [Parameter]
        public BenefTracker? Model { get; set; }

        void NaviguerALAcceuil()
        {
            NavigationManager.NavigateTo("/");
        }

        protected override void OnParametersSet()
        {
            _model = Model is null || Model.Id <= 0 ? new BaseEditModel() : new BaseEditModel()
            {
                BenefFemme = Model!.DFemme18_349,
                BenefHomme = Model.DHomme18_349,
                BenefFemmePlus35 = Model.DFemme35Plus,
                BenefHommePlus35 = Model.DHomme35Plus,
                SelectedGrantName = Model.Grant!.Title,
                SelectedObjectif = Model.Grant!.Objective!.Description,
                SelectedRegion = Model.Grant!.Region!.Name,
                SelectedServiceType = Model.Grant!.ServiceType!.Name
            };
            Model ??= new BenefTracker();
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

        void OnGrantSelected(string value)
        {
            var grant = _grantDatas.FirstOrDefault(x => x.Title == value);
            if (grant is not null)
            {
                _model.SelectedObjectif = grant.Objective!.Description;
                _model.SelectedServiceType = grant.ServiceType!.Name;
                _model.SelectedRegion = grant.Region!.Name;
                _model.GrantNumber = grant.Number;
                _model.GrantTitle = grant.Title;
            }
            else
            {
                _model.SelectedObjectif = null;
                _model.SelectedServiceType = null;
                _model.SelectedRegion = null!;
                _model.GrantTitle = null;
                _model.GrantNumber = null!;
            }
        }

        async Task InitializeData()
        {
            _model.SelectedGrantName = null;
            _model.BenefHommePlus35 = null;
            _model.BenefHomme = null;
            _model.BenefFemmePlus35 = null;
            _model.BenefFemme = null;
            _grantDatas = await NerTrackerDbContext.GrantDatas
                .Include(x => x.Objective)
                .Include(x => x.Region)
                .Include(x => x.ServiceType)
                .ToListAsync();
            _grantNames = _grantDatas.Select(x => x.Title).ToList();
            _grantNames.Add("Autres");

            _servcieTypes = await NerTrackerDbContext
                    .ServiceTypes
                    .ToListAsync();
            _objectifs = await NerTrackerDbContext
                .Objectives
                .ToListAsync();
            _regions = await NerTrackerDbContext
                .Regions
                .ToListAsync();
        }

        async Task Save()
        {
            _isBusy = true;
            Model!.GrantId = _model.SelectedGrantName == "Autres"
                ? await SaveGrant(_model, NerTrackerDbContext, _objectifs, _servcieTypes, _regions)
                : _grantDatas.First(x => x.Title == _model.SelectedGrantName).Number;
            Model.DFemme18_349 = _model.BenefFemme ?? 0;
            Model.DHomme18_349 = _model.BenefHomme ?? 0;
            Model.DFemme35Plus = _model.BenefFemmePlus35 ?? 0;
            Model.DHomme35Plus = _model.BenefHommePlus35 ?? 0;
            _ = IsNew()
                ? await NerTrackerDbContext.AddAsync(Model)
                : NerTrackerDbContext.Update(Model);

            var result = await NerTrackerDbContext.SaveChangesAsync();
            if (result > 0)
            {
                await InitializeData();
                if (!_isSmall)
                {
                    await CanRefresh.InvokeAsync(true);
                    Model = new BenefTracker();
                }
                else
                    Cancel(true);
            }
            _isBusy = false;

            static async Task<string> SaveGrant(BaseEditModel model, NerTrackerDbContext dbContext, IEnumerable<Objective> objectifs, IEnumerable<ServiceType> servcieTypes, IEnumerable<Region> regions)
            {
                var grant = new GrantData()
                {
                    Title = model.GrantTitle,
                    Summary = model.GrantSummary,
                    Number = model.GrantNumber,
                    Status = model.GrantStatus
                };
                grant.ObjectiveId = objectifs.FirstOrDefault(x => x.Description == model.SelectedObjectif)?.Id
                    ?? SaveObjectif(model.SelectedObjectif, dbContext);
                grant.ServiceTypeId = servcieTypes.FirstOrDefault(x => x.Name == model.SelectedServiceType)?.Id
                    ?? SaveServiceType(model.SelectedServiceType, dbContext);
                grant.RegionId = regions.FirstOrDefault(x => x.Name == model.SelectedRegion)?.Id
                    ?? SaveRegion(model.SelectedRegion, dbContext);
                var savedGrant = await dbContext.GrantDatas.AddAsync(grant);
                await dbContext.SaveChangesAsync();
                return savedGrant.Entity.Number;
            }

            static int SaveObjectif(string description, NerTrackerDbContext dbContext)
            {
                var objectif = new Objective()
                {
                    Description = description,
                    Code = description.Substring(0, 2)
                };
                var savedObjectif = dbContext.Add(objectif);
                dbContext.SaveChanges();
                return savedObjectif.Entity.Id;
            }

            static string SaveRegion(string region, NerTrackerDbContext dbContext)
            {
                var savedItem = dbContext.Regions.Add(new Region() { Id = region.Substring(0, 2).ToUpper(), Name = region });
                dbContext.SaveChanges();
                return savedItem.Entity.Id;
            }

            static int SaveServiceType(string serviceType, NerTrackerDbContext dbContext)
            {
                var savedItem = dbContext.ServiceTypes.Add(new ServiceType() { Name = serviceType });
                dbContext.SaveChanges();
                return savedItem.Entity.Id;
            }
        }

    }
}
