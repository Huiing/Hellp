#import <UIKit/UIKit.h>

@interface DatePickerHeadView : UIView

- (void)addTarget:(id)target confirmAction:(SEL)action;
- (void)addTarget:(id)target cancelAction:(SEL)action;

@end
