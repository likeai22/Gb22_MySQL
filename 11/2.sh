redis-cli flushall

redis-cli hmset users 'OO73cMW5Nn' '58.46.209.210' 'D1k5xGQwEW' '105.156.225.252' 'jCf4Rzy4cD' '55.169.122.129' 'ZRHSAoHwbE' '170.128.76.28' 'WraAE0gkzo' '210.230.27.52' '9eNW8dkXHO' '24.43.192.39' 'BeIdq1k9cu' '5.80.58.244' 'fOv8p6ziso' '45.238.177.194' 'N0jZK5whBB' '149.215.61.221' 'Bv5dcDf6zn' '225.29.83.178'

redis-cli hgetall users

echo -e "\n*************************************************\n"
redis-cli hvals users