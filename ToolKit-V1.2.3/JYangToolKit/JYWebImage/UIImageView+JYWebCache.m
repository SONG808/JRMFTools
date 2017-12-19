/*
 * This file is part of the JYWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+JYWebCache.h"
#import "objc/runtime.h"
#import "UIView+JYWebCacheOperation.h"

static char imageURLKey;

@implementation UIImageView (JYWebCache)

- (void)jy_setImageWithURL:(NSURL *)url {
    [self jy_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)jy_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self jy_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)jy_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(JYWebImageOptions)options {
    [self jy_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)jy_setImageWithURL:(NSURL *)url completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)jy_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)jy_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(JYWebImageOptions)options completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)jy_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(JYWebImageOptions)options progress:(JYWebImageDownloaderProgressBlock)progressBlock completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (!(options & JYWebImageDelayPlaceholder)) {
        dispatch_main_async_safe(^{
            self.image = placeholder;
        });
    }
    
    if (url) {
        __weak UIImageView *wself = self;
        id <JYWebImageOperation> operation = [JYWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, JYImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (image) {
                    wself.image = image;
                    [wself setNeedsLayout];
                } else {
                    if ((options & JYWebImageDelayPlaceholder)) {
                        wself.image = placeholder;
                        [wself setNeedsLayout];
                    }
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        [self jy_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:@"JYWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, JYImageCacheTypeNone, url);
            }
        });
    }
}

- (void)jy_setImageWithPreviousCachedImageWithURL:(NSURL *)url andPlaceholderImage:(UIImage *)placeholder options:(JYWebImageOptions)options progress:(JYWebImageDownloaderProgressBlock)progressBlock completed:(JYWebImageCompletionBlock)completedBlock {
    NSString *key = [[JYWebImageManager sharedManager] cacheKeyForURL:url];
    UIImage *lastPreviousCachedImage = [[JYImageCache sharedImageCache] imageFromDiskCacheForKey:key];
    
    [self jy_setImageWithURL:url placeholderImage:lastPreviousCachedImage ?: placeholder options:options progress:progressBlock completed:completedBlock];    
}

- (NSURL *)jy_imageURL {
    return objc_getAssociatedObject(self, &imageURLKey);
}

- (void)jy_setAnimationImagesWithURLs:(NSArray *)arrayOfURLs {
    [self jy_cancelCurrentAnimationImagesLoad];
    __weak UIImageView *wself = self;

    NSMutableArray *operationsArray = [[NSMutableArray alloc] init];

    for (NSURL *logoImageURL in arrayOfURLs) {
        id <JYWebImageOperation> operation = [JYWebImageManager.sharedManager downloadImageWithURL:logoImageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, JYImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                __strong UIImageView *sself = wself;
                [sself stopAnimating];
                if (sself && image) {
                    NSMutableArray *currentImages = [[sself animationImages] mutableCopy];
                    if (!currentImages) {
                        currentImages = [[NSMutableArray alloc] init];
                    }
                    [currentImages addObject:image];

                    sself.animationImages = currentImages;
                    [sself setNeedsLayout];
                }
                [sself startAnimating];
            });
        }];
        [operationsArray addObject:operation];
    }

    [self jy_setImageLoadOperation:[NSArray arrayWithArray:operationsArray] forKey:@"UIImageViewAnimationImages"];
}

- (void)jy_cancelCurrentImageLoad {
    [self jy_cancelImageLoadOperationWithKey:@"UIImageViewImageLoad"];
}

- (void)jy_cancelCurrentAnimationImagesLoad {
    [self jy_cancelImageLoadOperationWithKey:@"UIImageViewAnimationImages"];
}

@end
