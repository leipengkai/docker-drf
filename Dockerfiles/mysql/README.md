
[mysql+django使用utf8mb4字符集](https://www.leipengkai.com/article/23)
```bash
# 改变数据库的字符集
ALTER DATABASE mxshop1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
# 改变表的字符集,在需要的表加就可以了,其它的表就不要动
alter table mxshop1.goods_goods convert to character set utf8mb4 collate utf8mb4_bin;
```
