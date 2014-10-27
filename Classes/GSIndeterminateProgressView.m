//
//  GSIndeterminateProgressView.m
//  Neverlate
//
//  Created by Endika Gutiérrez Salas on 15/11/13.
//  Copyright (c) 2013 Endika Gutiérrez Salas. All rights reserved.
//

#import "GSIndeterminateProgressView.h"
#import "CALayer+MBAnimationPersistence.h"

const CGFloat CHUNK_WIDTH = 36.0f;

@implementation GSIndeterminateProgressView

@synthesize isAnimating = _isAnimating;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;

        self.trackTintColor = [UIColor whiteColor];
        self.progressTintColor = [UIColor blueColor];

        self.hidesWhenStopped = YES;
        self.hidden = YES;
    }
    return self;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackTintColor = trackTintColor;
    self.backgroundColor = trackTintColor;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor = progressTintColor;
    [self.progressChunks enumerateObjectsUsingBlock:^(UIView* v, NSUInteger idx, BOOL *stop) {
        v.backgroundColor = progressTintColor;
    }];
}

- (void)startAnimating
{
    if (_isAnimating) return;
    _isAnimating = YES;

    self.hidden = NO;

    self.progressChunks = @[[[UIView alloc] initWithFrame:CGRectMake(-CHUNK_WIDTH, 0, CHUNK_WIDTH, self.frame.size.height)],
                            [[UIView alloc] initWithFrame:CGRectMake(-CHUNK_WIDTH, 0, CHUNK_WIDTH, self.frame.size.height)]];

    __block float delay = 0.0f;
    __weak GSIndeterminateProgressView* safeSelf = self;
    [self.progressChunks enumerateObjectsUsingBlock:^(UIView* v, NSUInteger idx, BOOL *stop) {
        v.backgroundColor = safeSelf.progressTintColor;
        [safeSelf addSubview:v];
        [safeSelf animateProgressChunk:v delay:(delay += 0.35f)];
    }];
}

- (void)stopAnimating
{
    if (!_isAnimating) return;
    _isAnimating = NO;

    self.hidden = self.hidesWhenStopped;

    [self.progressChunks enumerateObjectsUsingBlock:^(UIView* v, NSUInteger idx, BOOL *stop) {
        [UIView animateWithDuration:(.3f*idx)
                              delay:0.0f
                            options:0
                         animations:^{
                             v.alpha = 0.0f;
                         } completion:^(BOOL finished) {
                             [v removeFromSuperview];
                         }];
    }];

    self.progressChunks = nil;
}

- (void)animateProgressChunk:(UIView *)chunk delay:(NSTimeInterval)delay
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect chuckFrame2 = chunk.frame;
        chuckFrame2.origin.x = -CHUNK_WIDTH;
        chunk.frame = chuckFrame2;
        [UIView animateWithDuration:0.95f delay:delay options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionRepeat animations:^{
            CGRect chuckFrame3 = chunk.frame;
            chuckFrame3.origin.x = self.frame.size.width;
            chunk.frame = chuckFrame3;
        } completion:^(BOOL finished) {
            //if (finished)
        }];
        //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((.75f+delay) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //        [self animateProgressChunk:chunk delay:0.4f];
        //    });
        [chunk.layer MB_setCurrentAnimationsPersistent];
    });
}

@end
