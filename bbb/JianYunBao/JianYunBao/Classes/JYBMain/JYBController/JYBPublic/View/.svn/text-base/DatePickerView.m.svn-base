
#import "DatePickerView.h"
#import "DatePickerHeadView.h"
@interface DatePickerView()
{
  NSString *selectedDate;
}
@end
@implementation DatePickerView
- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame] ;
  if(self)
  {
    [self initDatePickerView];
    [self initDatePickerHeadView];
  }
  return self;
}
- (void)initDatePickerHeadView {
  _headView       = [[[NSBundle mainBundle] loadNibNamed:@"DatePickerHeadView" owner:nil options:nil] lastObject];
  CGRect frame    = _headView.bounds;
  frame.origin.y  = 0;
  frame.size      = CGSizeMake(Mwidth, 40);
  _headView.frame = frame;
  [self addSubview:_headView];
}

- (void)dataValueChanged:(UIDatePicker *)sender {
  UIDatePicker *dataPicker_one = (UIDatePicker *) sender;
  NSDate *date_one             = dataPicker_one.date;
  NSDateFormatter *formatter   = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  _resultStr                   = [formatter stringFromDate:date_one];

}
- (void)initDatePickerView {
  NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
  _datePickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, Mwidth, 200)];
  _datePickerView.backgroundColor = [UIColor whiteColor];
  _datePickerView.locale = locale;
  
  [_datePickerView setDatePickerMode:UIDatePickerModeDate];
  //定义最小日期
  NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
  [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
  NSDate *minDate = [formatter_minDate dateFromString:@"1970-01-01"];
  [_datePickerView setMinimumDate:minDate];

  _datePickerView.maximumDate = [NSDate distantFuture];
  [_datePickerView addTarget:self action:@selector(dataValueChanged:) forControlEvents:UIControlEventValueChanged];
  [self addSubview:_datePickerView];
//  _datePickerView.hidden = YES;
}

- (void)setMaximumDate:(NSDate *)date{
  _datePickerView.maximumDate = date;
}
- (void)setMinimumDate:(NSDate *)date{
  _datePickerView.minimumDate = date;
}
//设置初始显示日期
- (void)setDate:(NSString *)dateStr{
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:@"yyyy-MM-dd"];
  NSDate *date = [formatter dateFromString:dateStr];
  [_datePickerView setDate:date animated:YES];
}
@end
