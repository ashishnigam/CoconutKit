//
//  HLSLayerAnimation.h
//  CoconutKit
//
//  Created by Samuel Défago on 8/20/12.
//  Copyright (c) 2012 Hortis. All rights reserved.
//

#import "HLSObjectAnimation.h"

#import "HLSVector.h"

/**
 * A layer animation (HLSLayerAnimation) describes the changes applied to a layer within an animation step
 * (HLSLayerAnimationStep). An animation step is the combination of several layer animations applied
 * to a set of layerss, and represent the collective set of changes applied to them during some time interval.
 * An animation (HLSAnimation) is then simply a collection of animation steps, either view-based
 * (HLSViewAnimationStep) or layer-based (HLSLayerAnimationStep).
 *
 * A layer animation animates layer transforms. This choice was made because frame animation would limit
 * transforms to affine transforms, for which HLSViewAnimation can be used instead (provided the layer belongs 
 * to a view, of course). Moreover, unlike views, layers do not layout their sublayers automatically based 
 * on autoresizing properties in iOS.
 *
 * Since transforms and not frames are altered, animated views do not have to implement any of the sublayer
 * layout callbacks (usually -[CALayer layoutSublayers] or -[UIView layoutSublayersOfLayer:])
 *
 * Designated initializer: init (create a layer animation step with default settings)
 */
@interface HLSLayerAnimation : HLSObjectAnimation {
@private
    HLSVector4 m_rotationParameters;
    HLSVector3 m_scaleParameters;
    HLSVector3 m_translationParameters;
    CGFloat m_opacityVariation;
}

/**
 * Geometric transform parameters to be applied during the layer animation. The resulting transform (which you can
 * obtain by calling -transform) applies the rotation, the scale and finally the translation
 */
- (void)rotateByAngle:(CGFloat)angle aboutVectorWithX:(CGFloat)x y:(CGFloat)y z:(CGFloat)z;
- (void)scaleWithXFactor:(CGFloat)xFactor yFactor:(CGFloat)yFactor zFactor:(CGFloat)zFactor;
- (void)translateByVectorWithX:(CGFloat)x y:(CGFloat)y z:(CGFloat)z;

/**
 * Convenience method to calculate the layer animation parameters needed to transform a rect into another one
 */
- (void)transformFromRect:(CGRect)fromRect toRect:(CGRect)toRect;

/**
 * Opacity increment or decrement to be applied during the layer animation. Any value between 1.f and -1.f can be provided,
 * though you should ensure that opacity never reaches a value outside [0, 1] during an animation.
 *
 * Default value is 0.f
 */
@property (nonatomic, assign) CGFloat opacityVariation;

/**
 * The transform corresponding to the transform parameters associated with the layer animation
 *
 * If no rotation, scale or translation parameters have been set, this property returns the identity matrix
 */
@property (nonatomic, readonly, assign) CATransform3D transform;

@end
