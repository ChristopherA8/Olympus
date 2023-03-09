#import "OLYStepperTableCell.h"
#import <Preferences/PSSpecifier.h>

extern NSString *const PSControlMinimumKey;
extern NSString *const PSControlMaximumKey;

static NSString *const kHBStepperTableCellSingularLabelKey = @"singularLabel";

@implementation OLYStepperTableCell

@dynamic control;

#pragma mark - PSTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                    specifier:(PSSpecifier *)specifier {
  self = [super initWithStyle:style
              reuseIdentifier:reuseIdentifier
                    specifier:specifier];

  if (self) {
    self.accessoryView = self.control;
    self.control.stepValue = 0.5;
  }

  return self;
}

- (void)refreshCellContentsWithSpecifier:(PSSpecifier *)specifier {
  [super refreshCellContentsWithSpecifier:specifier];

  self.control.minimumValue =
      ((NSNumber *)specifier.properties[PSControlMinimumKey]).doubleValue;
  self.control.maximumValue =
      ((NSNumber *)specifier.properties[PSControlMaximumKey]).doubleValue;
  [self _updateLabel];
}

- (void)setCellEnabled:(BOOL)cellEnabled {
  [super setCellEnabled:cellEnabled];
  self.control.enabled = cellEnabled;
}

#pragma mark - PSControlTableCell

- (UIStepper *)newControl {
  UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectZero];
  stepper.continuous = NO;
  return stepper;
}

- (NSNumber *)controlValue {
  return @(self.control.value);
}

- (void)setValue:(NSNumber *)value {
  [super setValue:value];
  self.control.value = value.doubleValue;
}

- (void)controlChanged:(UIStepper *)stepper {
  [super controlChanged:stepper];
  [self _updateLabel];
}

- (void)_updateLabel {
  if (!self.control) {
    return;
  }

  self.textLabel.text =
      self.control.value == 1
          ? self.specifier.properties[kHBStepperTableCellSingularLabelKey]
          : [NSString stringWithFormat:self.specifier.name,
                                       (float)self.control.value];
  [self setNeedsLayout];
}

#pragma mark - UITableViewCell

- (void)prepareForReuse {
  [super prepareForReuse];

  self.control.value = 0;
  self.control.minimumValue = 0;
  self.control.maximumValue = 100;
}

@end