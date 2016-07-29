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

@interface SOMainPageTableViewCell : UITableViewCell

@property (strong ,nonatomic) SODynamicObject *object;

@end


@interface SOMainPageBusinessView : UIView

@property (strong, nonatomic) SOBusinessObject *object;

@end