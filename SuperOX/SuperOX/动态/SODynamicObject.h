//
//  SODynamicObject.h
//  SuperOX
//
//  Created by changxicao on 16/7/26.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SODynamicObject : NSObject

@property (strong, nonatomic) NSArray *attach;//图片
@property (strong, nonatomic) NSString *attachType;
@property (strong, nonatomic) NSString *businessID;
@property (assign, nonatomic) BOOL businessStatus;
@property (strong, nonatomic) NSString *cmmtnum;
@property (strong, nonatomic) NSArray *comments;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *currcity; //城市
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *feedHtml; //feed流链接
@property (strong, nonatomic) NSString *friendShip; //好友关系
@property (strong, nonatomic) NSString *groupPostTitle;
@property (strong, nonatomic) NSString *groupPostUrl;
@property (assign, nonatomic) BOOL isAttention;
@property (assign, nonatomic) BOOL isPraise;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *pcUrl;
@property (strong, nonatomic) NSString *potName;
@property (strong, nonatomic) NSString *praiseNum;
@property (strong, nonatomic) NSString *publishDate;
@property (strong, nonatomic) NSString *dynamicID;
@property (strong, nonatomic) NSString *shareNum;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *postType;
@property (strong, nonatomic) NSString *userID;
@property (assign, nonatomic) BOOL userStatus;  //认证状态
@property (strong, nonatomic) NSArray *heads;
@property (assign, nonatomic) BOOL isCollection;
@property (strong, nonatomic) NSString *displayPosition;//广告所在的位置
@property (strong, nonatomic) NSString *shareTitle;

@end


@interface SODynamicCommentObject : NSObject

@property(strong, nonatomic)  NSString *cdetail;
@property(strong, nonatomic)  NSString *cid;
@property(strong, nonatomic)  NSString *cnickname;
@property(strong, nonatomic)  NSString *rid;
@property(strong, nonatomic)  NSString *replyid;
@property(strong, nonatomic)  NSString *rnickname;

@end


@interface SODynamicPraiseObject: NSObject

@property(strong, nonatomic)  NSString *pnickname;
@property(strong, nonatomic)  NSString *puserid;
@property(strong, nonatomic)  NSString *ppotname;

@end


@interface SONewFriendObject : NSObject

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *realName;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *picName;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *commonFriendCount;
@property (strong, nonatomic) NSArray *commonFriendList;

@end
