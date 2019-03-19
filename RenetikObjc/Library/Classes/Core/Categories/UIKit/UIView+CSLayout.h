//
// Created by Rene on 11/25/18.
//
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

/*
 * All methods set autoresizing masks by common sense
 */
@interface UIView (CSLayout)

- (instancetype)left :(CGFloat)value;  //TODO move to position remove and use fromLeft

- (instancetype)top :(CGFloat)value; //TODO move to position remove and use fromTop

- (instancetype)right :(CGFloat)value; //TODO move to position check usages

- (instancetype)bottom :(CGFloat)value; //TODO move to position check usages

- (instancetype)left :(CGFloat)left top :(CGFloat)top; // replace with fromLeftTop

- (instancetype)position :(CGPoint)position; /// check usages

- (instancetype)position :(CGFloat)left :(CGFloat)top; // replace with fromLeftTop

- (instancetype)left :(CGFloat)left top :(CGFloat)top
               width :(CGFloat)width height :(CGFloat)height;             // replace with fromLeftTop + size

/*
 *  By setting left, width will be resized
 */
- (instancetype)leftToWidth :(CGFloat)left;

/*
 *  By setting right, width will be resized
 */
- (instancetype)rightToWidth :(CGFloat)right;

/*
 *  By setting top, height will be resized
 */
- (instancetype)topToHeight :(CGFloat)top;

/*
 *  By setting bottom, height will be resized
 */
- (instancetype)bottomToHeight :(CGFloat)bottom;

- (instancetype)fromLeft :(CGFloat)distanceFromLeft;

- (instancetype)fromTop :(CGFloat)distanceFromTop;

/*
 * Distance of right bound from right side of parent
 */
- (instancetype)fromRight :(CGFloat)distanceFromRight;

/*
 * Distance of bottom bound from bottom side of parent
 */
- (instancetype)fromBottom :(CGFloat)distanceFromBottom;

- (instancetype)fromTopRight :(CGFloat)value;

- (instancetype)fromTopLeft :(CGFloat)value;

- (instancetype)fromBottomRight :(CGFloat)value;

- (instancetype)fromBottomLeft :(CGFloat)value;

/*
 *  Resize view width so that its right boundary
 *  will be in specified distance from right side
 */
- (instancetype)fromRightToWidth :(CGFloat)distanceFromRight;

/*
 *  Resize view height so that its bottom boundary
    will be in specified distance from bottom side
 */
- (instancetype)fromBottomToHeight :(CGFloat)distanceFromBottom;

/*
 * Set width so right side will stay at fixed position
 */
- (instancetype)widthFixedRight :(CGFloat)width;

/*
 * Set height so bootm side will stay at fixed position
 */
- (instancetype)heightFixedBottom :(CGFloat)height;

- (instancetype)heightDisabledAutosizing :(CGFloat)height;

- (instancetype)widthDisabledAutosizing :(CGFloat)width;

/*
 * Fill parent completely with autosizing
 */
- (instancetype)matchParent;

/*
 * Fill parent completely with margin and autosizing
 */
- (instancetype)matchParentWithMargin :(CGFloat)margin;

/*
 * Fill parent width with autosizing
 */
- (instancetype)matchParentWidth;

/*
 * Fill parent width with marign and autosizing
 */
- (instancetype)matchParentWidthWithMargin :(CGFloat)margin;

/*
 * Fill parent height with marign and autosizing
 */
- (instancetype)matchParentHeightWithMargin :(CGFloat)margin;

/*
 * Fill parent height and autosizing
 */
- (instancetype)matchParentHeight;

/*
 * Resize and moves content to have and keep specified vertical padding
 in relation to parent container
 */
- (instancetype)contentPaddingVertical :(CGFloat)padding;

/*
 * Resize and moves content to have and keep specified horizontal padding
 in relation to parent container
 */
- (instancetype)contentPaddingHorizontal :(CGFloat)padding;

/*
 * Resize and moves content to have and keep specified padding
 in relation to parent container
 */
- (instancetype)contentPadding :(CGFloat)padding;

@end

NS_ASSUME_NONNULL_END
