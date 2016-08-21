using System.Linq;

using FluentAssertions;

using SampleApiApp.Controllers;
using SampleApiApp.Tests.Fixtures;

using Xunit;

namespace SampleApiApp.Tests
{
    /// <summary>
    /// This represents the test entity for the <see cref="ValuesController"/> class.
    /// </summary>
    public class ValuesControllerTest : IClassFixture<ValuesControllerFixture>
    {
        private readonly ValuesController _controller;

        /// <summary>
        /// Initialises a new instance of the <see cref="ValuesControllerTest"/> class.
        /// </summary>
        /// <param name="fixture"><see cref="ValuesControllerFixture"/> instance.</param>
        public ValuesControllerTest(ValuesControllerFixture fixture)
        {
            this._controller = fixture.ValuesController;
        }

        /// <summary>
        /// Tests whether the method should return result or not.
        /// </summary>
        [Fact]
        public void Given_NoParameter_Get_ShouldReturn_EnumerableResult()
        {
            // Assign

            // Act
            var result = this._controller.Get().ToList();

            // Assert
            result.Should().HaveCount(2);
        }
    }
}