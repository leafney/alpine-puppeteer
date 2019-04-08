### alpine-nodejs

#### Get Image from Docker Hub

```
$ docker pull leafney/alpine-nodejs
```

#### Run default container

```
$ docker run --name nodeapp -d -p 8000:8000 leafney/alpine-nodejs:latest
```

#### Run a container for your nodejs app

The main directory of the project in the container is `/app`.

```
$ docker run --name nodeapp -d -p 8000:8000 -v /home/tiger/node_app:/app leafney/alpine-nodejs:latest
```

If you set the log directory to `/logs` in the PM2 configuration file, you can do this:

```
$ docker run --name nodeapp -d -p 8000:8000 -v /home/tiger/node_app:/app -v /home/tiger/node_logs:/logs leafney/alpine-nodejs:latest
```

***

#### Node App Demo

##### simplest Express application

Take a simplest Express application as an example. More: [Express "Hello World" example](https://expressjs.com/en/starter/hello-world.html)

Create the project directory:

```
$ mkdir node_app

$ cd node_app
```

Use `yarn` to init:

```
$ yarn init
```

Install needed package `express`.

```
$ yarn add express
```

Create the main file of `index.js` in path `/src`.

```
const express = require('express')
const app = express()
const port = 8000

app.get('/', (req, res) => res.send('Nodejs App Running in Docker!'))

app.listen(port, () => console.log(`Example app listening on port ${port}!`))
```

The default port is `8000`.

Run the app with the following command:

```
$ node src/index.js
```

Then, load `http://localhost:8000/` in a browser to see the output.

*****

##### Modify pm2 config file

The `ecosystem.config.js` is `pm2` config file. You need to change the configuration items that have been applied to your project.

```
module.exports = {
  apps: [{
    name: 'node_app',
    script: './src/index.js',
    instances: 1,
    autorestart: true,
    watch: false,
    // watch: ["src"],
    // ignore_watch: ["node_modules"],
    max_memory_restart: '50M',
    log_date_format: 'YYYY-MM-DD HH:mm:ss',
    out_file: '/logs/puppet_out.log',
    error_file: '/logs/puppet_error.log',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production'
    }
  }],
};
```

##### Run

Copy all files in the `node_app` directory to the volume directory and restart the container.

Enjoy it!

*****

#### Change container timezone UTC to CST

If the container name is `nodeapp`,use command `docker exec nodeapp utc2cst.sh` to change:

```
$ docker exec nodeapp utc2cst.sh
[i] change timezone success
Mon Apr  8 01:52:13 CST 2019

$ docker restart nodeapp
nodeapp
```

*****

#### show app status

use `mp2 list` or `mp2 list` to get app status:

```
docker exec -it nodeapp pm2 list
# or:
docker exec -it nodeapp pm2 monit
# (use `q` exit)
```
*****
