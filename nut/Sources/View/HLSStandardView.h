//
//  HLSStandardView.h
//  nut
//
//  Created by Samuel Défago on 9/1/10.
//  Copyright 2010 Hortis. All rights reserved.
//

// Convenience factory macro for creating views of a given class; useful since no covariant return types in Objective-C
#define STANDARD_VIEW(className)                 (className *)[className view]

// Convenience macro for retrieving the height of a view; this macro was not needed, but introduced for consistency
#define STANDARD_VIEW_HEIGHT(className)          [className height]

/**
 * Abstract class for easy view creation.
 *
 * To make working with views generated using a xib (one example is table view headers), just inherit from this class. 
 * This forces you to define view properties in a standard and centralized way (namely in the implementation file
 * of the corresponding class), instead of putting redundant code in all code using the view.
 *
 * To create your own view class, simply subclass HLSStandardView and:
 *   - override the height method to return the height of the view if not the default one (44.f). This is not
 *     mandatory if you never plan to use the STANDARD_VIEW_HEIGHT macro
 *   - if your view layout is created using a xib file not bearing the same name as the view class, override the
 *     xibFileName accessor to return the name of the xib file. If the xib file bears the same name as its
 *     corresponding class, you do not need to override this accessor
 * Your custom classes can then be instantiated using the provided factory macro.
 *
 * To define the view layout in Interface Builder, the first object in the xib must be the view object. Do not forget 
 * to set its type to match your view class name (if you need to bind outlets). Use this class as origin when drawing 
 * bindings (do not use the file's owner)
 *
 * Designated initializer: initWithFrame: (you usually do not need to create a view manually. Use the factory method 
 * instead)
 */
@interface HLSStandardView : UIView {
@private
    
}

/**
 * Factory method for creating the view
 */
+ (UIView *)view;

/**
 * Implement this method to reflect the height of the view in your nib file
 */
+ (CGFloat)height;

/**
 * If the view layout is created using Interface Builder, override this accessor to return the name of the associated xib
 * file. This is not needed if the xib file name is identical to the class name
 */
+ (NSString *)xibFileName;

@end
