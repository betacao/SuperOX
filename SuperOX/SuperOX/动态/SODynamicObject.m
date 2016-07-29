//
//  SODynamicObject.m
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SODynamicObject.h"

@implementation SODynamicObject

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"attach" : [NSArray class],
             @"comments" : [NSArray class],
             @"heads" : [NSArray class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"attach" : @"attach",
             @"attachType" : @"attachtype",
             @"businessID" : @"businessid",
             @"businessStatus" : @"businessstatus",
             @"cmmtnum" : @"cmmtnum",
             @"comments" : @"comments",
             @"company" : @"company",
             @"currcity" : @"currcity",
             @"detail" : @"detail",
             @"feedHtml" : @"feedhtml",
             @"friendShip" : @"friendship",
             @"groupPostTitle" : @"groupposttitle",
             @"groupPostUrl" : @"groupposturl",
             @"isAttention" : @"isattention",
             @"isPraise" : @"ispraise",
             @"nickName" : @"nickname",
             @"pcUrl" : @"pcurl",
             @"potName" : @"potname",
             @"praiseNum" : @"praisenum",
             @"publishDate" : @"publishdate",
             @"dynamicID" : @"rid",
             @"shareNum" : @"sharenum",
             @"status" : @"status",
             @"title" : @"title",
             @"postType" : @"type",
             @"userID" : @"userid",
             @"userStatus" : @"userstatus",
             @"heads" : @"heads",
             @"isCollection" : @"iscollection",
             @"displayPosition" : @"displayposition",
             @"shareTitle" : @"sharetitle"};
}

@end


@implementation SODynamicCommentObject


@end

@implementation SODynamicPraiseObject


@end


@implementation SONewFriendObject



@end
