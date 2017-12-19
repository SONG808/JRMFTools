//
//  MKAnnotationView+JYWebCache.m
//  JYWebImage
//
//  Created by Olivier Poitrey on 14/03/12.
//  Copyright (c) 2012 Dailymotion. All rights reserved.
//

#import "MKAnnotationView+JYWebCache.h"
#import "objc/runtime.h"
#import "UIView+JYWebCacheOperation.h"

static char imageURLKey;

@implementation MKAnnotationView (JYWebCache)

- (NSURL *)jy_imageURL {
    return objc_getAssociatedObject(self, &imageURLKey);
}

- (void)jy_setImageWithURL:(NSURL *)url {
    [self jy_setImageWithURL:url placeholderImage:nil options:0 completed:nil];
}

- (void)jy_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self jy_setImageWithURL:url placeholderImage:placeholder options:0 completed:nil];
}

- (void)jy_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(JYWebImageOptions)options {
    [self jy_setImageWithURL:url placeholderImage:placeholder options:options completed:nil];
}

- (void)jy_setImageWithURL:(NSURL *)url completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setImageWithURL:url placeholderImage:nil options:0 completed:completedBlock];
}

- (void)jy_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setImageWithURL:url placeholderImage:placeholder options:0 completed:completedBlock];
}

- (void)jy_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(JYWebImageOptions)options completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_cancelCurrentImageLoad];

    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.image = placeholder;

    if (url) {
        __weak MKAnnotationView *wself = self;
        id <JYWebImageOperation> operation = [JYWebImageManager.sharedManager downloadImageWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, JYImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                __strong MKAnnotationView *sself = wself;
                if (!sself) return;
                if (image) {
                    sself.image = image;
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        [self jy_setImageLoadOperation:operation forKey:@"MKAnnotationViewImage"];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:@"JYWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, JYImageCacheTypeNone, url);
            }
        });
    }
}

- (void)jy_cancelCurrentImageLoad {
    [self jy_cancelImageLoadOperationWithKey:@"MKAnnotationViewImage"];
}

@end
