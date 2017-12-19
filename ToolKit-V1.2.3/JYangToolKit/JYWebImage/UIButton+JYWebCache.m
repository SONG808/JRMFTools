/*
 * This file is part of the JYWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIButton+JYWebCache.h"
#import "objc/runtime.h"
#import "UIView+JYWebCacheOperation.h"

static char imageURLStorageKey;

@implementation UIButton (JYWebCache)

- (NSURL *)jy_currentImageURL {
    NSURL *url = self.imageURLStorage[@(self.state)];

    if (!url) {
        url = self.imageURLStorage[@(UIControlStateNormal)];
    }

    return url;
}

- (NSURL *)jy_imageURLForState:(UIControlState)state {
    return self.imageURLStorage[@(state)];
}

- (void)jy_setImageWithURL:(NSURL *)url forState:(UIControlState)state {
    [self jy_setImageWithURL:url forState:state placeholderImage:nil options:0 completed:nil];
}

- (void)jy_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder {
    [self jy_setImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:nil];
}

- (void)jy_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(JYWebImageOptions)options {
    [self jy_setImageWithURL:url forState:state placeholderImage:placeholder options:options completed:nil];
}

- (void)jy_setImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setImageWithURL:url forState:state placeholderImage:nil options:0 completed:completedBlock];
}

- (void)jy_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:completedBlock];
}

- (void)jy_setImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(JYWebImageOptions)options completed:(JYWebImageCompletionBlock)completedBlock {

    [self setImage:placeholder forState:state];
    [self jy_cancelImageLoadForState:state];
    
    if (!url) {
        [self.imageURLStorage removeObjectForKey:@(state)];
        
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:@"JYWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, JYImageCacheTypeNone, url);
            }
        });
        
        return;
    }
    
    self.imageURLStorage[@(state)] = url;

    __weak UIButton *wself = self;
    id <JYWebImageOperation> operation = [JYWebImageManager.sharedManager downloadImageWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, JYImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (!wself) return;
        dispatch_main_sync_safe(^{
            __strong UIButton *sself = wself;
            if (!sself) return;
            if (image) {
                [sself setImage:image forState:state];
            }
            if (completedBlock && finished) {
                completedBlock(image, error, cacheType, url);
            }
        });
    }];
    [self jy_setImageLoadOperation:operation forState:state];
}

- (void)jy_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state {
    [self jy_setBackgroundImageWithURL:url forState:state placeholderImage:nil options:0 completed:nil];
}

- (void)jy_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder {
    [self jy_setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:nil];
}

- (void)jy_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(JYWebImageOptions)options {
    [self jy_setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:options completed:nil];
}

- (void)jy_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setBackgroundImageWithURL:url forState:state placeholderImage:nil options:0 completed:completedBlock];
}

- (void)jy_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_setBackgroundImageWithURL:url forState:state placeholderImage:placeholder options:0 completed:completedBlock];
}

- (void)jy_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state placeholderImage:(UIImage *)placeholder options:(JYWebImageOptions)options completed:(JYWebImageCompletionBlock)completedBlock {
    [self jy_cancelImageLoadForState:state];

    [self setBackgroundImage:placeholder forState:state];

    if (url) {
        __weak UIButton *wself = self;
        id <JYWebImageOperation> operation = [JYWebImageManager.sharedManager downloadImageWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, JYImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!wself) return;
            dispatch_main_sync_safe(^{
                __strong UIButton *sself = wself;
                if (!sself) return;
                if (image) {
                    [sself setBackgroundImage:image forState:state];
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        }];
        [self jy_setBackgroundImageLoadOperation:operation forState:state];
    } else {
        dispatch_main_async_safe(^{
            NSError *error = [NSError errorWithDomain:@"JYWebImageErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
            if (completedBlock) {
                completedBlock(nil, error, JYImageCacheTypeNone, url);
            }
        });
    }
}

- (void)jy_setImageLoadOperation:(id<JYWebImageOperation>)operation forState:(UIControlState)state {
    [self jy_setImageLoadOperation:operation forKey:[NSString stringWithFormat:@"UIButtonImageOperation%@", @(state)]];
}

- (void)jy_cancelImageLoadForState:(UIControlState)state {
    [self jy_cancelImageLoadOperationWithKey:[NSString stringWithFormat:@"UIButtonImageOperation%@", @(state)]];
}

- (void)jy_setBackgroundImageLoadOperation:(id<JYWebImageOperation>)operation forState:(UIControlState)state {
    [self jy_setImageLoadOperation:operation forKey:[NSString stringWithFormat:@"UIButtonBackgroundImageOperation%@", @(state)]];
}

- (void)jy_cancelBackgroundImageLoadForState:(UIControlState)state {
    [self jy_cancelImageLoadOperationWithKey:[NSString stringWithFormat:@"UIButtonBackgroundImageOperation%@", @(state)]];
}

- (NSMutableDictionary *)imageURLStorage {
    NSMutableDictionary *storage = objc_getAssociatedObject(self, &imageURLStorageKey);
    if (!storage)
    {
        storage = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &imageURLStorageKey, storage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return storage;
}

@end
