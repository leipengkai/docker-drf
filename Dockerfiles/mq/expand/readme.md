# server_message

消息服务:
- 目前的消息服务只生成一个队列:info_queue
- 支持持久化,手动回执确认

基本流程:
- 生产:Product(TEST_EMAIL,"email_info","8899")
    - 第一个参数是:email,mobile
    - 第二个参数是模板,同时也是路由关键字(类型_类型操作type_action):sms_login,sms_register,email_info,
    - 如果不指定code,则会随机生成5位数的code
- 启动消费者服务:Custom(),消费所有消息
- 扩展性:通过在custom.py文件中,绑定不一样的回调函数来处理不同的业务逻辑

依赖包:
- aliyun-python-sdk-core 
- pika 
- SQLAlchemy 
- pymysql
- flask


