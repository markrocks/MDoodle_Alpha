//
// ParentMonsterTestView.h
// Generated by Core Animator version 1.0.3 on 3/26/15.
//
// DO NOT MODIFY THIS FILE. IT IS AUTO-GENERATED AND WILL BE OVERWRITTEN
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ParentMonsterTestView : UIView

@property (strong, nonatomic) NSDictionary *viewsByName;

// Frank
- (void)addFrankAnimation;
- (void)addFrankAnimationWithCompletion:(void (^)(BOOL finished))completionBlock;
- (void)addFrankAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion;
- (void)addFrankAnimationAndRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)addFrankAnimationWithBeginTime:(CFTimeInterval)beginTime andFillMode:(NSString *)fillMode andRemoveOnCompletion:(BOOL)removedOnCompletion completion:(void (^)(BOOL finished))completionBlock;
- (void)removeFrankAnimation;

- (void)removeAllAnimations;

@end