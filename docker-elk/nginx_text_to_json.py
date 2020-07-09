#!/usr/bin/python3 

import re
import json
import ast
s2 = '113.87.129.3 - - [11/May/2020:04:59:23 +0000] "GET /static/css/common.css?v=a102a92df871e774cf0f3402baa75b18 HTTP/1.1" 200 1528 "https://www.leipengkai.com/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36" "-"'
s = '173.252.79.120 - - [06/Jul/2020:13:39:29 +0000] "GET /article/41 HTTP/1.1" 200 12644 "-" "facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php)" "-"'

j = { "time_local": "06/Jul/2020:13:45:26 +0000", "remote_addr": "119.28.42.37", "referer": "-", "request": "GET / HTTP/1.1", "status": 200, "bytes": 3692, "http_user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36", "x_forwarded": "-" }

# 最终格式
json_format =  { "time_local": "09/Jul/2020:13:37:04 +0800", "remote_addr": "157.55.39.23", "referer": "-", "request": "GET /robots.txt HTTP/1.1", "status": 404, "bytes": 651, "http_user_agent": "Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)", "x_forwarded": "-", "up_addr": "172.30.0.4:80","up_host": "-","upstream_time": "0.000","request_time": "0.004","host":"172.30.0.5","http_host":"www.leipengkai.com","tcp_xff":"-" }
# print(type(s))
# print(type(j))

# result = re.search('(\d+\.\d+\.\d+\.\d+).*?\[(.*)\] \"(.*)\"? (\d{3}) (\d+) \"?(.+?)\"? \"?(.+)\" \"?(.+)\"',s)
# print(result)
# print(result.group(1)) # remote_addr
# print(result.group(2))  # time_local
# print(result.group(3))  # request
# print(result.group(4))  # status
# print(result.group(5))  # bytes
# print(result.group(6))  # referer
# print(result.group(7))  # http_user_agent
# print(result.group(8))  # x_forwarded

# d = {
    # "time_local": result.group(2), 
    # "remote_addr": result.group(1),
    # "referer": result.group(6),
    # "request": result.group(3),
    # "status": result.group(4),
    # "bytes": result.group(5),
    # "http_user_agent": result.group(7),
    # "x_forwarded": result.group(8),
    # }
# ok = json.dumps(d)

def creazyRead():
    i = 1
    ms = open("no_json_access.log")
    for line in ms.readlines():
        result = re.search('(\d+\.\d+\.\d+\.\d+).*?\[(.*)\] \"(.*)\"? (\d{3}) (\d+) \"?(.+?)\"? \"?(.+)\" \"?(.+)\"',s2)
        d = {
        "time_local": result.group(2), 
        "remote_addr": result.group(1),
        "referer": result.group(6),
        "request": result.group(3),
        "status": result.group(4),
        "bytes": result.group(5),
        "http_user_agent": result.group(7),
        "x_forwarded": result.group(8),
        "up_addr": "172.30.0.4:80",
        "up_host": "-",
        "upstream_time": "0.000",
        "request_time": "0.004",
        "host":"172.30.0.5",
        "http_host":"www.leipengkai.com",
        "tcp_xff":"-" 
        }
        ok = json.dumps(d)
        with open("json_access.log","a") as mon:
            mon.write(ok + "\n")
            i += 1 

    print(i)

def creazyReadJson():
    i = 1
    ms = open("get_json_access.log")
    for line in ms.readlines():
        # try:
            # line = line.decode('utf-8')
        # except UnicodeDecodeError:
            # line = line.decode('GB18030')
        d = ast.literal_eval(line)
        d["host"] = "172.30.0.5"
        d["http_host"] = "www.leipengkai.com"
        d["tcp_xff"] = "-" 
        ok = json.dumps(d)
        with open("json_access.log","a") as mon:
            mon.write(ok + "\n")
            i += 1 
    print(i)

if __name__ == "__main__":
    # execute only if run as a script
    # creazyRead()  # 注意都是追加
    print(" creazyRead ok")
    # 将带有json的选出来
    # sed -e '/time_local/!d'  some_json_access.log  > get_json_access.log 
    creazyReadJson() # 注意都是追加
    print(" creazyReadJson ok")
    pass


