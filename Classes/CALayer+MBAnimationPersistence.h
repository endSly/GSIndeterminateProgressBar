//
//  CALayer+MBAnimationPersistence.h
//
//  Created by Matej Bukovinski on 19. 03. 14.
//  Copyright (c) 2014 Matej Bukovinski. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


@interface CALayer (MBAnimationPersistence)

/**
 Animation keys for animations that should be persisted.
 Inspect the `animationKeys` array to find valid keys for your layer.
 
 `CAAnimation` instances associated with the provided keys will be copied and held onto,
 when the applications enters background mode and restored when exiting background mode.
 
 Set to `nil`to disable persistance.
 */
@property (nonatomic, strong) NSArray *MB_persistentAnimationKeys;

/** Set all current `animationKeys` as persistent. */
- (void)MB_setCurrentAnimationsPersistent;

@end
