//
//  SDPhotoGroup.m
//  SDPhotoBrowser
//
//  Created by aier on 15-2-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDPhotoGroup.h"
#import "SDPhotoItem.h"
#import "SDPhotoBrowser.h"
#import "SOMainPageConst.h"

#define kImageViewMargin MarginFactor(6.0f)

@interface SDPhotoGroup () <SDPhotoBrowserDelegate>

@end

@implementation SDPhotoGroup 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}


- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    [photoItemArray enumerateObjectsUsingBlock:^(SDPhotoItem *obj, NSUInteger idx, BOOL *stop) {
        NSString *url = obj.thumbnail_pic;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.tag = idx;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewDidTap:)];
        [imageView addGestureRecognizer:recognizer];
        [imageView setImageWithURL:[NSURL URLWithString:url] placeholder:[UIImage imageNamed:@"default_image"]];
        [self addSubview:imageView];
    }];
    [self makeupSubViews];
}

- (void)makeupSubViews
{
    NSInteger imageCount = self.photoItemArray.count;
    NSInteger perRowImageCount = ((imageCount == 4) ? 2 : 3);

    CGFloat width = ceilf((SCREENWIDTH - (kMainItemLeftMargin + kImageViewMargin) * 2.0f) / 3.0f);
    CGFloat height = width;
    __block CGFloat totalHeight = 0.0f;
    if(self.subviews.count > 1){
        [self.subviews enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop) {
            NSInteger rowIndex = idx / perRowImageCount;
            NSInteger columnIndex = idx % perRowImageCount;
            CGFloat x = columnIndex * (width + kImageViewMargin);
            CGFloat y = rowIndex * (height + kImageViewMargin);
            imageView.frame = CGRectMake(x, y, width, height);
            totalHeight = CGRectGetMaxY(imageView.frame);
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
        }];
    } else if(self.subviews.count == 1){
        UIImageView *imageView = (UIImageView *)[self.subviews firstObject];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = CGRectMake(0.0f, 0.0f, 2 * width + kImageViewMargin, 2 * height + kImageViewMargin);
        totalHeight = 2 * width + kImageViewMargin;
    }

    self.frame = CGRectMake(0.0f, 0.0f, SCREENWIDTH - 2.0f * kMainItemLeftMargin, totalHeight);
}

- (void)setStyle:(SDPhotoGroupStyle)style
{
    _style = style;
    switch (style) {
        case SDPhotoGroupStyleThumbnail:{
            CGFloat width = ceilf((SCREENWIDTH - (kMainItemLeftMargin + kImageViewMargin) * 2.0f) / 3.0f);
            CGFloat height = width;
            if(self.subviews.count == 1){
                UIImageView *imageView = (UIImageView *)[self.subviews firstObject];
                imageView.frame = CGRectMake(0.0f, 0.0f, width, height);
                self.frame = CGRectMake(0.0f, 0.0f, width, width);
            }
        }

        default:
            break;
    }
}

- (void)imageViewDidTap:(UITapGestureRecognizer *)recognizer
{
    SDPhotoItem *item = [self.photoItemArray objectAtIndex:recognizer.view.tag];
    if (item.object) {
        [SOGloble recordUserAction:item.object.dynamicID type:@"dynamic_clickImg"];
    }
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
    browser.imageCount = self.photoItemArray.count;
    browser.currentImageIndex = recognizer.view.tag;
    browser.delegate = self;
    [browser show];
    
}

#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.subviews[index] currentImage];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [self.photoItemArray[index] thumbnail_pic];
    return [NSURL URLWithString:urlStr];
}

- (void)photoBrowser:(SDPhotoBrowser *)browser didSlideAtIndex:(NSInteger)index
{
}
@end
