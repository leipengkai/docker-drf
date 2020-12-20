
from flask import Flask, request
from product import Product
from custom import Custom,callback_func


__all__ = ['app']

app = Flask(__name__)




@app.route('/')
def index():
    return '<h2>Welcome to Proxy Pool System</h2>'


@app.route('/custom')
def get_proxy():
    c1 = Custom()
    c1.handle(callback_func)
    """在监听,导致没有返回"""


# @app.route('/product', methods=['GET', 'POST'])
@app.route('/product')
def enab_product():
    """
    启动生产者
    :return:
    """
    # target = request.form.get('target')
    # routing_key = request.form.get('routing_key') # 模板,同时也是路由关键字(类型_类型操作type_action):sms_login
    # print('target: {}, routing_key: {}'.format(target,  routing_key))
    p1 = Product("1643076443@qq.com", "email_info")
    if p1.verification_target():
        p1.send()
    resp = {'status': 'ok', 'detail': '你好,生产者'}


if __name__ == '__main__':
    app.run(
        host='0.0.0.0',
        port=7777,
        debug=True
    )
# http://0.0.0.0:7777/product
# http://0.0.0.0:7777/custom