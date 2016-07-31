//
//  SOMainPageTableViewCell.h
//  Finance
//
//  Created by changxicao on 16/3/8.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOBusinessObject.h"
#import "SODynamicObject.h"
#import "SOBaseTableViewCell.h"
#import "SOBaseView.h"

@interface SOMainPageTableViewCell : SOBaseTableViewCell

@property (strong ,nonatomic) SODynamicObject *object;

@end


@interface SOMainPageBusinessView : SOBaseView

@property (strong, nonatomic) SOBusinessObject *object;

@end