/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook, 3.0 Edition
 BSD License, Use at your own risk
 */

/*
 Thanks to Kevin Ballard for suggesting the UITextField as subview approach
 All credit to Kenny TM. Mistakes are mine. 
 To Do: Ensure that only one runs at a time -- is that possible?
 */

#define BUTTON_YES @"是"
#define BUTTON_NO @"否"
#define BUTTON_OK @"确定"
#define BUTTON_CANCEL @"取消"

#import "EasyAlert.h"
#import <stdarg.h>

#define TEXT_FIELD_TAG	9999

@interface EasyAlertDelegate : NSObject <UIAlertViewDelegate, UITextFieldDelegate> 
{
	void(^_block)(NSString *text, NSUInteger index);
	NSString *text;
	NSUInteger index;
}
@property (assign) NSUInteger index;
@property (retain) NSString *text;
@end

@implementation EasyAlertDelegate
@synthesize index;
@synthesize text;

-(id) initWithBlock: (void (^)(NSString *text, NSUInteger index))block
{
	if (self = [super init]) _block = Block_copy(block);
	return [self retain];
}

+ (id) delegateWithBlock: (void (^)(NSString *text, NSUInteger index))block
{
    EasyAlertDelegate *dlg = [[EasyAlertDelegate alloc] initWithBlock:block];
	return [dlg autorelease];
}

// User pressed button. Retrieve results
-(void)alertView:(UIAlertView*)aView clickedButtonAtIndex:(NSInteger)anIndex 
{
	UITextField *tf = (UITextField *)[aView viewWithTag:TEXT_FIELD_TAG];
	if (tf) self.text = tf.text;
	self.index = anIndex;
    if (_block != nil) {
        _block(tf ? tf.text : nil,anIndex);
    }
    [self release];
}

- (BOOL) isLandscape
{
	return ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) || ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight);
}

// Move alert into place to allow keyboard to appear
- (void) moveAlert: (UIAlertView *) alertView
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.25f];
	if (![self isLandscape])
		alertView.center = CGPointMake(160.0f, 180.0f);
	else 
		alertView.center = CGPointMake(240.0f, 90.0f);
	[UIView commitAnimations];
	
	[[alertView viewWithTag:TEXT_FIELD_TAG] becomeFirstResponder];
}

- (void) dealloc
{
	self.text = nil;
    Block_release(_block);
    _block = nil;
	[super dealloc];
}

@end

@implementation EasyAlert

+ (void) ask: (void(^)(NSUInteger answer)) block question: (NSString *) question withCancel: (NSString *) cancelButtonTitle withButtons: (NSArray *) buttons
{
	// Create Alert
	EasyAlertDelegate *madelegate = [EasyAlertDelegate delegateWithBlock:^(NSString *text, NSUInteger index) {
        if (block != nil) {
            block(index);
        }
    }];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:question message:nil delegate:madelegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
	for (NSString *buttonTitle in buttons) [alertView addButtonWithTitle:buttonTitle];
	[alertView show];
	
	[alertView release];
}

+ (void) say: (id)formatstring,...
{
	va_list arglist;
	va_start(arglist, formatstring);
	id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
	va_end(arglist);
	[EasyAlert ask:nil question:statement withCancel:BUTTON_OK withButtons:nil];
	[statement release];
}

+ (void) say: (void(^)()) block message: (id)formatstring,...
{
	va_list arglist;
	va_start(arglist, formatstring);
	id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
	va_end(arglist);
	[EasyAlert ask:^(NSUInteger a){block();} question:statement withCancel:BUTTON_OK withButtons:nil];
	[statement release];
}

+ (void) ask: (void(^)(BOOL answer)) block question: (id)formatstring,...
{
	va_list arglist;
	va_start(arglist, formatstring);
	id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
	va_end(arglist);
	[EasyAlert ask: ^(NSUInteger a){block(a == 0);} question: statement withCancel:nil withButtons:[NSArray arrayWithObjects:BUTTON_YES, BUTTON_NO, nil]];
    [statement release];
}

+ (void) confirm: (void(^)()) block question: (id)formatstring,...
{
	va_list arglist;
	va_start(arglist, formatstring);
	id statement = [[NSString alloc] initWithFormat:formatstring arguments:arglist];
	va_end(arglist);
	[EasyAlert ask: ^(NSUInteger a){if(a == 1)block();} question:statement withCancel:BUTTON_CANCEL withButtons:[NSArray arrayWithObject:BUTTON_OK]];
	[statement release];
}

+(void) textQueryWithBlock:(void(^)(NSString * answer)) block question: (NSString *)question prompt: (NSString *)prompt button1: (NSString *)button1 button2:(NSString *) button2
{
	// Create alert
	EasyAlertDelegate *madelegate = [EasyAlertDelegate delegateWithBlock:^(NSString *text, NSUInteger index) {
        if (block != nil) {
            block(text);
        }
    }];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:question message:@"\n" delegate:madelegate cancelButtonTitle:button1 otherButtonTitles:button2, nil];

	// Build text field
	UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 260.0f, 30.0f)];
	tf.borderStyle = UITextBorderStyleRoundedRect;
	tf.tag = TEXT_FIELD_TAG;
	tf.placeholder = prompt;
	tf.clearButtonMode = UITextFieldViewModeWhileEditing;
	//tf.keyboardType = UIKeyboardTypeAlphabet;
	//tf.keyboardAppearance = UIKeyboardAppearanceAlert;
	tf.autocapitalizationType = UITextAutocapitalizationTypeWords;
	tf.autocorrectionType = UITextAutocorrectionTypeNo;
	tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

	// Show alert and wait for it to finish displaying
	[alertView show];
	while (CGRectEqualToRect(alertView.bounds, CGRectZero));
	
	// Find the center for the text field and add it
	CGRect bounds = alertView.bounds;
	tf.center = CGPointMake(bounds.size.width / 2.0f, bounds.size.height / 2.0f - 10.0f);
	[alertView addSubview:tf];
	[tf release];
	
	// Set the field to first responder and move it into place
	[madelegate performSelector:@selector(moveAlert:) withObject:alertView afterDelay: 0.7f];

	[alertView release];
}

+ (void) ask: (void(^)(NSString * answer)) block question: (NSString *) question withTextPrompt: (NSString *) prompt
{
    [EasyAlert textQueryWithBlock:block question:question prompt:prompt button1:BUTTON_CANCEL button2:BUTTON_OK];
}
@end

