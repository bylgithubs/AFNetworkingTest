//
//  ViewController.m
//  AFNetworkingTest
//
//  Created by Civet on 2020/8/27.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "BlockTestViewController.h"
#import <AFNetworkActivityIndicatorManager.h>
typedef void(^blockDemo)(NSString *str, NSInteger num);

@interface ViewController ()

@property(nonatomic, copy) blockDemo block;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.block = ^(NSString *str, NSInteger num) {
        NSLog(@"block is active=======%@,%ld",str,num);
    };

    NSString *url= @"https://oyeadmin.oyeze.com/civetBB/getLatestBackupMsg/civet1575253570483";
    //get请求
    //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFHTTPSessionManager *manager = [self sharedManager];
    //manager.responseSerializer.acceptableContentTypes = nil;
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"=============%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"===============%@",responseObject);
        self.block(@"aaa", 1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"===============%@",error);
    }];
    
    BlockTestViewController *blockTVC = [[BlockTestViewController alloc] init];
    [blockTVC deliveryBlock:self.block];
    //[self.navigationController pushViewController:blockTVC animated:YES];
    //设置网络请求左上角小菊花
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
}

-(AFHTTPSessionManager *)sharedManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    // 请求格式
    // AFHTTPRequestSerializer            二进制格式
    // AFJSONRequestSerializer            JSON
    // AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    
    // 超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置请求头
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    // 设置接收的Content-Type
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    // 返回格式
    // AFHTTPResponseSerializer           二进制格式
    // AFJSONResponseSerializer           JSON
    // AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
    // AFXMLDocumentResponseSerializer (Mac OS X)
    // AFPropertyListResponseSerializer   PList
    // AFImageResponseSerializer          Image
    // AFCompoundResponseSerializer       组合
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
    //设置返回C的ontent-type
    manager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    return manager;
}

-(void)doGetRequest
{
    //创建请求地址
    NSString *url=@"http://api.nohttp.net/method";
    //构造参数
    NSDictionary *parameters=@{@"name":@"yanzhenjie",@"pwd":@"123"};
    //AFN管理者调用get请求方法
    [[self sharedManager] GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        //返回请求返回进度
        NSLog(@"downloadProgress-->%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功返回数据 根据responseSerializer 返回不同的数据格式
        NSLog(@"responseObject-->%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"error-->%@",error);
    }];
}

-(void)doPostRequestOfAFN
{
    //创建请求地址
    NSString *url=@"http://api.nohttp.net/postBody";
    //构造参数
    NSDictionary *parameters=@{@"name":@"yanzhenjie",@"pwd":@"123"};
    //AFN管理者调用get请求方法
    [[self sharedManager] POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //返回请求返回进度
        NSLog(@"downloadProgress-->%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功返回数据 根据responseSerializer 返回不同的数据格式
        NSLog(@"responseObject-->%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"error-->%@",error);
    }];
}

-(void)doUploadRequest
{
    // 创建URL资源地址
    NSString *url = @"http://api.nohttp.net/upload";
    // 参数
    NSDictionary *parameters=@{@"name":@"yanzhenjie",@"pwd":@"123"};
    [[self sharedManager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString* fileName = [NSString stringWithFormat:@"file_%0.f.txt", a];
        
        //[FileUtils writeDataToFile:fileName data:[@"upload_file_to_server" dataUsingEncoding:NSUTF8StringEncoding]];
        // 获取数据转换成data
        //NSString *filePath =[FileUtils getFilePath:fileName];
        // 拼接数据到请求题中
        //[formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath] name:@"headUrl" fileName:fileName mimeType:@"application/octet-stream" error:nil];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败
        NSLog(@"请求失败：%@",error);
    }];
}

-(void)doDownLoadRequest
{
    NSString *urlStr =@"http://images2015.cnblogs.com/blog/950883/201701/950883-20170105104233581-62069155.png";
    // 设置请求的URL地址
    NSURL *url = [NSURL URLWithString:urlStr];
    // 创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 下载任务
    NSURLSessionDownloadTask *task = [[self sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 下载地址
        NSLog(@"默认下载地址%@",targetPath);
        //这里模拟一个路径 真实场景可以根据url计算出一个md5值 作为fileKey
        NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval a=[dat timeIntervalSince1970];
        NSString* fileKey = [NSString stringWithFormat:@"/file_%0.f.txt", a];
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        //NSString *filePath = [FileUtils getFilePath:fileKey];
        return [NSURL fileURLWithPath:fileKey]; // 返回的是文件存放在本地沙盒的地址
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        NSLog(@"filePath---%@", filePath);
        NSData *data=[NSData dataWithContentsOfURL:filePath];
        UIImage *image=[UIImage imageWithData:data];
        // 刷新界面...
        UIImageView *imageView =[[UIImageView alloc]init];
        imageView.image=image;
        [self.view addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.view);
//            make.size.mas_equalTo(CGSizeMake(300, 300));
//        }];
    }];
    //启动下载任务
    [task resume];
}

- (void)aFNetworkStatus{
    
    //创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
                
            default:
                break;
        }
        
    }] ;
    
    [manager startMonitoring];
}

@end
