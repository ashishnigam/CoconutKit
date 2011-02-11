//
//  HLSStandardTableViewCell.h
//  nut
//
//  Created by Samuel Défago on 8/21/10.
//  Copyright 2010 Hortis. All rights reserved.
//

// Convenience factory macro for creating table view cells of a given class (either HLSStandardTableViewCell or a
// subclass); useful since no covariant return types in Objective-C
#define HLS_TABLE_VIEW_CELL(className, tableView)       (className *)[className tableViewCellForTableView:tableView]

// Convenience factory macro for retrieving the height of cells for a given class (either HLSStandardTableViewCell or a
// subclass); this macro was not needed, but introduced for consistency
#define HLS_TABLE_VIEW_CELL_HEIGHT(className)           [className height]

/**
 * Class for easy table view cell creation. Using this class, you avoid having to code the cell reuse mechanism
 * every time you instantiate cells. This class also forces centralization of common cell class properties, like
 * cell identifier, dimensions, style and xib file (if any).
 *
 * If you do not need other customization properties than the ones offered by a UITableViewCell with default style
 * (UITableViewCellStyleDefault), you can simply instantiate HLSStandardTableViewCell using the factory macro.
 * Other simple table view cells also exist for the other built-in cell styles (HLSValue1TableViewCell,
 * HLSValue1TableViewCell and HLSSubtitleTableViewCell). Those are similarly instantiated using the factory macro.
 *
 * If you need further customization abilities, like cells whose layout is defined using a xib or programmatically, 
 * you must sublcass HLSStandardTableViewCell and:
 *   - override the height method to return the height of the cell if not the default one (44.f, which is the original
 *     size of cells created using Interface Builder)
 *   - if your cell layout is created using a xib file not bearing the same name as the cell class, override the
 *     xibFileName accessor to return the name of the xib file. If the xib file bears the same name as its
 *     corresponding class or if your cell layout is created programmatically, do not override this accessor
 *   - override the identifier method to return the cell identifier used by the reuse mechanism if the default value
 *     (the class name) does not suit your needs, which should be rarely the case
 * Your custom classes can then be instantiated using the provided factory macro.
 *
 * When your class uses a xib to define its layout:
 *   - the first object in the xib must be the cell object. Do not forget to set its type to match your cell class name
 *     (if you need to bind outlets). Use this class as origin when drawing bindings (do not use the file's owner)
 *   - do not forget to set the cell identifier to the one returned by the identifier class method. By default this
 *     identifier is the class name, except if your class overrides it. If you fail to do so, the reuse mechanism
 *     will not work
 *
 * Designated initializer: initWithStyle:reuseIdentifier:
 * (You usually do not need to create a cell manually. Use the factory macros instead)
 */
@interface HLSStandardTableViewCell : UITableViewCell {
@private

}

/**
 * Factory method for creating a table view cell. A downcast might be needed to be able to edit cell attributes,
 * that is why you should use the HLS_TABLE_VIEW_CELL factory method which does this cast for you
 */
+ (UITableViewCell *)tableViewCellForTableView:(UITableView *)tableView;

/**
 * Method for cell skinning
 */
- (void)setBackgroundWithImageNamed:(NSString *)backgroundImageName
    selectedBackgroundWithImageName:(NSString *)selectedBackgroundImageName;

/**
 * Override this method to return the height of your custom cell class if not the default one (44.f). This has to
 * be done whether the cell is created programmatically or using a xib file
 */
+ (CGFloat)height;

/**
 * If the cell layout is created using Interface Builder, override this accessor to return the name of the associated xib
 * file. This is not needed if the xib file name is identical to the class name
 */
+ (NSString *)xibFileName;

/**
 * The cell identifier to apply for cell reuse. You can override this method if you do really want to define your
 * own identifier in a subclass, otherwise just stick with the default implementation (which uses the class name
 * as cell identifier)
 */
+ (NSString *)identifier;

@end
