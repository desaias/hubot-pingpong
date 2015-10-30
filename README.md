# hubot-pingpong

Keep track of you ping pong games and stats.

See [`src/pingpong.coffee`](src/pingpong.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-pingpong --save`

Then add **hubot-pingpong** to your `external-scripts.json`:

```json
["hubot-pingpong"]
```
Also make sure to add **HUBOT_FIREBASE_URL** as an env variable on startup (trailing slash is important!)
```
env HUBOT_FIREBASE_URL='https://<app-name>.firebaseio.com/'
```
## Sample Interaction

### To save a game
```
example>> hubot ping pong <score> <winner> <loser> 

user>> hubot ping pong 10-9 Dave Quinn
```

### To see player stats
```
user>> ping pong stats
```
