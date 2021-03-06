//
//  JYBQualityTaskCell.m
//  JianYunBao
//
//  Created by faith on 16/3/25.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBQualityTaskCell.h"

@implementation JYBQualityTaskCell

+ (UINib*)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JYBQualityTaskCell class]) bundle:nil];
}
- (void)awakeFromNib
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    _workStateImage.userInteractionEnabled = YES;
    [_workStateImage addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2:)];
    _lookImage.userInteractionEnabled = YES;
    [_lookImage addGestureRecognizer:tapGesture2];
    
}
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    if(self.statusImageBlock)
    {
        self.statusImageBlock();
    }
}
- (void)tapAction2:(UITapGestureRecognizer *)sender
{
    if(self.lookImageBlock)
    {
        self.lookImageBlock();
    }
}

+ (NSString *)cellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@Identifier",NSStringFromClass([JYBQualityTaskCell class])];
}
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBQualityTaskCell";
    JYBQualityTaskCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBQualityTaskCell class]) owner:self options:nil] firstObject];
    }
    cell.lineView.backgroundColor = RGB(50, 156, 229);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)setQualitySubtaskItem:(JYBQualitySubtaskItem *)qualitySubtaskItem
{
//    NSString * executorStr = [qualitySubtaskItem.executors componentsJoinedByString:@","];
//    _executor.text = executorStr;
    _executor.font = [UIFont systemFontOfSize:10];
    _taskName.text = qualitySubtaskItem.name;
    NSString *workState = qualitySubtaskItem.workState;
    if([workState isEqualToString:@"0"])
    {
        _workStateImage.image = [UIImage imageNamed:@"进行中1"];
    }
    else if ([workState isEqualToString:@"1"])
    {
        _workStateImage.image = [UIImage imageNamed:@"完成"];
    }
    else if([workState isEqualToString:@"2"])
    {
        _workStateImage.image = [UIImage imageNamed:@"暂停"];
    }

}

@end
