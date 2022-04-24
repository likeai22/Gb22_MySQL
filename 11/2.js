const Redis = require('ioredis');
const redis = new Redis({
    port: 6379,
    host: '127.0.0.1',
    db: 0,
});

const makeid = length => {
    let result = '';
    let characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    let charactersLength = characters.length;
    for (let i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() *
            charactersLength));
    }
    return result;
};

const args = [];

for (let i = 0; i < 10; i++) {
    let ip = (Math.floor(Math.random() * 255) + 1) + "." + (Math.floor(Math.random() * 255)) + "." + (Math.floor(Math.random() * 255)) + "." + (Math.floor(Math.random() * 255));
    args.push(makeid(10), ip);
}

async function run() {
    await redis.hmset('users', ...args)
    redis.disconnect();
}

run();
