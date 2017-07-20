# WeatherDemo

1、需要ios8.0及更高系统版本
2、开源API：实时气象，接口文档地址：http://www.36wu.com/Service/Details/1
3、使用接口需要申请authkey，每个authkey只有一天的试用期限
4、使用cocoapods管理第三方类库，主要使用了JSONModel和AFNetworking
5、使用objective-c语言编写，定义了生成通用控件的工具类和接收网络数据的基类，可减少开发中写控件和处理接收网络层数据的时间
6、支持城市列表的获取，直接在api返回的数据中提取一部分，并生成本地json文件，用于城市的筛选，并查看选择城市天气



