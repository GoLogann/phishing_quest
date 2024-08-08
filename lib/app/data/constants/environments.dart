import 'package:phishing_quest/app/data/models/constants/environment_properties.model.dart';

/// Representing local environment configuration
const EnvironmentProperties LOCAL_ENV = EnvironmentProperties(
  cacheLifespan: 60000, // 1 minute
  endpoint: EndpointProperties(
    projeto: 'https://44d3-45-228-140-19.ngrok-free.app/api/v1', //8080
    timeout: 1000,
  ),
);

/// Representing production environment configuration
const EnvironmentProperties PRODUCTION_ENV = EnvironmentProperties(
  cacheLifespan: 300000, // 5 minutes
  endpoint: EndpointProperties(
    projeto: 'https://phishingquest.labsc.com.br/api/v1',
    timeout: 80,
  ),
);
