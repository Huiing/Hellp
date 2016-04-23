//
//  JYBAppSettingCell.m
//  JianYunBao
//
//  Created by 冰点 on 16/1/28.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBAppSettingCell.h"
#import "JYBPlaySound.h"



@implementation JYBAppSettingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"JYBAppSettingCell";
    JYBAppSettingCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[JYBAppSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        cell.indexPath = indexPath;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _switch = [UISwitch new];
        
    }
    return self;
}
- (void)setAppSettingTitle:(NSString *)title
{
    self.textLabel.text = title;
    if (self.indexPath.section)
    {
        
    }
    else
    {
        self.accessoryView = _switch;
        if (self.indexPath.row==1)
        {
            [_switch addTarget:self action:@selector(switchOfVoice:) forControlEvents:UIControlEventValueChanged];
        }
        else if (self.indexPath.row==0)
        {
            [_switch addTarget:self action:@selector(switchOfShake:) forControlEvents:UIControlEventValueChanged];
        }
    }
}
- (void)switchOfVoice:(UISwitch *)sender
{
    BOOL isOn = [sender isOn];
    if (isOn)
    {
        JYBPlaySound *playSound = [[JYBPlaySound alloc] initForPlayingVibrate];
        [playSound play];
    }
}
- (void)switchOfShake:(UISwitch *)sender
{
    BOOL isOn = [sender isOn];
    if (isOn)
    {
        JYBPlaySound *playSound = [[JYBPlaySound alloc] initForPlayingSystemSoundWith:@"sms-received1" ofType:@"caf"];
        [playSound play];
    }
}
//- (void)layoutSubviews
//{
//    DLog(@"%@",NSStringFromCGRect(self.detailTextLabel.frame));
////    _switch.x = 
//}

@end
