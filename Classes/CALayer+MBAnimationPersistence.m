//
//  CALayer+MBAnimationPersistence.m
//
//  Created by Matej Bukovinski on 19. 03. 14.
//  Copyright (c) 2014 Guerrilla Code. All rights reserved.
//

#import <objc/runtime.h>
#import "CALayer+MBAnimationPersistence.h"


@interface MBPersistentAnimationContainer : NSObject
@property (nonatomic, weak) CALayer *layer;
@property (nonatomic, copy) NSArray *persistentAnimationKeys;
@property (nonatomic, copy) NSDictionary *persistedAnimations;
- (id)initWithLayer:(CALayer *)layer;
@end


@interface CALayer (MBAnimationPersistencePrivate)
@property (nonatomic, strong) MBPersistentAnimationContainer *MB_animationContainer;
@end


@implementation CALayer (MBAnimationPersistence)

#pragma mark - Public

- (NSArray *)MB_persistentAnimationKeys {
	return self.MB_animationContainer.persistentAnimationKeys;
}

- (void)setMB_persistentAnimationKeys:(NSArray *)persistentAnimationKeys {
	MBPersistentAnimationContainer *container = [self MB_animationContainer];
	if (!container) {
		container = [[MBPersistentAnimationContainer alloc] initWithLayer:self];
		[self MB_setAnimationContainer:container];
	}
	container.persistentAnimationKeys = persistentAnimationKeys;
}

- (void)MB_setCurrentAnimationsPersistent {
	self.MB_persistentAnimationKeys = [self animationKeys];
}

#pragma mark - Associated objects

- (void)MB_setAnimationContainer:(MBPersistentAnimationContainer *)animationContainer {
	objc_setAssociatedObject(self, @selector(MB_animationContainer), animationContainer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MBPersistentAnimationContainer *)MB_animationContainer {
    return objc_getAssociatedObject(self, @selector(MB_animationContainer));
}

#pragma mark - Pause and resume

// TechNote QA1673 - How to pause the animation of a layer tree
// @see https://developer.apple.com/library/ios/qa/qa1673/_index.html

- (void)MB_pauseLayer {
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

- (void)MB_resumeLayer {
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

@end

@implementation MBPersistentAnimationContainer

#pragma mark - Lifecycle

- (id)initWithLayer:(CALayer *)layer {
	self = [super init];
	if (self) {
		_layer = layer;
	}
	return self;
}

- (void)dealloc {
	[self unregisterFromAppStateNotifications];
}

#pragma mark - Keys

- (void)setPersistentAnimationKeys:(NSArray *)persistentAnimationKeys {
	if (persistentAnimationKeys != _persistentAnimationKeys) {
		if (!_persistentAnimationKeys) {
			[self registerForAppStateNotifications];
		} else if (!persistentAnimationKeys) {
			[self unregisterFromAppStateNotifications];
		}
		_persistentAnimationKeys = persistentAnimationKeys;
	}
}

#pragma mark - Persistence

- (void)persistLayerAnimationsAndPause {
	CALayer *layer = self.layer;
	if (!layer) {
		return;
	}
	NSMutableDictionary *animations = [NSMutableDictionary new];
	for (NSString *key in self.persistentAnimationKeys) {
		CAAnimation *animation = [layer animationForKey:key];
		if (animation) {
			animations[key] = animation;
		}
	}
	if (animations.count > 0) {
		self.persistedAnimations = animations;
		[layer MB_pauseLayer];
	}
}

- (void)restoreLayerAnimationsAndResume {
	CALayer *layer = self.layer;
	if (!layer) {
		return;
	}
	[self.persistedAnimations enumerateKeysAndObjectsUsingBlock:^(NSString *key, CAAnimation *animation, BOOL *stop) {
		[layer addAnimation:animation forKey:key];
	}];
	if (self.persistedAnimations.count > 0) {
		[layer MB_resumeLayer];
	}
	self.persistedAnimations = nil;
}

#pragma mark - Notifications

- (void)registerForAppStateNotifications {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)unregisterFromAppStateNotifications {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)applicationDidEnterBackground {
	[self persistLayerAnimationsAndPause];
}

- (void)applicationWillEnterForeground {
	[self restoreLayerAnimationsAndResume];
}

@end
