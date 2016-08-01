//
//  HHBaseSession.m
//  HHNetworking
//
//  Created by LWJ on 16/7/11.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHBaseSession.h"
#import "HHPrivateHeader.h"

@interface HHBaseSession()
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;//基本普通的会话管理 key-value
@property (nonatomic, strong) AFHTTPSessionManager *afResponseSessionManager;//不解析JSON/XML数据,直接返回NSData原始数据
@property (nonatomic, strong) NSURLSessionDataTask *currentTask;//
@property (nonatomic, strong) AFHTTPSessionManager *jsonSessionManager;//json请求


@end
@implementation HHBaseSession
- (instancetype)init
{
    self = [super init];
    if (self) {
        _timeoutInterval=kRequestTimeOut;

    }
    return self;
}
-(NSString *)urlWithPath:(NSString *)path{
    if ([HHClient sharedInstance].baseURL==nil || path==nil) {
        FMWLog(@"主机域名或路径不能为空");
        return nil;
    }
    return [NSString stringWithFormat:@"%@%@",[HHClient sharedInstance].baseURL,path];
}
-(void)setTimeoutInterval:(NSTimeInterval)timeoutInterval{
    _timeoutInterval=timeoutInterval;
    self.sessionManager.requestSerializer.timeoutInterval=timeoutInterval;
}
- (void)testEncriypt{
    NSString *encriyptStr=@"otBqDCOylodw1wuL7LKFWMtablqH/3FIvV0vtB89xFXKZNyi19dkxEhGM8tCym8q4WwxOcfpH/HtcHx4TqT7Ig==";
    NSString *decryptStr=[encriyptStr net_decryptAES:kAESKey];
    FMWLog(@"%@",decryptStr);
}
#pragma mark -AFHTTPSessionManager: key-value request
-(AFHTTPSessionManager *)sessionManager{
    if (_sessionManager==nil) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
        configuration.HTTPShouldSetCookies = YES;
        _sessionManager= [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        _sessionManager.securityPolicy=securityPolicy;
        //MARK:获取原始加密数据
//        [_sessionManager setResponseSerializer:[AFJSONResponseSerializer new]];
        [_sessionManager setResponseSerializer:[AFHTTPResponseSerializer new]];

        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html",@"application/xml",nil];
        [_sessionManager.requestSerializer setTimeoutInterval:self.timeoutInterval];
        
    }
    return _sessionManager;
}

#pragma mark -AFHTTPSessionManager: JSONRequest
-(AFHTTPSessionManager *)jsonSessionManager{
    if (_jsonSessionManager==nil) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
        configuration.HTTPShouldSetCookies = YES;
        _jsonSessionManager= [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        _jsonSessionManager.securityPolicy=securityPolicy;
        //MARK:获取原始加密数据
//        [_jsonSessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
        [_jsonSessionManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];

        _jsonSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
        [_jsonSessionManager.requestSerializer setTimeoutInterval:self.timeoutInterval];
        
    }
    return _jsonSessionManager;
}
#pragma mark -AFHTTPSessionManager: JSON
-(AFHTTPSessionManager *)afResponseSessionManager{
    if (_afResponseSessionManager==nil) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.HTTPCookieAcceptPolicy = NSHTTPCookieAcceptPolicyAlways;
        configuration.HTTPShouldSetCookies = YES;
        _afResponseSessionManager= [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        _afResponseSessionManager.securityPolicy=securityPolicy;
        [_afResponseSessionManager setResponseSerializer:[AFHTTPResponseSerializer serializer]];
        _afResponseSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
        _afResponseSessionManager.requestSerializer=[AFJSONRequestSerializer serializer];
        [_afResponseSessionManager.requestSerializer setTimeoutInterval:self.timeoutInterval];

    }
    return _afResponseSessionManager;
}
- (NSDictionary *)encryptParams:(NSDictionary *)dict{
    NSMutableDictionary *params=[NSMutableDictionary dictionaryWithDictionary:[HHClient sharedInstance].commonParams];
    [params setDictionary:dict];
    return [params copy];
}

- (id)JSONDecryptResponseData:(NSData *)data{
    NSData *deData=[data net_decryptAES:kAESKey];
    NSError *error;
    id json=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        FMWLog(@"json serialization error:%@",error);
    }
    return json;
}

- (NSURLSessionDataTask *)GET:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt{
    NSURLSessionDataTask *task=[self.sessionManager GET:url parameters:[self encryptParams:dict] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id object=[self JSONDecryptResponseData:responseObject];
        
        FMWLog(@"\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",url,object);
        complt(object,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FMWLog(@"task:%@error:%@",task,error);
        
        HHError *derror=[HHError errorWithCode:error.code description:nil];
        complt(nil,derror);
        
    }];

    return task;
}
- (NSURLSessionDataTask *)POST:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt{
    NSURLSessionDataTask *task=[self.sessionManager POST:url parameters:[self encryptParams:dict] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        id object=[self JSONDecryptResponseData:responseObject];
        
        FMWLog(@"\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",url,object);
        complt(object,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FMWLog(@"task:%@error:%@",task,error);
        
        HHError *derror=[HHError errorWithCode:error.code description:nil];
        complt(nil,derror);
        
    }];

    return task;

}
- (NSURLSessionDataTask *)JSON:(NSString *)url params:(NSDictionary *)dict complete:(HHSessionCompleteBlock)complt{
    NSURLSessionDataTask *task=[self.jsonSessionManager POST:url parameters:[self encryptParams:dict] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        id object=[self JSONDecryptResponseData:responseObject];
        
        FMWLog(@"\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",url,object);
        complt(object,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FMWLog(@"task:%@error:%@",task,error);
        
        HHError *derror=[HHError errorWithCode:error.code description:nil];
        complt(nil,derror);
        
    }];

    return task;

}
- (NSURLSessionDataTask *)FILE:(NSString *)url params:(NSDictionary *)dict files:(NSArray<HHFile *> *)files complete:(HHSessionCompleteBlock)complt{
    NSURLSessionDataTask *task=[self.sessionManager POST:url parameters:[self encryptParams:dict] constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0;i<files.count; i++) {
            HHFile *obj=files[i];
            if (obj.data) {
                [formData appendPartWithFileData:obj.data name:obj.key fileName:obj.name mimeType:obj.mimeType];
            }
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id object=[self JSONDecryptResponseData:responseObject];
        
        FMWLog(@"\n\n路径:%@\n***请求结果:\n%@\n***结束\n\n",url,object);
        complt(object,nil);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        FMWLog(@"task:%@error:%@",task,error);
        
        HHError *derror=[HHError errorWithCode:error.code description:nil];
        complt(nil,derror);
        

    }];
    return task;

}
- (NSURLSessionDownloadTask *)download:(NSString *)url complete:(HHSessionCompleteBlock)complt progress:(void (^)(float, long long))progress{
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *task=[self.sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return nil;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    return task;

}
- (void)resetConfiguration{
    
}
-(void)cancleAllRequest{
    
}
@end
