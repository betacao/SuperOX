//
//  SOAdvertisementView.h
//  Finance
//
//  Created by changxicao on 16/6/24.
//  Copyright © 2016年 HuMin. All rights reserved.
//

#import "SOBaseView.h"

typedef void(^SOAdvertisementViewDismissBlock)(void);

@interface SOAdvertisementView : SOBaseView

@property (copy, nonatomic) SOAdvertisementViewDismissBlock dissmissBlock;

@end

@interface SHGAdvertisementManager : NSObject

+ (void)loadLocalAdvertisementBlock:(void (^)(BOOL show, NSString *photoUrl))block;

+ (void)loadRemoteAdvertisement;

@end