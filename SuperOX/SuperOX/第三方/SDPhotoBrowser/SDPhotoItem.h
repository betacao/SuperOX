//
//  SDPhotoItem.h
//  SDPhotoBrowser
//
//  Created by aier on 15-2-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SODynamicObject.h"

@interface SDPhotoItem : NSObject

@property (nonatomic, strong) NSString *thumbnail_pic;

@property (strong, nonatomic) SODynamicObject *object;
@end
