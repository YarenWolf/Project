////  Wechart&AlipayViewController.m
//#import "Wechart&AlipayViewController.h"
//#import "Wechart&AlipayTools.h"
//#import "OpenShareHeader.h"
//#import "PrefixHeader.h"
//#import "WXApiManager.h"
//#import "WXApiRequestHandler.h"
//#import "RespForWeChatViewController.h"
//#define timeTitle [NSString stringWithFormat:@"%@ %f",title,[[NSDate date] timeIntervalSince1970]]
//#define timeSubTitle [NSString stringWithFormat:@"%@ %f",subtitle,[[NSDate date] timeIntervalSince1970]]
//#define successLogs(a) NSLog(@"%@", [NSString stringWithFormat:@"💐%@%@成功！%@",self.actions[indexPath.section][indexPath.row][0],self.actions[indexPath.section][indexPath.row][1],a])
//#define errorLogs(a,b) NSLog(@"%@", [NSString stringWithFormat:@"%@%@失败！%@ %@",self.actions[indexPath.section][indexPath.row][0],self.actions[indexPath.section][indexPath.row][1],a,b])
//@interface Wechart_AlipayViewController () <WXApiManagerDelegate,UITableViewDataSource, UITableViewDelegate,PKPaymentAuthorizationViewControllerDelegate>{
//    NSArray *sectionTitles;
//    UIImage *thumbImage;
//    UIImage *testImage;
//    NSData *gifImageData,*pdfData,*testImagedata,*thumbImagedata;
//    NSString *title,*subtitle,*describe;
//    NSString *pictureUrl,*musicUrl,*videoUrl,*webUrl;
//    NSString *merchant,*price;
//}
//@property (nonatomic, strong) NSMutableArray *actions;  //  用于存储供Demo使用的 示例标题、处理方法 的数组
//@end
//@implementation Wechart_AlipayViewController
//- (void)viewDidLoad{
//    [super viewDidLoad];
//    self.navigationItem.title = @"微信&支付宝SDK";
//    merchant = @"这是商家的名称，也就是收款方的名称";
//    price = @"￥100.00";
//    title = @"这是消息的标题title";
//    subtitle = @"这是消息的副标题描述内容subscribe";
//    describe = @"这是纯文本内容的消息主体content";
//    pictureUrl = @"http://pic.yesky.com/uploadImages/2015/174/53/6NSGL7M9J7C3.jpg";
//    webUrl = @"http://tech.qq.com/a/20160529/007832.htm";
//    videoUrl = @"http://www.iqiyi.com/yinyue/20120919/5c688b84912a8198.html";//少女时代
//    musicUrl = @"http://stream20.qqmusic.qq.com/32464723.mp3";
//    thumbImage = [UIImage imageNamed:@"thumb"];
//    testImage = [UIImage imageNamed:@"test.jpg"];
//    thumbImagedata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"thumb" ofType:@"png"]];
//    testImagedata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"test" ofType:@"jpg"]];
//    gifImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dynamic" ofType:@"gif"]];
//    pdfData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iphone4" ofType:@"pdf"]];
//    //微信官方接入的delegate
//    [WXApiManager sharedManager].delegate = self;
//    self.navigationController.navigationBarHidden = NO;
//    sectionTitles = @[@"苹果官方支付方法",@"银联支付三种方式",@"OpenShare的新浪接口",@"OpenShare的QQ接口",@"OpenShare的微信接口",@"OpenShare的人人接口",@"OpenShare的支付宝接口",@"微信接入官方",@"支付宝接入官方",@"QQ钱包支付",@"连连支付",@"其他"];
//    //苹果官方支付方法
//    NSArray *applepays =@[@[@"苹果官方支付方法",@"applePay",@"applepayw",@"好了"]];
//    //银联支付三种方式
//    NSArray *unionpays =@[@[@"银联普通订单",   @"mode=01",@"unionpay",@"好了"],
//                          @[@"银联配置用户",   @"123456789 mode=01",@"unionpay",@"好了"],
//                          @[@"银联自定义支付", @"自定义支付接口与tn方法",@"unionpay",@"好了"]];
//    //OpenShare的新浪接口
//    NSArray *openshareSinas =@[@[@"新浪微博登录",   @"来自OpenShare封装的接口",@"sinas",@"好了"],
//                               @[@"新浪微博分享纯文本",@"来自OpenShare封装的接口",@"sinas",@"好了"],
//                               @[@"新浪微博分享图片", @"来自OpenShare封装的接口",@"sinas",@"好了"],
//                               @[@"新浪微博分享新闻", @"来自OpenShare封装的接口",@"sinas",@"好了"]];
//    //OpenShare的QQ接口
//    NSArray *openshareQQs =@[@[@"QQ登录",   @"来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"和我聊天",   @"来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"指定群聊天", @"必须是群成员，来自OpenShare封装的接口",@"QQs",@"好了"],
//                             
//                             @[@"分享文本消息", @"到QQ好友 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享图片消息", @"到QQ好友 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享新闻消息", @"到QQ好友 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享音频消息", @"到QQ好友 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享视频消息", @"到QQ好友 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             
//                             @[@"分享文本消息", @"到QQ空间 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享图片消息", @"到QQ空间 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享新闻消息", @"到QQ空间 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享音频消息", @"到QQ空间 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享视频消息", @"到QQ空间 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             
//                             @[@"分享文本消息", @"到QQ收藏 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享图片消息", @"到QQ收藏 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享新闻消息", @"到QQ收藏 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享音频消息", @"到QQ收藏 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享视频消息", @"到QQ收藏 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             
//                             @[@"分享文本消息", @"到QQ数据线 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享图片消息", @"到QQ数据线 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享新闻消息", @"到QQ数据线 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享音频消息", @"到QQ数据线 来自OpenShare封装的接口",@"QQs",@"好了"],
//                             @[@"分享视频消息", @"到QQ数据线 来自OpenShare封装的接口",@"QQs",@"好了"]];
//    //OpenShare的微信接口
//    NSArray *openshareWecharts =@[@[@"微信登录",   @"appid需要认证300/年 来自OpenShare",@"wechartpayr",@"好了"],
//                                  @[@"微信支付",   @"需要在pay.php中设置支付参数 OpenShare",@"wechartpay",@"暂不支持"],
//                                  
//                                  @[@"发送文本消息", @"到微信会话 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送图片消息", @"到微信会话 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送链接消息", @"到微信会话 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送音频消息", @"到微信会话 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送视频消息", @"到微信会话 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送APP消息", @"到微信会话 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送表情消息", @"到微信会话 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送gif消息", @"到微信会话 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送文件消息", @"到微信会话 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  
//                                  @[@"发送文本消息", @"到微信朋友圈 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送图片消息", @"到微信朋友圈 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送链接消息", @"到微信朋友圈 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送音频消息", @"到微信朋友圈 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送视频消息", @"到微信朋友圈 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送APP消息", @"到微信朋友圈 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送表情消息", @"到微信朋友圈 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送gif消息", @"到微信朋友圈 来自OpenShare封装的接口",@"wechartpays",@"不支持"],
//                                  @[@"发送文件消息", @"到微信朋友圈 来自OpenShare封装的接口",@"wechartpays",@"不支持"],
//                                  
//                                  @[@"发送文本消息", @"到微信收藏 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送图片消息", @"到微信收藏 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送链接消息", @"到微信收藏 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送音频消息", @"到微信收藏 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送视频消息", @"到微信收藏 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送APP消息", @"到微信收藏 来自OpenShare封装的接口",@"wechartpays",@"不支持"],
//                                  @[@"发送表情消息", @"到微信收藏 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  @[@"发送gif消息", @"到微信收藏 来自OpenShare封装的接口",@"wechartpays",@"不支持"],
//                                  @[@"发送文件消息", @"到微信收藏 来自OpenShare封装的接口",@"wechartpays",@"好了"],
//                                  ];
//    //OpenShare的人人接口
//    NSArray *openshareRenRens =@[@[@"分享文本消息", @"到人人聊天 来自OpenShare封装的接口",@"renrens",@"好了"],
//                                 @[@"分享图片消息", @"到人人聊天 来自OpenShare封装的接口",@"renrens",@"好了"],
//                                 @[@"分享图文消息", @"到人人聊天 来自OpenShare封装的接口",@"renrens",@"好了"],
//                                 @[@"分享音频消息", @"到人人聊天 来自OpenShare封装的接口",@"renrens",@"好了"],
//                                 @[@"分享视频消息", @"到人人聊天 来自OpenShare封装的接口",@"renrens",@"好了"],
//                                 
//                                 @[@"分享文本消息", @"到人人新鲜事 来自OpenShare封装的接口",@"renrens",@"好了"],
//                                 @[@"分享图片消息", @"到人人新鲜事 来自OpenShare封装的接口",@"renrens",@"好了"],
//                                 @[@"分享图文消息", @"到人人新鲜事 来自OpenShare封装的接口",@"renrens",@"好了"],
//                                 @[@"分享音频消息", @"到人人新鲜事 来自OpenShare封装的接口",@"renrens",@"好了"],
//                                 @[@"分享视频消息", @"到人人新鲜事 来自OpenShare封装的接口",@"renrens",@"好了"]];
//    //微信接入官方版
//    NSArray *wechartSDKs = @[@[@"发送Text消息给微信",@"微信官方会话接入",@"wechartpays",@"好了"],
//                             @[@"发送Photo消息给微信",@"微信官方会话接入",@"wechartpays",@"好了"],
//                             @[@"发送Link消息给微信",@"微信官方会话接入",@"wechartpays",@"好了"],
//                             @[@"发送Music消息给微信",@"微信官方会话接入",@"wechartpays",@"好了"],
//                             @[@"发送Video消息给微信",@"微信官方会话接入",@"wechartpays",@"好了"],
//                             @[@"发送App消息给微信",@"微信官方会话接入",@"wechartpays",@"好了"],
//                             @[@"发送非gif表情给微信",@"微信官方会话接入",@"wechartpays",@"好了"],
//                             @[@"发送gif表情给微信",@"微信官方会话接入",@"wechartpays",@"好了"],
//                             @[@"发送文件消息给微信",@"微信官方会话接入",@"wechartpays",@"好了"],
//                             
//                             @[@"发送Text消息给微信",@"微信官方朋友圈接入",@"wechartpays",@"好了"],
//                             @[@"发送Photo消息给微信",@"微信官方朋友圈接入",@"wechartpays",@"好了"],
//                             @[@"发送Link消息给微信",@"微信官方朋友圈接入",@"wechartpays",@"好了"],
//                             @[@"发送Music消息给微信",@"微信官方朋友圈接入",@"wechartpays",@"好了"],
//                             @[@"发送Video消息给微信",@"微信官方朋友圈接入",@"wechartpays",@"好了"],
//                             @[@"发送App消息给微信",@"微信官方朋友圈接入",@"wechartpays",@"好了"],
//                             @[@"发送非gif表情给微信",@"微信官方朋友圈接入",@"wechartpays",@"不支持"],
//                             @[@"发送gif表情给微信",@"微信官方朋友圈接入",@"wechartpays",@"不支持"],
//                             @[@"发送文件消息给微信",@"微信官方朋友圈接入",@"wechartpays",@"不支持"],
//                             
//                             @[@"发送Text消息给微信",@"微信官方收藏接入",@"wechartpays",@"好了"],
//                             @[@"发送Photo消息给微信",@"微信官方收藏接入",@"wechartpays",@"好了"],
//                             @[@"发送Link消息给微信",@"微信官方收藏接入",@"wechartpays",@"好了"],
//                             @[@"发送Music消息给微信",@"微信官方收藏接入",@"wechartpays",@"好了"],
//                             @[@"发送Video消息给微信",@"微信官方收藏接入",@"wechartpays",@"好了"],
//                             @[@"发送App消息给微信",@"微信官方收藏接入",@"wechartpays",@"好了"],
//                             @[@"发送非gif表情给微信",@"微信官方收藏接入",@"wechartpays",@"不支持"],
//                             @[@"发送gif表情给微信",@"微信官方收藏接入",@"wechartpays",@"不支持"],
//                             @[@"发送文件消息给微信",@"微信官方收藏接入",@"wechartpays",@"好了"],
//                             @[@"微信授权登录",@"微信官方授权接入",@"wechartpays",@"好了"],
//                             @[@"添加单张卡券至卡包",@"微信官方卡券接入",@"wechartpays",@"好了"],
//                             @[@"添加多张卡券至卡包",@"微信官方卡券接入",@"wechartpays",@"好了"],
//                             @[@"发起微信支付结合服务端",@"微信官方支付接入",@"wechartpay",@"好了"],
//                             @[@"发起微信支付自主支付",@"微信官方支付接入",@"wechartpay",@"好了"]];
//    //支付宝接入官方版
//    NSArray *alipaySDKs = @[@[@"支付宝支付自主支付",@"支付宝官方接入",@"alipays",@"好了"],
//                            @[@"支付宝授权",@"支付宝官方接入",@"alipayt",@"好了"],
//                            @[@"支付宝网页请求支付",@"支付宝官方网页支付接入",@"alipays",@"好了"],
//                            @[@"支付宝支付结合服务端",@"支付宝官方支付接入",@"alipays",@"好了"]];
//    //QQ支付官方版
//    NSArray *QQWalletSDKs = @[@[@"QQ钱包支付结合服务器",@"QQ钱包官方接入",@"QQs",@"好了"],@[@"QQ钱包自主支付",@"QQ钱包官方接入",@"QQs",@"好了"]];
//    self.actions = [NSMutableArray arrayWithArray:@[applepays,unionpays,openshareSinas,openshareQQs,openshareWecharts,openshareRenRens,wechartSDKs,alipaySDKs,QQWalletSDKs]];
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APPW, APPH-40) style:UITableViewStyleGrouped];
//    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    tableView.rowHeight = 60;
//    tableView.sectionFooterHeight = 0;
//    tableView.tableHeaderView = [self getTableHeaderView];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [self.view addSubview:tableView];
//}
//-(UIView*)getTableHeaderView{
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, APPW, 100)];
//    UIImageView *logo = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 80, 80)];
//    logo.image = testImage;
//    logo.layer.cornerRadius = 40;logo.clipsToBounds = YES;
//    UILabel *pprice = [[UILabel alloc]initWithFrame:CGRectMake(XW(logo)+20, 10, APPW-XW(logo)-40, 40)];
//    UILabel *ptitle = [[UILabel alloc]initWithFrame:CGRectMake(X(pprice), YH(pprice)+5, W(pprice), 40)];
//    ptitle.numberOfLines = 0;
//    pprice.text = price;
//    pprice.font = [UIFont boldSystemFontOfSize:30];
//    ptitle.text = merchant;
//    ptitle.font = [UIFont systemFontOfSize:15];
//    ptitle.textColor = [UIColor blackColor];
//    [header addSubview:logo];
//    [header addSubview:pprice];
//    [header addSubview:ptitle];
//    header.backgroundColor = [UIColor whiteColor];
//    return header;
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = YES;
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.actions.count;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [self.actions[section] count];
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 30;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UILabel *stitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, APPW, 30)];
//    stitle.text = sectionTitles[section];
//    stitle.textAlignment = NSTextAlignmentCenter;
//    stitle.textColor = [UIColor blackColor];
//    stitle.font = [UIFont systemFontOfSize:18];
//    return stitle;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *identifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.imageView.frame = CGRectMake(20, 10, 40, 40);
//        cell.imageView.layer.cornerRadius = 5;
//        cell.imageView.clipsToBounds = YES;
//    }
//    cell.textLabel.text = self.actions[indexPath.section][indexPath.row][0];
//    cell.detailTextLabel.text =self.actions[indexPath.section][indexPath.row][1];
//    cell.imageView.image = [UIImage imageNamed:self.actions[indexPath.section][indexPath.row][2]];
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//   if(indexPath.section==0){
//        switch (indexPath.row) {
//            case 0:[Wechart_AlipayTools sendApplePayWithDelegate:self merchantID:@"merchant.com.zhimei360.applepaydemo" label:@"Total" price:@"1.99"];break;
//            default:break;
//        }
//    }else if(indexPath.section==1){
//        switch (indexPath.row) {
//            case 0:[Wechart_AlipayTools sendUnionPayWithTNModel:@"01" URL:[NSURL URLWithString:@"http://101.231.204.84:8091/sim/getacptn"] scheme:@"UPPayDemo" delegate:self];break;
//            case 1:[Wechart_AlipayTools sendUnionPayWithTNModel:@"01" URL:[NSURL URLWithString:@"http://101.231.204.84:8091/sim/getacptn?user=123456789"] scheme:@"UPPayDemo" delegate:self];break;
//            case 2:[Wechart_AlipayTools sendUnionPayWithTNModel:@"01" URL:[NSURL URLWithString:@"http://www.baidu.com"] scheme:@"UPPayDemo" delegate:self];break;
//            default:break;
//        }
//    }else if(indexPath.section==2){
//        switch (indexPath.row) {
//            case 0:{
//                [OpenShare WeiboAuth:@"all" redirectURI:webUrl Success:^(NSDictionary *message) {
//                    successLogs(message);
//                } Fail:^(NSDictionary *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 1:{
//                OSMessage *message=[[OSMessage alloc]init];
//                message.title=title;
//                [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 2:{
//                OSMessage *message=[[OSMessage alloc]init];
//                message.title= title;
//                message.image = testImagedata;
//                [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 3:{
//                OSMessage *message=[[OSMessage alloc]init];
//                message.title= title;
//                message.image=testImagedata;
//                message.link=webUrl;
//                [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            default:break;
//        }
//    }else if(indexPath.section==3){//@QQ
//        switch (indexPath.row) {
//            case 0:{
//                [OpenShare QQAuth:@"get_user_info" Success:^(NSDictionary *message) {
//                    successLogs(message);
//                } Fail:^(NSDictionary *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 1:{
//                [OpenShare chatWithQQNumber:@"1293126188"];
//            }break;
//            case 2:{
//                 [OpenShare chatInQQGroup:@"341376072"];
//            }break;
//            case 3:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title= timeTitle;
//                [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 4:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title= timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 5:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link=webUrl;
//                [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 6:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link= musicUrl;
//                msg.multimediaType=OSMultimediaTypeAudio;
//                [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
//                     successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 7:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link= videoUrl;
//                msg.multimediaType=OSMultimediaTypeVideo;
//                [OpenShare shareToQQFriends:msg Success:^(OSMessage *message) {
//                     successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 8:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.link=webUrl;
//                [OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
//                     successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 9:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                [OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
//                     successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 10:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link=webUrl;
//                [OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 11:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link= musicUrl;
//                msg.multimediaType=OSMultimediaTypeAudio;
//                [OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 12:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link= videoUrl;
//                msg.multimediaType=OSMultimediaTypeVideo;
//                [OpenShare shareToQQZone:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 13:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                [OpenShare shareToQQFavorites:msg Success:^(OSMessage *message) {
//                     successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                     errorLogs(msg, error);
//                }];
//            }break;
//            case 14:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                [OpenShare shareToQQFavorites:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 15:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link= webUrl;
//                [OpenShare shareToQQFavorites:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 16:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link= musicUrl;
//                msg.multimediaType=OSMultimediaTypeAudio;
//                [OpenShare shareToQQFavorites:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 17:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link= videoUrl;
//                msg.multimediaType=OSMultimediaTypeVideo;
//                [OpenShare shareToQQFavorites:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 18:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                [OpenShare shareToQQDataline:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 19:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                [OpenShare shareToQQDataline:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 20:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link= webUrl;
//                [OpenShare shareToQQDataline:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 21:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link= musicUrl;
//                msg.multimediaType=OSMultimediaTypeAudio;
//                [OpenShare shareToQQDataline:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            case 22:{
//                OSMessage *msg=[[OSMessage alloc] init];
//                msg.title=timeTitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.desc=timeSubTitle;
//                msg.link=videoUrl;
//                msg.multimediaType=OSMultimediaTypeVideo;
//                [OpenShare shareToQQDataline:msg Success:^(OSMessage *message) {
//                    successLogs(msg);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(msg, error);
//                }];
//            }break;
//            default:break;
//        }
//    }else if(indexPath.section==4){
//        #pragma mark 微信分享相关
//        switch (indexPath.row) {
//            case 0:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                [OpenShare WeixinAuth:@"snsapi_userinfo" Success:^(NSDictionary *message) {
//                    successLogs(message);
//                } Fail:^(NSDictionary *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 1:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                NSString *apiUrl=@"https://pay.example.com/pay.php?payType=weixin";
//                if ([apiUrl hasPrefix:@"https://pay.example.com"]) {
//                    NSLog(@"请部署pay.php，填写自家的key。");
//                }else{
//                    NSURLSession *session = [NSURLSession sharedSession];
//                    NSURLSessionTask *task = [session dataTaskWithURL:[NSURL URLWithString:apiUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                        NSString *alipaylink=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//                        NSLog(@"link:%@",alipaylink);
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [OpenShare WeixinPay:alipaylink Success:^(NSDictionary *message) {
//                                successLogs(message);
//                            } Fail:^(NSDictionary *message, NSError *error) {
//                                errorLogs(message, error);
//                            }];
//                        });
//                    }];
//                    [task resume];
//                }
//            }break;
//            case 2:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 3:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 4:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.link= webUrl;
//                msg.image=thumbImagedata;//新闻类型的职能传缩略图就够了。
//                [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 5:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.mediaDataUrl= musicUrl;
//                msg.link= webUrl;
//                msg.thumbnail=thumbImagedata;
//                msg.multimediaType=OSMultimediaTypeAudio;
//                [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 6:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.link= videoUrl;
//                msg.thumbnail=thumbImagedata;
//                msg.multimediaType=OSMultimediaTypeVideo;
//                [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 7:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.extInfo=@"app自己的扩展消息，当从微信打开app的时候，会传给app";
//                msg.link= webUrl;//分享到朋友圈以后，微信就不会调用app了，跟news类型分享到朋友圈一样。
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.multimediaType=OSMultimediaTypeApp;
//                [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 8:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 9:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                
//                msg.thumbnail=thumbImagedata;
//                [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 10:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                
//                msg.thumbnail=thumbImagedata;
//                msg.fileExt=@"pdf";
//                msg.multimediaType=OSMultimediaTypeFile;
//                [OpenShare shareToWeixinSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 11:{//segment=2
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                    msg.desc=subtitle;
//                [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 12:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 13:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.link= webUrl;
//                msg.image=thumbImagedata;//新闻类型的职能传缩略图就够了。
//                [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 14:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.mediaDataUrl= musicUrl;
//                msg.link= webUrl;
//                msg.thumbnail=thumbImagedata;
//                msg.multimediaType=OSMultimediaTypeAudio;
//                [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 15:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.link= videoUrl;
//                msg.thumbnail=thumbImagedata;
//                msg.multimediaType=OSMultimediaTypeVideo;
//                [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 16:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.extInfo=@"app自己的扩展消息，当从微信打开app的时候，会传给app";
//                msg.link= webUrl;//分享到朋友圈以后，微信就不会调用app了，跟news类型分享到朋友圈一样。
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.multimediaType=OSMultimediaTypeApp;
//                [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 17:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 18:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                
//                msg.thumbnail=thumbImagedata;
//                msg.multimediaType=OSMultimediaTypeFile;
//                [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 19:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                
//                msg.thumbnail=thumbImagedata;
//                msg.fileExt=@"pdf";
//                msg.multimediaType=OSMultimediaTypeFile;
//                [OpenShare shareToWeixinTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 20:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                [OpenShare shareToWeixinFavorite:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 21:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                [OpenShare shareToWeixinFavorite:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 22:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.link=webUrl;
//                msg.image=thumbImagedata;//新闻类型的职能传缩略图就够了。
//                [OpenShare shareToWeixinFavorite:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 23:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.mediaDataUrl= musicUrl;
//                msg.link=webUrl;
//                msg.thumbnail=thumbImagedata;
//                msg.multimediaType=OSMultimediaTypeAudio;
//                [OpenShare shareToWeixinFavorite:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 24:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.link= videoUrl;
//                msg.thumbnail=thumbImagedata;
//                msg.multimediaType=OSMultimediaTypeVideo;
//                [OpenShare shareToWeixinFavorite:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 25:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.extInfo=@"app自己的扩展消息，当从微信打开app的时候，会传给app";
//                msg.link= webUrl;//分享到朋友圈以后，微信就不会调用app了，跟news类型分享到朋友圈一样。
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                msg.multimediaType=OSMultimediaTypeApp;
//                [OpenShare shareToWeixinFavorite:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 26:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                [OpenShare shareToWeixinFavorite:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 27:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.thumbnail=thumbImagedata;
//                [OpenShare shareToWeixinFavorite:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 28:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.desc=subtitle;
//                msg.thumbnail=thumbImagedata;
//                msg.fileExt=@"pdf";
//                msg.multimediaType=OSMultimediaTypeFile;
//                [OpenShare shareToWeixinFavorite:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            default:break;
//        }
//    }else if(indexPath.section==5){
//        switch (indexPath.row) {
//            case 0:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.link=webUrl;
//                msg.desc=subtitle;
//                [OpenShare shareToRenrenSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 1:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                [OpenShare shareToRenrenSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 2:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.image=testImagedata;
//                msg.link=webUrl;
//                msg.desc=subtitle;
//                [OpenShare shareToRenrenSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 3:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.multimediaType=OSMultimediaTypeAudio;
//                msg.thumbnail=thumbImagedata;
//                msg.link= webUrl;
//                msg.desc=subtitle;
//                [OpenShare shareToRenrenSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 4:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.multimediaType=OSMultimediaTypeVideo;
//                msg.thumbnail=thumbImagedata;
//                msg.link=videoUrl;
//                msg.desc=subtitle;
//                [OpenShare shareToRenrenSession:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 5:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.link=webUrl;
//                msg.desc=subtitle;
//                [OpenShare shareToRenrenTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 6:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.image=testImagedata;
//                msg.thumbnail=thumbImagedata;
//                [OpenShare shareToRenrenTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 7:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.image=testImagedata;
//                msg.link=webUrl;
//                msg.desc=subtitle;
//                [OpenShare shareToRenrenTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 8:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.multimediaType=OSMultimediaTypeAudio;
//                msg.thumbnail=thumbImagedata;
//                msg.link= webUrl;
//                msg.desc=subtitle;
//                [OpenShare shareToRenrenTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            case 9:{
//                OSMessage *msg=[[OSMessage alloc]init];
//                msg.title=title;
//                msg.multimediaType=OSMultimediaTypeVideo;
//                msg.thumbnail=thumbImagedata;
//                msg.link=videoUrl;
//                msg.desc=subtitle;
//                [OpenShare shareToRenrenTimeline:msg Success:^(OSMessage *message) {
//                    successLogs(message);
//                } Fail:^(OSMessage *message, NSError *error) {
//                    errorLogs(message, error);
//                }];
//            }break;
//            default:break;
//        }
//    }else if(indexPath.section==6){//微信官方接入
//        switch (indexPath.row) {
//            case 0:{
//                [WXApiRequestHandler sendText:describe InScene:WXSceneSession];
//            }break;
//            case 1:{
//                [WXApiRequestHandler sendImageData:UIImageJPEGRepresentation(testImage, 1.0) TagName:@"" MessageExt:title Action:@"" ThumbImage:thumbImage InScene:WXSceneSession];
//            }break;
//            case 2:{
//                [WXApiRequestHandler sendLinkURL:webUrl TagName:@"" Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneSession];
//            }break;
//            case 3:{
//                [WXApiRequestHandler sendMusicURL:musicUrl dataURL:musicUrl Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneSession];
//            }break;
//            case 4:{
//                [WXApiRequestHandler sendVideoURL:videoUrl Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneSession];
//            }break;
//            case 5:{
//                Byte* pBuffer = (Byte *)malloc(1024 * 100); memset(pBuffer, 0, 1024 * 100);
//                NSData* data = [NSData dataWithBytes:pBuffer length:1024 * 100]; free(pBuffer);
//                [WXApiRequestHandler sendAppContentData:data ExtInfo:@"" ExtURL:webUrl Title:title Description:subtitle MessageExt:@"" MessageAction:nil ThumbImage:thumbImage InScene:WXSceneSession];
//            }break;
//            case 6:{
//                [WXApiRequestHandler sendEmotionData:UIImageJPEGRepresentation(testImage, 1.0) ThumbImage:thumbImage InScene:WXSceneSession];
//            }break;
//            case 7:{
//                [WXApiRequestHandler sendEmotionData:gifImageData ThumbImage:thumbImage InScene:WXSceneSession];
//            }break;
//            case 8:{
//                [WXApiRequestHandler sendFileData:pdfData fileExtension:@"pdf" Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneSession];
//            }break;
//                
//            case 9:{
//                [WXApiRequestHandler sendText:describe InScene:WXSceneTimeline];
//            }break;
//            case 10:{
//                [WXApiRequestHandler sendImageData:UIImageJPEGRepresentation(testImage, 1.0) TagName:@"" MessageExt:title Action:@"" ThumbImage:thumbImage InScene:WXSceneTimeline];
//            }break;
//            case 11:{
//                [WXApiRequestHandler sendLinkURL:webUrl TagName:@"" Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneTimeline];
//            }break;
//            case 12:{
//                [WXApiRequestHandler sendMusicURL:musicUrl dataURL:musicUrl Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneTimeline];
//            }break;
//            case 13:{
//                [WXApiRequestHandler sendVideoURL:videoUrl Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneTimeline];
//            }break;
//            case 14:{
//                Byte* pBuffer = (Byte *)malloc(1024 * 100); memset(pBuffer, 0, 1024 * 100);
//                NSData* data = [NSData dataWithBytes:pBuffer length:1024 * 100]; free(pBuffer);
//                [WXApiRequestHandler sendAppContentData:data ExtInfo:@"" ExtURL:webUrl Title:title Description:subtitle MessageExt:@"" MessageAction:@"" ThumbImage:thumbImage InScene:WXSceneTimeline];
//            }break;
//            case 15:{
//                [WXApiRequestHandler sendEmotionData:UIImageJPEGRepresentation(testImage, 1.0) ThumbImage:thumbImage InScene:WXSceneTimeline];
//            }break;
//            case 16:{
//                [WXApiRequestHandler sendEmotionData:gifImageData ThumbImage:thumbImage InScene:WXSceneTimeline];
//            }break;
//            case 17:{
//                [WXApiRequestHandler sendFileData:pdfData fileExtension:@"pdf" Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneTimeline];
//            }break;
//        
//            case 18:{
//                [WXApiRequestHandler sendText:describe InScene:WXSceneFavorite];
//            }break;
//            case 19:{
//                [WXApiRequestHandler sendImageData:UIImageJPEGRepresentation(testImage, 1.0) TagName:@"" MessageExt:title Action:@"" ThumbImage:thumbImage InScene:WXSceneFavorite];
//            }break;
//            case 20:{
//                [WXApiRequestHandler sendLinkURL:webUrl TagName:@"" Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneFavorite];
//            }break;
//            case 21:{
//                [WXApiRequestHandler sendMusicURL:musicUrl dataURL:musicUrl Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneFavorite];
//            }break;
//            case 22:{
//                [WXApiRequestHandler sendVideoURL:videoUrl Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneFavorite];
//            }break;
//            case 23:{
//                Byte* pBuffer = (Byte *)malloc(1024 * 100); memset(pBuffer, 0, 1024 * 100);
//                NSData* data = [NSData dataWithBytes:pBuffer length:1024 * 100]; free(pBuffer);
//                [WXApiRequestHandler sendAppContentData:data ExtInfo:@"" ExtURL:webUrl Title:title Description:subtitle MessageExt:@"" MessageAction:webUrl ThumbImage:thumbImage InScene:WXSceneFavorite];
//            }break;
//            case 24:{
//                [WXApiRequestHandler sendEmotionData:UIImageJPEGRepresentation(testImage, 1.0) ThumbImage:thumbImage InScene:WXSceneFavorite];
//            }break;
//            case 25:{
//                [WXApiRequestHandler sendEmotionData:gifImageData ThumbImage:thumbImage InScene:WXSceneFavorite];
//            }break;
//            case 26:{
//                [WXApiRequestHandler sendFileData:pdfData fileExtension:@"pdf" Title:title Description:subtitle ThumbImage:thumbImage InScene:WXSceneFavorite];
//            }break;
//            case 27:{
//                [WXApiRequestHandler sendAuthRequestScope:@"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact" State:@"xxx" OpenID:@"0c806938e2413ce73eef92cc3" InViewController:self];
//            }break;
//            case 28:{
//                WXCardItem* cardItem = [[WXCardItem alloc] init];
//                cardItem.cardId = @"pDF3iY9tv9zCGCj4jTXFOo1DxHdo";
//                cardItem.extMsg = @"{\"code\": \"\", \"openid\": \"\", \"timestamp\": \"1418301401\", \"signature\":\"f54dae85e7807cc9525ccc127b4796e021f05b33\"}";
//                [WXApiRequestHandler addCardsToCardPackage:[NSArray arrayWithObject:cardItem]];
//            }break;
//            case 29:{
//                WXCardItem* cardItem = [[WXCardItem alloc] init];
//                cardItem.cardId = @"pDF3iY9tv9zCGCj4jTXFOo1DxHdo";
//                cardItem.extMsg = @"{\"code\": \"\", \"openid\": \"\", \"timestamp\": \"1418301401\", \"signature\":\"f54dae85e7807cc9525ccc127b4796e021f05b33\"}";
//                [WXApiRequestHandler addCardsToCardPackage:[NSArray arrayWithObjects:cardItem,cardItem, nil]];
//            }break;
//            case 30:{
//                [Wechart_AlipayTools sendWechartPayFromServerWithURL:@"http://www.isolar88.com/pay"];
//            }break;
//            case 31:{
//                [Wechart_AlipayTools sendWechartPayWithSelf];
//            }break;
//            default:break;
//        }
//    }else if(indexPath.section==7){//支付宝官方接入
//        switch (indexPath.row) {
//            case 0:{
//                [Wechart_AlipayTools sendAlipayWithProductName:@"产品名称" money:@"2.99"];
//            }break;
//            case 1:{
//                [Wechart_AlipayTools sendAlipayAuther];
//            }break;
//            case 2:{
//                NSString *url = @"https://maliprod.alipay.com/w/trade_pay.do?app_name=tb&partner=PARTNER_TAOBAO_ORDER&biz_type=trade&sign=_v_dn%252Fv_ccid_cr3l5_kx2uu%252Blo_g_n_f2cg%252Ff_r_pqv_d27_cf_y_h6_e_n_z9_e_k9_lj2_pw%253D%253D&trade_no=2016121321001001135004190644&return_url=http://www.baidu.com&sign_date=2016-12-13+14%3A24%3A14&extern_token=3a054b559cc0a19bd2d1dd166615b4dd&sign_type=DSA";
//                [Wechart_AlipayTools sendAlipayWithURL:url];
//            }break;
//            case 3:{
//                [Wechart_AlipayTools sendThirdAlipayWithsometiong];
//            }break;
//            default:break;
//        }
//    }else if(indexPath.section==8){
//        switch (indexPath.row) {
//            case 0:{
//                [Wechart_AlipayTools sendQQWalletPay];
//            }break;
//            case 1:{
//                [Wechart_AlipayTools sendQQWalletPayWithSelf];
//            }break;
//            default:break;
//        }
//    }else{
//      
//    }
//}
//
//#pragma mark PKPaymentAuthorizationViewControllerDelegate
//- (void)paymentAuthorizationViewController:(PKPaymentAuthorizationViewController *)controller didAuthorizePayment:(PKPayment *)payment completion:(void (^)(PKPaymentAuthorizationStatus))completion{
//    completion(PKPaymentAuthorizationStatusSuccess);
//}
//- (void)paymentAuthorizationViewControllerDidFinish:(PKPaymentAuthorizationViewController *)controller {
//    [controller dismissViewControllerAnimated:YES completion:NULL];
//}
//#pragma mark 微信官方接入的delegate
//- (void)managerDidRecvGetMessageReq:(GetMessageFromWXReq *)req {
//    // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
//    NSLog(@"%@",[NSString stringWithFormat:@"\n微信请求App提供内容\nopenID: %@", req.openID]);
//    RespForWeChatViewController* controller = [RespForWeChatViewController alloc];
//    [self presentViewController:controller animated:YES completion:nil];
//}
//
//- (void)managerDidRecvShowMessageReq:(ShowMessageFromWXReq *)req {
//    WXMediaMessage *msg = req.message;//显示微信传过来的内容
//    WXAppExtendObject *obj = msg.mediaObject;
//    NSLog(@"\n%@",[NSString stringWithFormat:@"微信请求App显示内容:\nopenID: %@, 标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n附加消息:%@\n", req.openID, msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length, msg.messageExt]);
//}
//
//- (void)managerDidRecvLaunchFromWXReq:(LaunchFromWXReq *)req {
//    WXMediaMessage *msg = req.message;//从微信启动App
//    NSLog(@"%@",[NSString stringWithFormat:@"\n从微信启动\nopenID: %@, messageExt:%@", req.openID, msg.messageExt]);
//}
//
//- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)response {
//    NSLog(@"\n%@",[NSString stringWithFormat:@"\n发送媒体消息结果\nerrcode:%d", response.errCode]);
//}
//
//- (void)managerDidRecvAddCardResponse:(AddCardToWXCardPackageResp *)response {
//    NSMutableString* cardStr = [[NSMutableString alloc] init];
//    for (WXCardItem* cardItem in response.cardAry) {
//        [cardStr appendString:[NSString stringWithFormat:@"add card resp cardid:%@ cardext:%@ cardstate:%u\n",cardItem.cardId,cardItem.extMsg,(unsigned int)cardItem.cardState]];
//    }
//    NSLog(@"\n\n\n%@",cardStr);
//}
//- (void)managerDidRecvAuthResponse:(SendAuthResp *)response {
//    NSLog(@"%@",[NSString stringWithFormat:@"\nAuth结果\ncode:%@,state:%@,errcode:%d", response.code, response.state, response.errCode]);
//}
//
//@end
//
