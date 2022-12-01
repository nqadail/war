# War

War card game simulation

## Overview

This app is a simple war card game simulator that provides two endpoints:

- GET /api/war/get_wins

    returns lifetime wins for each player

- POST /api/war/start_game

```
    {
        "player1":"<email>",
        "player2":"<email>"
    }
```

    shuffles the deck, and simulates a game. Will return all of the turns until game completion, and record a win for the
    winning player in the database.

## Assumptions and considerations

Given the limited amount of time for this exercise, as well as the wide-open nature of the requirement, the following assumptions have been made:

- There is no authentication mechanism or any authn/authz implementation. In a real-world implementation, these would typically already exist, along with data-entry screens to facilitate entering necessary data into the database, and a real-world app would plug into the existing mechanisms.

    Implementing such a scheme would seem to be significantly beond the scope of the exercise. Instead, users are identified by email address.

- A simple one to many relation (user has many wins) will be implemented and entries in the users table will be created if no email exists. The relation between the tables will be on user_id, but this data will not be exposed through the API.

- Although the GET and POST verbs are used here, there is not actually a distinction between them; i.e. the verb itself does not change behavior.

## Implementation notes

## Assumptions and
