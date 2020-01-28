//
// Created by Rene on 11/25/18.
//
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/*
 * All methods set autoresizing masks by common sense
 */
@interface UIView (CSLayout)

//- (instancetype)fromLeft:(CGFloat)left top:(CGFloat)top
//NS_SWIFT_NAME(from(left:top:));
//
//- (instancetype)fromLeft:(CGFloat)left bottom:(CGFloat)bottom
//NS_SWIFT_NAME(from(left:bottom:));

//- (instancetype)fromLeft:(CGFloat)left top:(CGFloat)top
//                   width:(CGFloat)width height:(CGFloat)height
//NS_SWIFT_NAME(from(left:top:width:height:));

//- (instancetype)fromLeft:(CGFloat)value
//NS_SWIFT_NAME(from(left:));
//
//- (instancetype)fromTop:(CGFloat)value
//NS_SWIFT_NAME(from(top:));

///*
// * Distance of right bound from right side of parent
// */
//- (instancetype)fromRight:(CGFloat)distanceFromRight
//NS_SWIFT_NAME(from(right:));

///*
// * Distance of bottom bound from bottom side of parent
// */
//- (instancetype)fromBottom:(CGFloat)distanceFromBottom
//NS_SWIFT_NAME(from(bottom:));

- (instancetype)fromTopRight:(CGFloat)value
NS_SWIFT_NAME(from(topRight:));

- (instancetype)fromTopLeft:(CGFloat)value
NS_SWIFT_NAME(from(topLeft:));

- (instancetype)fromBottomRight:(CGFloat)value
NS_SWIFT_NAME(from(bottomRight:));

- (instancetype)fromBottomLeft:(CGFloat)value
NS_SWIFT_NAME(from(bottomLeft:));

/*
 *  Resize view width so that its right boundary
 *  will be in specified distance from right side
 */
- (instancetype)widthFromRight:(CGFloat)right
NS_SWIFT_NAME(width(fromRight:));

/*
 *  Resize view height so that its bottom boundary
    will be in specified distance from bottom side
 */
- (instancetype)heightFromBottom:(CGFloat)bottom
NS_SWIFT_NAME(height(fromBottom:));

/*
 *  By setting left, width will be resized
 */
- (instancetype)widthFromLeft:(CGFloat)left
NS_SWIFT_NAME(width(fromLeft:));

/*
 *  By setting right, width will be resized
 */
- (instancetype)widthByRight:(CGFloat)right
NS_SWIFT_NAME(width(byRight:));

/*
 *  By setting top, height will be resized
 */
- (instancetype)heightFromTop:(CGFloat)top
NS_SWIFT_NAME(height(fromTop:));

/*
 *  By setting bottom, height will be resized
 */
- (instancetype)heightByBottom:(CGFloat)bottom
NS_SWIFT_NAME(height(byBottom:));

/*
 * Set width so right side will stay at fixed position
 */
- (instancetype)fixedRightSetWidth:(CGFloat)width
NS_SWIFT_NAME(fixedRight(width:));

/*
 * Set height so bottom side will stay at fixed position
 */
- (instancetype)fixedBottomSetHeight:(CGFloat)height
NS_SWIFT_NAME(fixedBottom(height:));

- (instancetype)heightDisabledAutosizing:(CGFloat)height;

- (instancetype)widthDisabledAutosizing:(CGFloat)width;

/*
 * Resize and moves content to have and keep specified vertical padding
 in relation to parent container
 */
- (instancetype)contentPaddingVertical:(CGFloat)padding;

/*
 * Resize and moves content to have and keep specified horizontal padding
 in relation to parent container
 */
- (instancetype)contentPaddingHorizontal:(CGFloat)padding;

/*
 * Resize and moves content to have and keep specified padding
 in relation to parent container
 */
- (instancetype)contentPadding:(CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
