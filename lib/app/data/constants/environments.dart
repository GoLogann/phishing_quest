import 'package:phishing_quest/app/data/models/constants/environment_properties.model.dart';

/// Representing local environment configuration
const EnvironmentProperties LOCAL_ENV = EnvironmentProperties(
  cacheLifespan: 60000, // 1 minute
  endpoint: EndpointProperties(
    projeto: 'https://ba0e26373dc0.ngrok.app/api/v1', //8082
    timeout: 1000,
  ),
);

/// Representing production environment configuration
const EnvironmentProperties PRODUCTION_ENV = EnvironmentProperties(
  cacheLifespan: 300000, // 5 minutes
  endpoint: EndpointProperties(
    projeto: 'http://projeto-phishingquest.labsc.com.br/api/v1',
    timeout: 80,
  ),
);
