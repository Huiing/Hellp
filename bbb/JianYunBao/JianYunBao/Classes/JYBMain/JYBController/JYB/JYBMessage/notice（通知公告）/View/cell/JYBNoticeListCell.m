//
//  JYBNoticeListCell.m
//  JianYunBao
//
//  Created by 正 on 16/3/16.
//  Copyright © 2016年 冰点. All rights reserved.
//

#import "JYBNoticeListCell.h"

@implementation JYBNoticeListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"JYBNoticeListCell";
    JYBNoticeListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JYBNoticeListCell class]) owner:self options:nil] objectAtIndex:0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

+ (CGFloat)heightForRow
{
    return Compose_Scale(90);
}

- (void)setNoticeEntity:(JYBNoticeListItem *)item{
    titleLab.text = item.title;
    contentLab.text = item.content;
    agreeCountLab.text = item.agreeCount;
    commentCountLab.text = item.msgCount;
    //时间处理
    NSString * createdTime = [item.dt substringToIndex:10];
    dateLab.text = [NSString stringWithFormat:@"发布日期：%@｜发布人：%@",createdTime,item.createMan];
}


@end
