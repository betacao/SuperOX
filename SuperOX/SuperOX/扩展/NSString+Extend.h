//
//  NSString+Extend.h
//  SuperOX
//
//  Created by changxicao on 16/6/8.
//  Copyright © 2016年 changxicao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

- (id)parseToArrayOrNSDictionary;

- (NSString *)md5;

- (BOOL)isValidateMobile;

@end
