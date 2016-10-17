//
//  ViewController.m
//  task
//
//  Created by sun on 16/10/9.
//  Copyright © 2016年 ZZ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getRequestMethod];
      [self postRequestMethod];
}
#pragma mark----GET 请求
-(void)getRequestMethod{
    NSString *pathStr = @"http://***.***.***.***:8088/****/v1/GET/PostPickStation?key=ae410d61-d266-4110-9670-2853b194686e&factoryId=0287ee72-7ecc-42ea-abe0-8457f8b9319b&type=iOS";
    
    /**********************************************************
     处理特殊字符串方法一（iOS 9.0之前）
     pathStr = [pathStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     */
    
    /********************************************************
     处理特殊字符串方法二（iOS 9.0之前）
     pathStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)pathStr,NULL,NULL,kCFStringEncodingUTF8));
     */
    
    /********************************************************
     处理特殊字符串方法三（iOS 9.0之后）
     */
    pathStr = [pathStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    //获取请求路径链接
    NSURL *url = [NSURL URLWithString:pathStr];

    //创建静态请求对象（不可以设置请求方式）
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //获得会话对象（单例）
    NSURLSession *session = [NSURLSession sharedSession];
    
    //根据会话对象创建一个Task(发送请求）
    NSURLSessionDataTask *dateTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"网络错误!");
        }else{
            NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"dictData--->%@",dictData[@"code"]);
        }
    }];
    //执行任务
    [dateTask resume];
}

#pragma mark----POST 请求
-(void)postRequestMethod{
    NSString *pathStr = @"http://***.***.***.***:8088/****/v1/POST/PostPickStation";
    //处理链接中特殊字符串
    pathStr = [pathStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //生成URL链接
    NSURL *url = [NSURL URLWithString:pathStr];
    
    //创建可变强请求体（可以设置请求方式）
    NSMutableURLRequest *muRequest = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    muRequest.HTTPMethod = @"POST";
    //参数
    NSString *parameterStr = @"key=ae410d61-d266-4110-9670-2853b194686e&StationCode=123&StationName=110";
    parameterStr = [parameterStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    muRequest.HTTPBody = [parameterStr dataUsingEncoding:NSUTF8StringEncoding];
    
    //创建对话
    NSURLSession *session = [NSURLSession sharedSession];
    
    //根据会话对象创建一个Task(发送请求）
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:muRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"---->%@",dictData[@"msg"]);
    }];
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
