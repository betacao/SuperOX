//
//  SORecommendTableViewCell.h
//  Finance
//
//  Created by changxicao on 16/3/9.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SORecommendTableViewCell : SOBaseTableViewCell

@property (strong, nonatomic) NSArray *objectArray;

@end


@interface SORecommendObject : NSObject

@property (strong, nonatomic) NSString *flag;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *headimg;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *area;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *recomfri;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *vocation;
@property (assign, nonatomic) BOOL isAttention;
@property (strong, nonatomic) NSString *commonCount;

@end