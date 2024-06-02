class EnvironmentProperties {
  final int cacheLifespan;
  final EndpointProperties endpoint;

  const EnvironmentProperties({
    required this.cacheLifespan,
    required this.endpoint,
  });
}

class EndpointProperties {
  final String projeto;
  final int timeout;

  const EndpointProperties({
    required this.projeto,
    required this.timeout,
  });
}