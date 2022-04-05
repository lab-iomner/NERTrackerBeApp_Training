using Microsoft.AspNetCore.Components;
using NerTracker.Entities;
using System.Reflection.Metadata;

namespace NerTracker.Components
{
    public partial class CommuneEdit
    {
        Commune _model = new Commune();
        [Parameter]
        public Commune? Commune { get; set; }

        Task Save()
        {
            return Task.CompletedTask;
        }
    }
}
