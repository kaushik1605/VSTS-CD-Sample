using System;

using SampleApiApp.Controllers;

namespace SampleApiApp.Tests.Fixtures
{
    /// <summary>
    /// This represents the fixture entity for the <see cref="ValuesControllerTest"/> class.
    /// </summary>
    public class ValuesControllerFixture : IDisposable
    {
        private bool _disposed;

        /// <summary>
        /// Initialises a new instance of the <see cref="ValuesControllerFixture"/> class.
        /// </summary>
        public ValuesControllerFixture()
        {
            this.ValuesController = new ValuesController();
        }

        /// <summary>
        /// Gets the <see cref="ValuesController"/> instance.
        /// </summary>
        public ValuesController ValuesController { get; }

        /// <summary>
        /// Performs application-defined tasks associated with freeing, releasing, or resetting unmanaged resources.
        /// </summary>
        public void Dispose()
        {
            if (this._disposed)
            {
                return;
            }

            this._disposed = true;
        }
    }
}