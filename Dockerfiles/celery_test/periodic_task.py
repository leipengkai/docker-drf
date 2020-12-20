from celery import Celery
from celery.schedules import crontab
 
HOST_IP = "127.0.0.1"

app = Celery('crontab_tasks',backend='redis', broker='pyamqp://rabbitmq:rabbitmq@{}//'.format(HOST_IP),\
            result_backend='redis://{}:6379/0'.format(HOST_IP))
 
@app.on_after_configure.connect
def setup_periodic_tasks(sender, **kwargs):

    # 定时任务模块叫celery beat
    # add_periodic_task会添加一条定时任务

    # Calls test('hello') every 10 seconds.
    sender.add_periodic_task(10.0, test.s('hello'), name='add every 10')
 
    # Calls test('world') every 30 seconds
    sender.add_periodic_task(30.0, test.s('world'), expires=10)
 
    # Executes every Monday morning at 7:30 a.m.
    sender.add_periodic_task(
        crontab(hour=7, minute=30, day_of_week=1),
        test.s('Happy Mondays!'),
    )
 
@app.task
def test(arg):
    print(arg)




# 配置文件的添加
# 每30s执行的任务

@app.task
def test_ctrontab(x,y):
    print("running...",x,y)
    return x+y


app.conf.beat_schedule = {
    'add-every-30-seconds': {
        'task': 'periodic_task.test_ctrontab',
        'schedule': 30.0,
        'args': (16, 16)
    },
}
app.conf.timezone = 'UTC'

