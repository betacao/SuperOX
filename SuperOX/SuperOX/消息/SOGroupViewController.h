//
//  SOGroupViewController.h
//  SuperOX
//
//  Created by changxicao on 16/7/27.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOBaseViewController.h"
#import "SOBaseTableViewCell.h"

@interface SOGroupViewController : SOBaseViewController

@end

@interface SHGGroupObject : NSObject

@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) BOOL imageViewHidden;
@property (assign, nonatomic) BOOL rightViewHidden;
@property (assign, nonatomic) BOOL lineViewHidden;

@end

@interface SHGGroupTableViewCell : SOBaseTableViewCell

@property (strong, nonatomic) SHGGroupObject *object;

@end


@interface SHGGroupHeaderObject : NSObject

@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *text;

@end

@interface SHGGroupHeaderView : UIView

@property (strong, nonatomic) SHGGroupHeaderObject *object;

@end
