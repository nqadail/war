# War

War card game simulation

## Overview

This app is a simple war card game simulator that provides two endpoints:

- GET /api/war/get_wins

    returns lifetime wins for each player

- POST /api/war/start_game

    shuffles the deck, and simulates a game. Will return all of the turns until game completion, and record a win for the
    winning player in the database.

    Payload is as follows:

    {
        "playerA":"<email>",
        "playerB":"<email>"
    }

## Assumptions and considerations

Given the limited amount of time for this exercise, as well as the wide-open nature of the requirement, the following assumptions have been made:

There is no authentication mechanism or any authn/authz implementation. In a real-world implementation, these would typically already exist, along with data-entry screens to facilitate entering necessary data into the database, and a real-world app would plug into the existing mechanisms.

Implementing such a scheme would seem to be significantly beond the scope of the exercise. Instead, users are identified by email address.

A simple one to many relation (user has many wins) will be implemented and entries in the users table will be created if no email exists. The relation between the tables will be on user_id, but this data will not be exposed through the API.

Although the GET and POST verbs are used here, there is not actually a distinction between them; i.e. the verb itself does not change behavior.

## Implementation notes

For the sake of simplicity, this is a new project created using rails api.

There is a single controller, api_controller, that routes requests from each of the endpoints to the handler code.

The system is implemented with domain driven design to allow simple decoupling in the future. as such, a regime of api handlers and service objects/classes for the business logic is isolated from everything else. this is a pattern I have implemented in the past.

All of the code of interest is in app/domains/war

Additionally, very basic ActiveRecord is used with sql preferred for complex queries (sanitized for user input via temporary prepared statements, which is not necessary in this case). Upserts are done with ActiveRecord.

The game test is flickering due to the randomization of the pile added to bottom the winner's stack. This randomization was necessary as sometimes games would run forever without it. This may be a deficiency with my algorithm.

## Notes on Docker

This app is fully containerized for development using docker. Since I am using SqLite3, everything can be self-contained in a single container. The container starts up in a bash shell to make development easier via the bin/dev-start shell script. The bin/server script starts up the rails app. The dockerfile is also set up to read the source files from the host machine such that editing and git interaction does not need to happen inside the container.

All that is necessary to build the container is:

docker-compose build

and then:

bin/dev-start to start a bash shell inside

NOTE: thie first time this is run, you will need to create the SQLite database:

rails db:migrate

from within the container.
