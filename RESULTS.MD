## Results on <u>single</u> API server with SQL proxy (3 node cluster behind proxy)
```
ab -n 500000 -c 250 http://localhost:8091/api/notebooks\?page\=0\&pageSize\=10

This is ApacheBench, Version 2.3 <$Revision: 1913912 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 50000 requests
Completed 100000 requests
Completed 150000 requests
Completed 200000 requests
Completed 250000 requests
Completed 300000 requests
Completed 350000 requests
Completed 400000 requests
Completed 450000 requests
Completed 500000 requests
Finished 500000 requests


Server Software:
Server Hostname:        localhost
Server Port:            8091

Document Path:          /api/notebooks?page=0&pageSize=10
Document Length:        1075 bytes

Concurrency Level:      250
Time taken for tests:   119.195 seconds
Complete requests:      500000
Failed requests:        0
Total transferred:      590000000 bytes
HTML transferred:       537500000 bytes
Requests per second:    4194.80 [#/sec] (mean)
Time per request:       59.598 [ms] (mean)
Time per request:       0.238 [ms] (mean, across all concurrent requests)
Transfer rate:          4833.85 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   1.9      0      92
Processing:     2   59 129.4     38    3742
Waiting:        0   59 129.3     37    3742
Total:          2   59 129.4     38    3742

Percentage of the requests served within a certain time (ms)
  50%     38
  66%     49
  75%     58
  80%     66
  90%     98
  95%    144
  98%    270
  99%   1008
 100%   3742 (longest request)
```

# ## Results on <u>3</u> API servers behind NGINX load balancer with SQL proxy (3 node cluster behind proxy)
```
 ab -n 500000 -c 250 http://localhost:8090/api/notebooks\?page\=0\&pageSize\=10
This is ApacheBench, Version 2.3 <$Revision: 1913912 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking localhost (be patient)
Completed 50000 requests
Completed 100000 requests
Completed 150000 requests
Completed 200000 requests
Completed 250000 requests
Completed 300000 requests
Completed 350000 requests
Completed 400000 requests
Completed 450000 requests
Completed 500000 requests
Finished 500000 requests


Server Software:        nginx/1.29.1
Server Hostname:        localhost
Server Port:            8090

Document Path:          /api/notebooks?page=0&pageSize=10
Document Length:        1082 bytes

Concurrency Level:      250
Time taken for tests:   153.020 seconds
Complete requests:      500000
Failed requests:        0
Total transferred:      604500000 bytes
HTML transferred:       541000000 bytes
Requests per second:    3267.55 [#/sec] (mean)
Time per request:       76.510 [ms] (mean)
Time per request:       0.306 [ms] (mean, across all concurrent requests)
Transfer rate:          3857.88 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   2.6      0      78
Processing:     2   76  81.3     57    2225
Waiting:        2   75  81.2     57    2225
Total:          2   76  81.3     58    2225

Percentage of the requests served within a certain time (ms)
  50%     58
  66%     79
  75%     95
  80%    107
  90%    150
  95%    200
  98%    294
  99%    389
 100%   2225 (longest request)
```