# MLS Deployment

This repository contains docker-compose definitions and the configuration to deploy a full development instance of the MLS system locally.

As of now, many core features are already present, but the system is far from production ready, or even complete.
It should go without saying that this **must not be used for production and/or with actual real-world data!**

## Configuration Files

Most service configuration can be used as-is.

Running the Google Maps based geocoding services (i.e., `mls-geocoding-gmaps` and `mls-geocoding-intersection`) requires an API key.
You need to copy the file `config/geocoding-gmaps/keys/gmaps-key-template.yml` to `gmaps-key.yml` and add your key there.

## Starting the Services

There are three `docker-compose` files:

* `docker-compose.yml` contains the core services required for basic function of the system.
  These are `mls-gateway`, `mls-auth`, `mls-coceso`, `mls-frontend`, `mls-amqp`, and `mls-db`.
* `docker-compose-geocoding.yml` contains geocoding providers.
  These are `mls-geocoding-poi`, `mls-geocoding-vienna`, `mls-geocoding-gmaps`, and `mls-geocoding-intersection`.
* `docker-compose-message.yml` contains providers for sending and receiving messages, and a mocked gateway.
  These are `mls-message-fleetsync`, `mls-message-sms`, `mls-message-tetra`, and `mls-message-mock-gateway`.

You can start each of these sets by running `docker-compose -f <file>.yml up` with the respective YAML file.
You can also start all services
together by running

```shell
docker-compose -f docker-compose.yml -f docker-compose-geocoding.yml -f docker-compose-message.yml up
```

The frontend is exposed on port `8089`, the backend API gateway on port `8090`.
Use the auto-generated user `admin`:`password` for logging in.

The Docker images are pulled automatically if not present locally.
Alternatively, you can use the docker-compose command `pull` to forcefully download them.

# Advanced Options

By default, the tag `latest` is used for all services, and each service is started with the configuration below `./config`.

The default tag can be overridden by setting the environment variable `<SERVICE>_TAG=other-tag`.
The path to the config directory can be overridden with `<SERVICE>_CONFIG=/path/to/config/dir`.
`SERVICE` is the uppercase, underscored name of the service, such as `MLS_COCESO_TAG` for the service `mls-coceso`.

Settings for *all* services can be overridden using the `docker-env.sh` script with the `MLS_TAG` and `MLS_CONFIG` variables:

The following example command will use the tag `master` for all services except for `mls-coceso`, which is explicitly set to `dev`:

```shell
MLS_TAG=master MLS_COCESO_TAG=dev ./docker-env.sh docker-compose -f [...] up
```

The following example will use the config files from `~/local-config/<service-suffix>`,
where `<service-suffix>` is the service name without the `mls-` prefix (i.e., the same directory structure as in `./config`):

```shell
MLS_CONFIG=~/local-config ./docker-env.sh docker-compose -f [...] up
```
