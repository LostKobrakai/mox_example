# Create the mock
Mox.defmock(MoxExample.CounterMock, for: MoxExample.Counter.Behaviour)

# Run the tests
ExUnit.start()
