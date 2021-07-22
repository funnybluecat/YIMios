//
//  HttpClientManager.h
//  UrgooApp
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"AFNetworking.h"
@interface HttpClientManager : AFHTTPSessionManager

@property (nonatomic, assign) Boolean  netWork;

+ (HttpClientManager*) getInstance;

+ (void)getAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)getAsyn:(NSString *)url params:(NSDictionary *)params header:(bool )need success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+ (void)postAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+(void)postBodyJSONAsyn:(NSString *)url params:(id)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+(void)postJSONAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+(void)postQueryAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)uploadVideoFiles:(NSString *)url  fileData:(NSString * )imageFile params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)uploadFilesAsy:(NSString *)url  fileData:(id )imageFile params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)uploadAUTHFilesAsy:(NSString *)url  fileData:(id )imageFile params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)putAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)deleteAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+(void)postBodyAsyn:(NSString *)url bodyParams:(NSDictionary *)params normalParams:(NSDictionary *)normalParams success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
