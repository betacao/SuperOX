//
//  SOGroupViewController.h
//  SuperOX
//
//  Created by changxicao on 16/7/27.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import "SOBaseViewController.h"
#import "SOBaseView.h"

@interface SOGroupViewController : SOBaseViewController

@end

@interface SOGroupObject : NSObject

@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) BOOL imageViewHidden;
@property (assign, nonatomic) BOOL rightViewHidden;
@property (assign, nonatomic) BOOL lineViewHidden;

@end

@interface SOGroupTableViewCell : UITableViewCell

@property (strong, nonatomic) SOGroupObject *object;

@end


@interface SOGroupHeaderObject : NSObject

@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *text;

@end

@interface SOGroupHeaderView : SOBaseView

@property (strong, nonatomic) SOGroupHeaderObject *object;

@end
