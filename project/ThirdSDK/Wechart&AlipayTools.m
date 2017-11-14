////  Wechart&AlipayTools.m
////  GuangFuBao
////  Created by 薛超 on 16/12/6.
//#import "Wechart&AlipayTools.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import <AFNetworking/AFNetworking.h>
//#import "Order.h"
//#import "DataSigner.h"
//#import "APAuthV2Info.h"
//#pragma mark - 用于获取设备ip地址
//#import <ifaddrs.h>
//#import <arpa/inet.h>
//#import "WXApiRequestHandler.h"
//#define PartnerID  @""//合作身份者id，以2088开头的16位纯数字
//#define SellerID   @"info@isolar88.com"//收款支付宝账号
//#define MD5_KEY @""//安全校验码（MD5）密钥，以数字和字母组成的32位字符
//#define PartnerPrivKey  @"optwTqgev3"
//#define AlipayPubKey    @"/FCEa3/cNMW0QIDAQAB"
//#define alipayBackUrl @"http://www.isolar88.com"//支付宝回掉路径
//#define alipayAppid @""
//#define alipayServerUrl @"http://.com/alipay"//支付宝购买产品的自己服务器接口
//
/////FIXME:微信的
//#import "WXApi.h"
//#import "WXApiManager.h"
//#import "MXWechatSignAdaptor.h" //微信签名工具类
//#import "XMLDictionary.h"       //XML转换工具类
//#define WechartID @""//appID
//#define WechartSecret @""//secrete
//#define MerchantID @""//// 微信支付商户号
//#define MerchantLogin @""
//#define MerchantLoginmima @"847281"
//#define WechartSafeID @""// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com// 平台设置的“API密钥”，请设置为以数字和字母组成的32字符串。
//#define kUrlWechatPay   @"https://api.mch.weixin.qq.com/pay/unifiedorder"// 微信下单接口
//#define WXAPPID         @"appid"            // 应用id
//#define WXMCHID         @"mch_id"           // 商户号
//#define WXNONCESTR      @"nonce_str"        // 随机字符串
//#define WXSIGN          @"sign"             // 签名
//#define WXBODY          @"body"             // 商品描述
//#define WXOUTTRADENO    @"out_trade_no"     // 商户订单号
//#define WXTOTALFEE      @"total_fee"        // 总金额
//#define WXEQUIPMENTIP   @"spbill_create_ip" // 终端IP
//#define WXNOTIFYURL     @"notify_url"       // 通知地址
//#define WXTRADETYPE     @"trade_type"       // 交易类型
//#define WXPREPAYID      @"prepay_id"        // 预支付交易会话
//#define WXServerUrl     @"http://www.isolar88.com/wechartPay"//微信购买产品的自己服务器接口
//#define WXBackUrl       @"http://www.isolar88.com"
//
/////FIXME:QQWallet钱包支付
//#import <CommonCrypto/CommonHMAC.h>//用于QQ支付的签名
//#import "QQWalletSDK.h"
//#define QQWalletAPPID @"10069284"                             // 第三方APP在QQ钱包开放平台申请的appID
//#define QQWalletAPPKEY @""     // appID对应的appKey (这个key应当保存在后台，在后台进行签名)
//#define QQWalletMCHID @"201"// 第三方APP在财付通后台的商户号
//@interface Wechart_AlipayTools(){
//    UIViewController *currentVC;
//}
//@end
//@implementation Wechart_AlipayTools
//#pragma mark - Private Method
/////获取设备ip地址 1.貌似该方法获取ip地址只能在wifi状态下进行
//+ (NSString *)getIPAddress {
//    NSString *address = @"error";
//    struct ifaddrs *interfaces = NULL;
//    struct ifaddrs *temp_addr = NULL;
//    int success = 0;
//    success = getifaddrs(&interfaces);
//    if (success == 0) {
//        temp_addr = interfaces;
//        while(temp_addr != NULL) {
//            if(temp_addr->ifa_addr->sa_family == AF_INET) {
//                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
//                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                }
//            }temp_addr = temp_addr->ifa_next;
//        }
//    }
//    freeifaddrs(interfaces);
//    return address;
//}
/////生成N位随机码
//+ (NSString *)getNonstrWithNumber:(int)num{
//    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
//    NSMutableString *resultStr = [[NSMutableString alloc] init];
//    srand((unsigned)time(0));
//    for (int i = 0; i < num; i++){
//        unsigned index = rand() % [sourceStr length];
//        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
//        [resultStr appendString:oneStr];
//    }return resultStr;
//}
//-(NSString*)dictionaryToXML:(NSDictionary*)dict{
//    NSMutableString *mutableS = [NSMutableString string];
//    [mutableS appendString:@"<xml>"];
//    for(NSString *s in [dict allKeys]){
//        NSString *keyvalue = [NSString stringWithFormat:@"<%@>%@</%@>",s,dict[s],s];
//        [mutableS appendString:keyvalue];
//    }
//    [mutableS appendString:@"</xml>"];
//    return mutableS;
//}
//#pragma mark methods
//+(void)sendApplePayWithDelegate:(UIViewController<PKPaymentAuthorizationViewControllerDelegate>*)vc merchantID:(NSString *)merchantID label:(NSString *)label price:(NSString *)price{
//    if(![PKPaymentAuthorizationViewController canMakePayments]) {NSLog(@"PKPayment不可以付款");}
//    PKPaymentRequest *payment = [[PKPaymentRequest alloc] init];
//    PKPaymentSummaryItem *total = [PKPaymentSummaryItem summaryItemWithLabel:label amount:[NSDecimalNumber decimalNumberWithString:price]];
//    payment.paymentSummaryItems = @[total];
//    payment.currencyCode = @"CNY";// 人民币
//    payment.countryCode = @"CN";// 中国
//    payment.merchantIdentifier = merchantID;// 在 developer.apple.com member center 里设置的 merchantID
//    // Fixbug: 原来设置为 `PKMerchantCapabilityCredit` 在真机上无法回调 `didAuthorizePayment` 方法
//    payment.merchantCapabilities = PKMerchantCapability3DS | PKMerchantCapabilityEMV | PKMerchantCapabilityCredit | PKMerchantCapabilityDebit;
//    payment.supportedNetworks = @[PKPaymentNetworkChinaUnionPay];//支持哪种结算网关
//    PKPaymentAuthorizationViewController *payVC = [[PKPaymentAuthorizationViewController alloc] initWithPaymentRequest:payment];
//    payVC.delegate = vc;
//    [vc presentViewController:payVC animated:YES completion:NULL];
//}
//+(void)sendUnionPayWithTNModel:(NSString *)model URL:(NSURL *)url scheme:(NSString *)scheme delegate:(UIViewController *)vc{
//    Wechart_AlipayTools *this = [[Wechart_AlipayTools alloc]init];
//    [this startPayWithMode:model URL:url scheme:scheme delegate:vc];
//}
//-(void)startPayWithMode:(NSString*)mode URL:(NSURL*)url scheme:(NSString*)scheme delegate:(UIViewController*)vc{
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString* tn = [[NSMutableString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        if (tn != nil && tn.length > 0){
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[UPPaymentControl defaultControl] startPay:tn fromScheme:scheme mode:mode viewController:vc];
//            });
//        }
//    }];
//    [task resume];
//}
//+(void)sendAlipayWithProductName:(NSString*)name money:(NSString*)money{
//    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
//    NSString *appID = alipayAppid;
//    NSString *privateKey = PartnerPrivKey;
//    if ([appID length] == 0 || [privateKey length] == 0){NSLog(@"缺少appId或者私钥。");return;}
//    //生成订单信息及签名将商品信息赋予AlixPayOrder的成员变量
//    Order* order = [Order new];
//    order.app_id = appID;
//    order.method = @"alipay.trade.app.pay";// NOTE: 支付接口名称
//    order.charset = @"utf-8";// NOTE: 参数编码格式
//    NSDateFormatter* formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    order.timestamp = [formatter stringFromDate:[NSDate date]];// NOTE: 当前时间点
//    order.version = @"1.0";// NOTE: 支付版本
//    order.sign_type = @"RSA";// NOTE: sign_type设置
//    order.biz_content = [BizContent new];// NOTE: 商品数据
//    order.biz_content.body = @"测试一下，iOS 薛超的账号";
//    order.biz_content.subject = name;
//    order.biz_content.out_trade_no = [self getNonstrWithNumber:15]; //订单ID（由商家自行制定）
//    order.biz_content.timeout_express = @"30m"; //超时时间设置
//    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [money doubleValue]]; //商品价格
//    //    order.return_url = @"http://www.isolar88.com";
//    //    order.notify_url = @"http://www.isolar88.com";
//    NSString *orderInfo = [order orderInfoEncoded:NO];//将商品信息拼接成字符串
//    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
//    NSLog(@"orderSpec = %@",orderInfo);
//    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderInfo];
//    if (signedString != nil) {// NOTE: 如果加签成功，则继续执行支付
//        NSString *appScheme = @"alisdkdemo";//应用注册scheme,在AliSDKDemo-Info.plist定义URL types
//        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@", orderInfoEncoded, signedString];// 将签名成功字符串格式化为订单字符串,请严格按照该格式
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {// 调用支付结果开始支付
//            NSLog(@"reslut = %@",resultDic);
//        }];
//    }
//
//}
//+(void)sendAlipayAuther{
//    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
//    NSString *pid = PartnerID;
//    NSString *appID = alipayAppid;
//    NSString *privateKey = PartnerPrivKey;
//    if ([pid length] == 0 || [appID length] == 0 || [privateKey length] == 0){NSLog(@"缺少pid或者appID或者私钥。");return;}
//    APAuthV2Info *authInfo = [APAuthV2Info new];//生成 auth info 对象
//    authInfo.pid = pid;
//    authInfo.appID = appID;
//    //授权类型,AUTHACCOUNT:授权;LOGIN:登录
//    authInfo.authType = @"AUTHACCOUNT";
//    NSString *appScheme = @"alisdkdemo";//应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *authInfoStr = [authInfo description];// 将授权信息拼接成字符串
//    NSLog(@"authInfoStr = %@",authInfoStr);
//    // 获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:authInfoStr];
//    // 将签名成功字符串格式化为订单字符串,请严格按照该格式
//    if (signedString.length > 0) {
//        authInfoStr = [NSString stringWithFormat:@"%@&sign=%@&sign_type=%@", authInfoStr, signedString, @"RSA"];
//        NSLog(@"\n\n\n%@",authInfoStr);
//        [[AlipaySDK defaultService] auth_V2WithInfo:authInfoStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            NSString *result = resultDic[@"result"];// 解析 auth code
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
//    }
//
//}
//+(void)sendAlipayWithURL:(NSString*)url{
////    NSString *url = @"https://maliprod.alipay.com/w/trade_pay.do?app_name=tb&partner=PARTNER_TAOBAO_ORDER&biz_type=trade&sign=_v_dn%252Fv_ccid_cr3l5_kx2uu%252Blo_g_n_f2cg%252Ff_r_pqv_d27_cf_y_h6_e_n_z9_e_k9_lj2_pw%253D%253D&trade_no=2016121321001001135004190644&return_url=http%253A%252F%252Fhuodong.m.taobao.com%252Fbuy%252FpaySuccess.html%253FbizOrderId%253D2839050699668372%2526degrade%253D0%2526act%253Dfalse&sign_date=2016-12-13+14%3A24%3A14&extern_token=3a054b559cc0a19bd2d1dd166615b4dd&sign_type=DSA";
//    NSString* orderInfo = [[AlipaySDK defaultService]fetchOrderInfoFromH5PayUrl:[[NSURL URLWithString:url] absoluteString]];
//    //        NSString *url = @"trade_no=\"2016121321001001135404190644\"&pay_phase_id=\"\"&biz_type=\"trade\"&biz_sub_type=\"TRADE\"&app_name=\"tb\"&extern_token=\"3c04b85a6f05775577e54925b73d8337\"&appenv=\"\"&pay_channel_id=\"alipay_sdk\"";
//    NSLog(@"%@",orderInfo);
//    [[AlipaySDK defaultService]payUrlOrder:orderInfo fromScheme:@"alisdkdemo" callback:^(NSDictionary* result) {
//        NSLog(@"%@", result);
//        if ([result[@"isProcessUrlPay"] boolValue]) {// returnUrl 代表 第三方App需要跳转的成功页URL
//            NSLog(@"%@",result[@"returnUrl"]);
//        }
//    }];
//}
//
//+(void)sendThirdAlipayWithsometiong{
//    NSString *partner, *seller,*tradeNO, *productName,*productDescription,*amount,*notifyURL,*service,*paymentType,*inputCharset,*itBPay,*showUrl;
//    NSString * rsaDate,* appID;//可选
//    NSMutableDictionary * extraParams;
//    partner = @"2088021958107485";
//    seller = @"info@chinacityguard.com.cn";
//    tradeNO = [self getNonstrWithNumber:25]; //订单ID（由商家自行制定）
//    productName =@"爱光伏";//[data valueForJSONStrKey:@"member_name"]; //商品标题
//    productDescription =@"中城卫订单支付";//[data valueForJSONStrKey:@"tostr"]; //商品描述
//    amount = @"0.01"; //商品价格
//    notifyURL = @"http://zcw.55liketest.cn:80/app/pay/aliBodyguardNotify";  //回调URL
//    service = @"mobile.securitypay.pay";
//    paymentType = @"1";
//    inputCharset = @"utf-8";
//    itBPay = @"30m";
//    showUrl = @"m.alipay.com";
//    //将商品信息拼接成字符串
//    NSMutableString *orderSpec = [NSMutableString stringWithString:[NSString stringWithFormat:
//    @"partner=\"%@\"&seller_id=\"%@\"&out_trade_no=\"%@\"&subject=\"%@\"&body=\"%@\"&total_fee=\"%@\"&notify_url=\"%@\"&service=\"%@\"&\
//    payment_type=\"%@\"&_input_charset=\"%@\"&it_b_pay=\"%@\"&show_url=\"%@\"&sign_date=\"%@\"&app_id=\"%@\"",
//partner ,seller ,tradeNO ,productName ,productDescription ,amount ,notifyURL ,service ,paymentType ,inputCharset ,itBPay ,showUrl ,rsaDate ,appID]];
//    for (NSString *key in [extraParams allKeys]) {
//        [orderSpec appendFormat:@"&%@=\"%@\"", key, [extraParams objectForKey:key]];
//    }
//    NSString *appScheme = @"alisdkdemo";
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//NSString *PrivKey = @"MIMA==";
//    NSString *pristr = PrivKey;
//    id<DataSigner> signer = CreateRSADataSigner(pristr);
//    NSString *signedString = [signer signString:orderSpec];
//    if (signedString != nil) {
//        NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",orderSpec, signedString, @"RSA"];
//        NSLog(@"%@",orderString);
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"%@",resultDic);
//            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]){
//                
//            }
//        }];
//    }
//}
//
//#pragma mark - Payment delegate PKPaymentAuthorizationViewControllerDelegate 苹果官方支付协议需要写在遵守这个协议的控制器中。
//- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion {
//    NSLog(@"支付授权令牌: %@, %@", payment.token, payment.token.transactionIdentifier);
//    completion(PKPaymentAuthorizationStatusSuccess);
//}
//- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
//    [controller dismissViewControllerAnimated:YES completion:NULL];
//}
//#pragma mark 以下为银联支付协议
//- (void)UPPayPluginResult:(NSString *)result{
//    NSLog(@"%@",[NSString stringWithFormat:@"支付结果：%@", result]);
//}
//
//
//
//
//+(void)test{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:10];
//    [dict setObject:WechartID forKey:@"appid"];//appid=wxd678efh567hg6787
//    [dict setObject:MerchantID forKey:@"mch_id"];//1230000109    微信支付分配的商户号
//    [dict setObject:[self getNonstrWithNumber:32] forKey:@"nonce_str"];//随机字符串，不长于32位。推荐随机数生成算法
//    [dict setObject:@"C380BEC2BFD727A4B6845133519F3AD6" forKey:@"sign"];//签名，详见签名生成算法
//    [dict setObject:@"这是商品描述随便填" forKey:@"body"];//腾讯充值中心-QQ会员充值
//    [dict setObject:@"20150806125346" forKey:@"out_trade_no"];//商户系统内部的订单号,32个字符内、可包含字母, 其他说明见商户订单号
//    [dict setObject:@"100" forKey:@"total_fee"];//    是    Int    888    订单总金额，单位为分，详见支付金额
//    [dict setObject:[self getIPAddress] forKey:@"spbill_create_ip"];//    用户端实际ip
//    NSDateFormatter* formatter = [NSDateFormatter new];
//    [formatter setDateFormat:@"yyyyMMddHHmmss"];
//    //    [dict setObject:[formatter stringFromDate:[NSDate date]] forKey:@"time_start"];//    否20091225091010    订单生成时间，格式为yyyyMMddHHmmss，time_expire    否    String(14)    20091227091010订单失效时间
//    //    [dict setObject:@"MD5" forKey:@"sign_type"];//    否    String(32)    HMAC-SHA256    签名类型，目前支持HMAC-SHA256和MD5，默认为MD5
//    //    [dict setObject:[[Utility Share]userToken] forKey:@"device_info"];//否    终端设备号(门店号或收银设备ID)，默认请传"WEB"
//    //    [dict setObject:@"CNY" forKey:@"fee_type"];//    符合ISO 4217标准的三位字母代码，默认人民币：CNY，其他值列表详见货币类型
//    [dict setObject:@"http://www.weixin.qq.com/wxpay/pay.php" forKey:@"notify_url"];//接收微信支付异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。
//    [dict setObject:@"APP" forKey:@"trade_type"];//        是    String(16)        支付类型
//    NSString *str =@"";// [self dictionaryToXML:dict];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:@"https://api.mch.weixin.qq.com/pay/unifiedorder"]];
//    [request setHTTPMethod:@"POST"];//声明请求为POST请求
//    [request addValue:[NSString stringWithFormat:@"text/xml"] forHTTPHeaderField: @"Content-Type"];
//    NSMutableData *postBody = [NSMutableData data];
//    [postBody appendData:[str dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPBody:postBody];
//    NSString *bodyStr = [[NSString alloc] initWithData:postBody  encoding:NSUTF8StringEncoding];
//    NSLog(@"bodyStr: %@ ",bodyStr);
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"\n\nResponse Code: %@\n\n\nResponse: %@",response,result);
//    }];
//    [task resume];
//}
//
//#pragma mark - Public Methods
//// 支付流程实现// 客户端操作(实际操作应由服务端操作)
//+(void)sendWechartPayWithSelf{
//    NSString *tradeType = @"APP";                                       //交易类型
//    NSString *totalFee  = @"2";                                         //交易价格1表示0.01元，10表示0.1元
//    NSString *tradeNO   = [self getNonstrWithNumber:32];                       //随机字符串变量 这里最好使用和安卓端一致的生成逻辑
//    NSString *addressIP = [self getIPAddress];                        //设备IP地址,请再wifi环境下测试,否则获取的ip地址为error,正确格式应该是8.8.8.8
//    NSString *orderNo   = [NSString stringWithFormat:@"%ld",time(0)];   //随机产生订单号用于测试，正式使用请换成你从自己服务器获取的订单号
//    NSString *notifyUrl = WXBackUrl;// 交易结果通知网站此处用于测试，随意填写，正式使用时填写正确网站
//    //获取SIGN签名
//    MXWechatSignAdaptor *adaptor = [[MXWechatSignAdaptor alloc] initWithWechatAppId:WechartID
//                                                                        wechatMCHId:MerchantID
//                                                                            tradeNo:tradeNO
//                                                                   wechatPartnerKey:WechartSafeID
//                                                                           payTitle:@"购买产品名称"
//                                                                            orderNo:orderNo
//                                                                           totalFee:totalFee
//                                                                           deviceIp:addressIP
//                                                                          notifyUrl:notifyUrl
//                                                                          tradeType:tradeType];
//    NSString *string = [[adaptor dic] XMLString];
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    // 这里传入的XML字符串只是形似XML，但不是正确是XML格式，需要使用AF方法进行转义
//    session.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
//    [session.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [session.requestSerializer setValue:kUrlWechatPay forHTTPHeaderField:@"SOAPAction"];
//    [session.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
//        return string;
//    }];
//    [session POST:kUrlWechatPay parameters:string progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
//         NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",responseString);
//         NSDictionary *dic = [NSDictionary dictionaryWithXMLString:responseString];
//         // 判断返回的许可
//         if ([[dic objectForKey:@"result_code"] isEqualToString:@"SUCCESS"]&&[[dic objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] ) {
//             // 发起微信支付，设置参数
//             PayReq *request = [[PayReq alloc] init];
//             request.openID = [dic objectForKey:WXAPPID];
//             request.partnerId = [dic objectForKey:WXMCHID];
//             request.prepayId= [dic objectForKey:WXPREPAYID];
//             request.package = @"Sign=WXPay";
//             request.nonceStr= [dic objectForKey:WXNONCESTR];
//             // 将当前时间转化成时间戳
//             NSDate *datenow = [NSDate date];
//             NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
//             UInt32 timeStamp =[timeSp intValue];
//             request.timeStamp= timeStamp;
//             // 签名加密
//             MXWechatSignAdaptor *md5 = [[MXWechatSignAdaptor alloc] init];
//             request.sign=[md5 createMD5SingForPay:request.openID
//                                         partnerid:request.partnerId
//                                          prepayid:request.prepayId
//                                           package:request.package
//                                          noncestr:request.nonceStr
//                                         timestamp:request.timeStamp];
//             // 调用微信
//             [WXApi sendReq:request];
//         }
//     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//     }];
//}
//
//#pragma mark  支付流程实现// 服务端操作 服务端操作微信支付 / 上述客户端操作可以忽略（仅供参考）没办法，靠后台还不如靠自己，先自己了解客户端实现支付的操作
//+(void)sendWechartPayFromServerWithURL:(NSString *)url{
//    NSString *date = [NSString stringWithFormat:@"%ld",(long)[[NSDate date]timeIntervalSince1970]];
//    NSDictionary *dict = @{@"sign" : @"6956EC4C1DE8648217452AD3FE976884",
//                           @"mch_id" : @"1289521201",
//                           @"package" : @"Sign=WXPay",
//                           @"nonce_str" : @"hRWb53C0Ibr3vkXKdYpnDsqLIHLeN6iv",
//                           @"timestamp" : date,
//                           @"app_id" : @"wx3ea1e6ebce6a1838",
//                           @"prepay_id" : @"wx20161213153557adf58164020613862681"};
//    [self wechartPayFromServerWithDict:dict];//测试环境保留这句话，实际撤掉。
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[WXTOTALFEE] = @"1";
//    params[WXEQUIPMENTIP] = [self getIPAddress];
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    [session.requestSerializer setValue:@"text/html; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [session POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
//        if ([dict[@"status"]isEqualToString:@"200"]) {
//            [self wechartPayFromServerWithDict:dict];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
//}
//+(void)wechartPayFromServerWithDict:(NSDictionary*)dict{
//    // 发起微信支付，设置参数
//    PayReq *request = [[PayReq alloc] init];
//    request.openID = [dict objectForKey:WXAPPID];
//    request.partnerId = [dict objectForKey:WXMCHID];
//    request.prepayId= [dict objectForKey:WXPREPAYID];
//    request.package = @"Sign=WXPay";
//    request.nonceStr= [dict objectForKey:WXNONCESTR];
//    request.timeStamp= [[dict objectForKey:@"timestamp"] intValue];
//    request.sign = [dict objectForKey:@"sign"];
//    // 调用微信
//    [WXApi sendReq:request];
//}
//+(void)sendQQWalletPay{
//    NSString *appId = QQWalletAPPID;                             // 第三方APP在QQ钱包开放平台申请的appID
//    NSString *appKey = QQWalletAPPKEY;     // appID对应的appKey (这个key应当保存在后台，在后台进行签名)
//    NSString *bargainorId = QQWalletMCHID;                            // 第三方APP在财付通后台的商户号
//    NSString *tokenId = @"6Vca380a9b8cd11e25cad308926b6a00";           // 本demo的订单号
//    NSString *nonce = [self getNonstrWithNumber:22];
//    NSString *sig = [self getQQWalletSignatureWithAppId:appId bargainorId:bargainorId nonce:nonce tokenId:tokenId signingKey:appKey];// 获取签名串
//    // 调用QQ钱包进行支付
////    [QQWalletSDK startPayWithAppId:appId bargainorId:bargainorId tokenId:tokenId signature:sig nonce:nonce completion:^(QWMessage *message, NSError *error){
////        if (error)NSLog(@"支付失败:%@",error);
////        else NSLog(@"支付成功:%@", message.infos);
////    }];
//}
//// 生成签名串
//+ (NSString *)getQQWalletSignatureWithAppId:(NSString *)appId bargainorId:(NSString *)bargainorId nonce:(NSString *)nonce tokenId:(NSString *)tokenId signingKey:(NSString *)signingKey{
//    // 1. 将 appId,bargainorId,nonce,tokenId 拼成字符串
//    NSString *source = [NSString stringWithFormat:@"appId=%@&bargainorId=%@&nonce=%@&pubAcc=&tokenId=%@",appId,bargainorId,nonce,tokenId];
//    NSData *signature = [source dataUsingEncoding:NSUTF8StringEncoding];// 2. 将刚才拼好的字符串，用key来加密
//    NSData *signingData = [[signingKey stringByAppendingString:@"&"] dataUsingEncoding:NSUTF8StringEncoding];  // 约定在key末尾拼一个‘&’符号
//    NSMutableData *hmac = [NSMutableData dataWithLength:CC_SHA1_DIGEST_LENGTH];
//    CCHmac( kCCHmacAlgSHA1,signingData.bytes,  signingData.length,signature.bytes, signature.length,hmac.mutableBytes);
//    NSString *signatureBase64 = [hmac base64Encoding];// 3. 将加密后的data以base64形式输出
//    return signatureBase64;
//}
//
//+(void)sendQQWalletPayWithSelf{
//    NSString *payurl = @"https://qpay.qq.com/cgi-bin/pay/qpay_unified_order.cgi";
//    NSString *appid = QQWalletAPPID;
//    NSString *mch_id = QQWalletMCHID;
//    NSString *nonce_str = [self getNonstrWithNumber:32];
//    NSString *body = @"产品名称";
//    NSString *out_trade_no = [self getNonstrWithNumber:25];
//    NSString *fee_type = @"CNY";
//    NSString *total_fee = @"1";
//    NSString *spbill_create_ip = [self getIPAddress];
//    NSString *trade_type = @"APP";//交易类型
//    NSString *notify_url = @"https://www.qpay.qq.com";
//    NSString *appKey = QQWalletAPPKEY;     // appID对应的appKey (这个key应当保存在后台，在后台进行签名)
//    //获取SIGN签名
//    MXWechatSignAdaptor *adaptor = [[MXWechatSignAdaptor alloc]initWithQQWalletappid:appid mch_id:mch_id nonce_str:nonce_str body:body out_trade_no:out_trade_no fee_type:fee_type total_fee:total_fee spbill_create_ip:spbill_create_ip trade_type:trade_type notify_url:notify_url appkey:appKey];
//    NSString *string = [[adaptor dic] XMLString];
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    // 这里传入的XML字符串只是形似XML，但不是正确是XML格式，需要使用AF方法进行转义
//    session.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
//    [session.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [session.requestSerializer setValue:payurl forHTTPHeaderField:@"SOAPAction"];
//    [session.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, NSDictionary *parameters, NSError *__autoreleasing *error) {
//        return string;
//    }];
//    NSLog(@"%@",string);
//    [session POST:payurl parameters:string progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
//        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",responseString);
//        NSDictionary *dic = [NSDictionary dictionaryWithXMLString:responseString];
//        NSLog(@"%@",dic);
//        // 判断返回的许可
//        if ([[dic objectForKey:@"result_code"] isEqualToString:@"SUCCESS"]&&[[dic objectForKey:@"return_code"] isEqualToString:@"SUCCESS"] ) {
//            NSString *sig = [self getQQWalletSignatureWithAppId:appid bargainorId:mch_id nonce:nonce_str tokenId:out_trade_no signingKey:appKey];// 获取签名串
//            // 调用QQ钱包进行支付
////            [QQWalletSDK startPayWithAppId:appid bargainorId:mch_id tokenId:out_trade_no signature:sig nonce:nonce_str completion:^(QWMessage *message, NSError *error){
////                if (error)NSLog(@"支付失败:%@",error);
////                else NSLog(@"支付成功:%@", message.infos);
////            }];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
//}
//@end

