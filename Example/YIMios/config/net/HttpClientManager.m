//
//  HttpClientManager.m
//  UrgooApp
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "HttpClientManager.h"


//#import "AFNetworking.h"
@implementation HttpClientManager


+ (HttpClientManager*) getInstance{
    
    static HttpClientManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc]init];
//        if (AUTHORIZATION) {
//            [instance.requestSerializer setValue:AUTHORIZATION forHTTPHeaderField:@"Authorization"];
//        }
//        [instance.requestSerializer setValue:@"igfdbeebuy" forHTTPHeaderField:@"SC"];
//        [instance.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Client"];
    });
    
    [instance getReachability];
    return instance;
}


-(void)getReachability{
    
    
    
    
    
}



- (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure

{
    

    self.requestSerializer.timeoutInterval = 30;
   
   
    [self GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
     // NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
             [self isNewUrlReques:url withjson:responseObject];
            success(responseObject);
//            if ([responseObject[@"code"] intValue] == -500) {
//
//                  NSNotification *loginNotica =[NSNotification notificationWithName:@"BEEBUYAUTHORIZATIONFAIL" object:self userInfo:nil];
//
//
//                //通过通知中心发送通知@
//
//                [[NSNotificationCenter defaultCenter] postNotification:loginNotica];
//                    success(responseObject);
//
//            }else{
//
//                 success(responseObject);
//            }
//
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
     self.requestSerializer.timeoutInterval = 30;
    
    [self POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
       // NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ((success)) {
            
             [self isNewUrlReques:url withjson:responseObject];
            success(responseObject);
            
//            if ([responseObject[@"code"] intValue] == -500) {
//
//                NSNotification *loginNotica =[NSNotification notificationWithName:@"BEEBUYAUTHORIZATIONFAIL" object:self userInfo:nil];
//
//
//
//                //通过通知中心发送通知@
//
//                [[NSNotificationCenter defaultCenter] postNotification:loginNotica];
//                success(responseObject);
//
//            }else{
//
//                success(responseObject);
//            }
//
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        

    }];
}



+(void)getAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
   [self getInstance].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
   [[self getInstance].requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
    [[self getInstance] get:url params:params success:success failure:failure ];
    
}
+ (void)getAsyn:(NSString *)url params:(NSDictionary *)params header:(bool )need success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
      [self getInstance].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [[self getInstance].requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
    [[self getInstance] get:url params:params success:success failure:failure ];
    
    
    
    
}
+(void)postQueryAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    
    [self getInstance].requestSerializer = [AFJSONRequestSerializer serializer];
    
    [[self getInstance].requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
    [self getInstance].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [self getInstance].requestSerializer.timeoutInterval = 30;
    
    
    if (params) {
        
        [[self getInstance] POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            // NSLog(@"%@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ((success)) {
                
                
                 [[self getInstance] isNewUrlReques:url withjson:responseObject];
                success(responseObject);
//                if ([responseObject[@"code"] intValue] == -500) {
//
//                    NSNotification *loginNotica =[NSNotification notificationWithName:@"BEEBUYAUTHORIZATIONFAIL" object:self userInfo:nil];
//
//
//
//                    //通过通知中心发送通知@
//
//                    [[NSNotificationCenter defaultCenter] postNotification:loginNotica];
//
//                    success(responseObject);
//                }else{
//
//                    success(responseObject);
//                }
                
                
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            
            
        }];
    }else{
        
        [[self getInstance] POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            // NSLog(@"%@",uploadProgress);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ((success)) {
                
                success(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
            
            
        }];
    }
    
    
}

+(void)postBodyJSONAsyn:(NSString *)url params:(id )params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{

    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSError * error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:&error];
    
     NSString * jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
   
    // 关键! 转化为NSaData作为HTTPBody
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(responseObject);
                }
            }
            NSLog(@"Reply JSON: %@", responseObject);
        } else {
            if (failure) {
                failure(error);
            }
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
        
    }] resume];
    
    
  
}

+(void)postJSONAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    [self getInstance].requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //[[self getInstance].requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
  
    
    [self getInstance].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
     
    [self getInstance].requestSerializer.timeoutInterval = 15;
    [[self getInstance] POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        // NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ((success)) {
            
            
             [[self getInstance] isNewUrlReques:url withjson:responseObject];
            success(responseObject);
            
//            if ([responseObject[@"code"] intValue] == -500) {
//
//                NSNotification *loginNotica =[NSNotification notificationWithName:@"BEEBUYAUTHORIZATIONFAIL" object:self userInfo:nil];
//
//
//
//                //通过通知中心发送通知@
//
//                [[NSNotificationCenter defaultCenter] postNotification:loginNotica];
//
//                success(responseObject);
//            }else{
//
//                success(responseObject);
//            }
//
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
        
    }];
    
   // [[self getInstance] post:url params:params success:success failure:failure];
}


+(void)postAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    [self getInstance].requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [[self getInstance].requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
  
     
    [self getInstance].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [[self getInstance] post:url params:params success:success failure:failure];
}



-(void)uploadFiles:(NSString *)url  fileData:(id )imageFile params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
      AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
           //AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        UIImage *image = (UIImage *)imageFile;
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        if (data) {
            // 可以在上传时使用当前的系统时间作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            
           
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            // DLog(LELocalizedString(@"上传头像失败"));
            //失败回调
            failure(error);
            
            
            
        }

    }];
    
}
+(void)uploadVideoFiles:(NSString *)url  fileData:(NSString * )imageFile params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       //AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
       
 
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
      
               // 可以在上传时使用当前的系统时间作为文件名
               NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
               // 设置时间格式
               formatter.dateFormat = @"yyyyMMddHHmmss";
               NSString *str = [formatter stringFromDate:[NSDate date]];
               NSString *fileName = [NSString stringWithFormat:@"%@.mp4", str];
               
        [formData appendPartWithFileURL:[NSURL URLWithString:imageFile] name:@"file" fileName:fileName mimeType:@"video/mpeg4" error:nil];
               
             //  [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg"];
           
       } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           if(responseObject){
               success(responseObject);
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           if (failure) {
               // DLog(LELocalizedString(@"上传头像失败"));
               //失败回调
               failure(error);
           }
           
       }];
    
    
    
}
+(void)uploadFilesAsy:(NSString *)url  fileData:(id )imageFile params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
  
    [[self getInstance] uploadFiles:url fileData:imageFile params:params success:success failure:failure];
}
+(void)uploadAUTHFilesAsy:(NSString *)url  fileData:(id )imageFile params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];

     UIImage *image = (UIImage *)imageFile;
    NSMutableDictionary * imagedict = [NSMutableDictionary dictionary];
    imagedict[@"type"] = @"image";
    imagedict[@"imageWidth"] = [NSString stringWithFormat:@"%f",image.size.width];
    imagedict[@"imageHeight"] =[NSString stringWithFormat:@"%f",image.size.height];
    NSMutableDictionary * dict = [NSMutableDictionary dictionaryWithDictionary:params];
    dict[@"sizeInfo"] = [imagedict mj_JSONString];
    [manager POST:url parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        
        NSData *data = UIImageJPEGRepresentation(image, 0.8);
        if (data) {
            // 可以在上传时使用当前的系统时间作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            
            
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(responseObject){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            // DLog(LELocalizedString(@"上传头像失败"));
            //失败回调
            failure(error);
        }
        
    }];
    
    
}

+(void)putAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    [[self getInstance]put:url params:params success:success failure:failure];
    
    
}

-(void)put:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure

{
    
    [self PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+(void)deleteAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
     [self getInstance].requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil, nil];
    [[self getInstance] delete:url params:params success:success failure:failure ];
    
}
- (void)delete:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure

{
    
    
    self.requestSerializer.timeoutInterval = 30;
    
    [self DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
   
}

+(void)postBodyAsyn:(NSString *)url bodyParams:(NSDictionary *)params normalParams:(NSDictionary *)normalParams success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    [self getInstance].requestSerializer = [AFJSONRequestSerializer serializer];
    
   
    [self getInstance].responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    NSMutableString *mUrl = url.mutableCopy;

    [mUrl appendString:[self keyValueStringWithDict:normalParams]];
 
    [self getInstance].requestSerializer.timeoutInterval = 15;
   // NSString * encodingString = [mUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // [mUrl stringByAddingPercentEncodingWithAllowedCharacters:NSUTF8StringEncoding];
    NSString * nameUrl =  [ mUrl  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    if ([mUrl containsString:@"/search/2/selectBrandCategory"]) {//单独处理品牌的筛选接口。（比如品牌名DOLCE&GABBANA包含&符号的时候会报错）
        if ([nameUrl containsString:@"&"]) {
            nameUrl = [nameUrl stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
        }
    }
    
    [[self getInstance] POST:nameUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        // NSLog(@"%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ((success)) {
            
            
            
            [[self getInstance] isNewUrlReques:url withjson:responseObject];
            
            
             success(responseObject);
            
            

            
            
           
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
        
    }];
    
}

+ (NSString *)keyValueStringWithDict:(NSDictionary *)dict
{
    if (dict == nil) {
        return @"";
    }
    NSMutableString *string = [NSMutableString stringWithString:@"?"];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"%@=%@&",key,obj];
    }];
    
    if ([string rangeOfString:@"&"].length) {
        [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    }
    
    return string;
}


-(void)isNewUrlReques:(NSString *)url withjson:(id  _Nullable) responseObject{
    
//    if ([url containsString:@"api.igfd.group"]) {
        
//        if ([responseObject[@"code"] intValue] == -500) {
//
//            UserDefaultRemoveObjectForKey(BB_AUTHORIZATION);
//            NSNotification *loginNotica =[NSNotification notificationWithName:@"BEEBUYAUTHORIZATIONFAIL" object:self userInfo:nil];
//            //通过通知中心发送通知@
//            [[NSNotificationCenter defaultCenter] postNotification:loginNotica];
//
//        }
        
//    }
    
}

@end
