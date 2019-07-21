### rabbitmq相关定义:
> Broker(RabbitMQ Server): 简单来说就是消息队列服务器实体,是一种传输服务

- 维护一条从Producer到Consumer的路线,保证数据能够按照指定的方式进行传输

> VHost: 虚拟主机,一个broker里可以开设多个vhost,用作不同用户的权限分离

- 也可以看作是:服务器中的一个数据库或者服务器中的一个目录路径
- 每个virtual host本质上都是一个RabbitMQ Server，拥有它自己的queue，exchagne，和bings rule等等。这保证了你可以在多个不同的Application中使用RabbitMQ

> Connection: 就是一个TCP的连接.Producer和Consumer都是通过TCP连接到RabbitMQ Server的

> Channel: 消息通道,在客户端的每个连接里,可建立多个channel,每个channel代表一个会话任务

- 为什么使用Channel,而不是直接使用TCP连接:对于OS来说,建立和关闭TCP连接是有代价的,频繁的建立关闭TCP连接对于系统的性能有很大的影响,而且TCP的连接数也有限制,这也限制了系统处理高并发的能力
- 但是,在TCP连接中建立Channel是没有上述代价的,对于Producer或者Consumer来说,可以并发的使用多个Channel进行Publish或者Receive
- 我们大部分的业务操作是在Channel这个接口中完成的，包括定义Queue、定义Exchange、绑定Queue与Exchange、发布消息等

> Producer: 消息生产者,就是投递消息的程序

> Routing Key: 路由关键字,exchange根据这个关键字进行消息投递

- 生产者在将消息发送给Exchange的时候,一般会指定一个Routing Key,来指定这个消息的路由规则.
- 而这个Routing Key需要与Exchange Type及Binding key联合使用才能最终生效
- 在Exchange Type与Binding key固定的情况下(在正常使用时一般这些内容都是固定配置好的),我们的生产者就可以在发送消息给Exchange时,通过指定Routing Key来决定消息流向哪里

> Exchange: 消息交换机,它指定消息按什么规则,路由到哪个队列
- exchange，交换器名称
- type，交换器类型，如fanout,direct,topic
- durable，是否持久化，持久化可以将交换器存盘，在服务器重启后不会丢失相关信息
- autoDelete，是否自动删除。自动删除的前提是至少有一个队列或交换器与这个交换器绑定，之后所有与这个交换器绑定的队列或交换器都与此解绑，并不是与此连接的客户端都断开
- internal，是否是内置的，内置的交换器客户端无法直接发送消息到这个交换器中，只能通过交换器路由到交换器的方式
- argument，其他一些结构化参数

- Exchange Type有fanout、direct、topic、headers这四种（AMQP规范里还提到两种Exchange Type，分别为system与自定义)

> Binding: 绑定,它的作用就是把exchange和queue按照路由规则绑定起来

> Queue: 消息队列载体,每个消息都会被投入到一个或多个队列

- queue，队列名称
- durable，是否持久化。持久化的队列会存盘，在服务器重启时可以保证不丢失相关信息
- exclusive，是否排他，如果一个队列声明为排他，该队列仅对首声声明它的连接可见，并在连接断开后自动删除
- autoDelete，是否自动删除。自动删除前提是：至少有一个消费者连接到这个队列，之后所有与这个队列连接的消费者都断开时，才自动删除
- arguments，其他参数

> Consumer: 消息消费者,就是接受消息的程序

> Message acknowledgment:no_ack:为保证消息从队列可靠达到消费者(针对消费者,是否要删除队列中的消息)

- 在实际应用中,可能会发生消费者收到Queue中的消息,但没有处理完成就宕机(或出现其他意外)的情况,这种情况下就可能会导致消息丢失
- 为了避免这种情况发生,我们可以要求消费者在消费完消息后发送一个回执给RabbitMQ,RabbitMQ收到消息回执(Message acknowledgment)后才将该消息从Queue中移除


> Message durability:针对rabbitmq,是否将消息持久化

- 如果我们希望即使在RabbitMQ服务重启的情况下,也不会丢失消息,我们可以将Queue与Message都设置为可持久化的(durable),这样可以保证绝大部分情况下我们的RabbitMQ消息不会丢失.
- 消息队列持久化包括3个部分: 
    - exchange持久化,在声明时指定durable => 1 
    - queue持久化,在声明时指定durable => 1 
    - 消息持久化,在投递时(生产者)指定delivery_mode => 2(1是非持久化)
    - 如果exchange和queue都是持久化的,那么它们之间的binding也是持久化的.如果exchange和queue两者之间有一个持久化,一个非持久化,就不允许建立绑定
- 但依然解决不了小概率丢失事件的发生(比如RabbitMQ服务器已经接收到生产者的消息,但还没来得及持久化该消息时RabbitMQ服务器就断电了),如果我们需要对这种小概率事件也要管理起来,那么我们要用到事务.由于这里仅为RabbitMQ的简单介绍，所以这里将不讲解RabbitMQ相关的事务


> rabbitmq的消息确认机制(事务+confirm):针对生产者

- 在rabbitmq中,我们可以通过持久化数据,解决rabbitmq服务端异常的数据丢失问题
- 但生产者将消息发送出去之后,消息到底有没有到达rabbitmq服务端,默认的情况下是不知道的
- 解决的方法之一: rabbitmq中的Confirm模式,它是异步的
    - 生产者将channel设置成confirm模式,一旦channel进入confirm模式,所有在该channel上面发布的消息都会被指派一个唯一的ID(从1开始),一旦消息被投递到所有匹配的队列之后,broker就会发送一个确认给生产者(包含消息的唯一ID),这就使得生产者知道消息已经正确到达目的队列了.如果消息和队列是可持久化的,那么确认消息会将消息写入磁盘之后发出.
    - broker回传给生产者的确认消息中 deliver-tag域包含了确认消息的序列号,此外broker也可以设置basic.ack的multiple域,表示这个序列号之前的所有消息都已经得了处理.
- 解决的方法之一: AMQP协议实现了事务机制(类似Mysql的事务)

```
        channel.queue_declare(queue=QUEUENAME, durable=True)
        try:
            channel.tx_select()


            channel.basic_publish(
                exchange='',
                routing_key=QUEUENAME,
                body=body_json,
                properties=pika.BasicProperties(
                    delivery_mode=2,  # make message persistent
                )
            )
            print(1/0)
            channel.tx_commit()
        except ValueError as e:
            print(e)
            channel.tx_rollback()
        # 由于这种方式(走协议,发请求),会经常连接服务器,导致有一定的耗时,进而降低了rabbitmq的吞吐量


```

[rabbitmq可视化管理web](http://0.0.0.0:15672/#/queues)

[官方实例](https://www.rabbitmq.com/getstarted.html), [相对较旧的中文实例](https://rabbitmq.mr-ping.com/tutorials_with_python/[1]Hello_World.html):当作英文版的翻译.  [本项目](./start):基本和官方一样,只是有点自己的注释

[选择监控](https://www.psychz.net/client/question/en/zabbix-vs-nagios-vs-cacti.html)

参考:

[一篇全面透彻的RabbitMQ指南](https://juejin.im/entry/599e5e3b5188252437799049)
[RabbitMQ深入理解(一)进阶/管理/配置](https://pdf.us/2018/06/01/1167.html)
生产者:客户端与MQ服务器建立一个连接connection->在连接上创建一个信道channel->创建一个交换器exchange和一个队列queue,并通过路由键进行绑定->发送消息->关闭资源
消费端的监控(),高并发生产者时的解决办法(celery异步)

