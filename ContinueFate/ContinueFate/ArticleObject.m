//
//  ArticleObject.m
//  ContinueFate
//
//  Created by jdld on 16/4/18.
//  Copyright © 2016年 XuYuan. All rights reserved.
//

#import "ArticleObject.h"

@implementation ArticleObject

- (id)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    self.id = [dict[@"id"]isKindOfClass:[NSNull class]]?@"":dict[@"id"];
    self.number = [dict[@"number"]isKindOfClass:[NSNull class]?0:dict[@"number"]];
    self.titlename = [dict[@"titlename"]isKindOfClass:[NSNull class]]?@"":dict[@"titlename"];
    self.substance = [dict[@"substance"]isKindOfClass:[NSNull class]]?@"":dict[@"substance"];
    self.edittime = [dict[@"edittime"]isKindOfClass:[NSNull class]]?@"":dict[@"edittime"];
    self.hits = [dict[@"hits"]isKindOfClass:[NSNull class]?0:dict[@"hits"]];
    self.usertype = [dict[@"usertype"]isKindOfClass:[NSNull class]?0:dict[@"usertype"]];
    self.username = [dict[@"username"]isKindOfClass:[NSNull class]]?@"":dict[@"username"];
    
    return self;
}

@end
