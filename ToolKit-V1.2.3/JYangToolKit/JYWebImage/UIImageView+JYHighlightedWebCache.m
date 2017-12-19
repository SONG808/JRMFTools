/*
 * This file is part of the JYWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+JYHighlightedWebCache.h"
#import "UIView+JYWebCacheOperation.h"

#define UIImageViewHighlightedWebCacheOperationKey @"highlightedImage"

@implementation UIImageView (JYHighlightedWebCache)

- (void)jy_setHighlightedImageWithURL:(NSURL *)url {
    [self jy_setHighlightedImageWithURL:url options:0 progress:nil completed:nil];
}

- (void)jy_setHighlightedImageWithURL:(NSURL *)url options:(JYWebImageOptions)options {
    [self jy_setHighlightedImageWithURL:url options:options progress:nil completed:nil];
}

- (void)jy_setHighlightedImageWithURL:(NSURL *)url completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setHighlightedImageWithURL:url options:0 progress:nil completed:completedBlock];
}

- (void)jy_setHighlightedImageWithURL:(NSURL *)url options:(JYWebImageOptions)options completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setHighlightedImageWithURL:url options:options progress:nil completed:completedBlock];
}

- (void)jy_setHighlightedImageWithURL:(NSURL *)url options:(JYWebImageOptions)options progress:(JYWebImageDownloaderProgressBlock)progressBlock completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_cancelCurrentHighlightedImageLoad];

    if (url) {
        __weak UIImageView      *wself    = self;
        id<JYWebImageOperation> operation = [JYWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, JYImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe (^
                                     {
                                         if (!wself) return;
                                         if (image) {
                                             wself.highlightedImage = image;
                                             [wself setNeedsLayout];
                                         }
                                         if (completedBlock && finished) {
                                             completedBlock(image, error, cacheType, url);
                                         }
                                     });
        }];
        [self jy_setImageLoadOperation:operation forKey:UIImageViewHighlightedWebCacheOperationKey];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:@"JYWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, JYImageCacheTypeNone, url);
            }
        });
    }
}

- (void)jy_cancelCurrentHighlightedImageLoad {
    [self jy_cancelImageLoadOperationWithKey:UIImageViewHighlightedWebCacheOperationKey];
}

@end
