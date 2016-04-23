//
//  BDBaseTableView.m
//  BDBaseTableView
//
//  Created by 冰点 on 15/4/30.
//  Copyright (c) 2015年 冰点. All rights reserved.
//

#import "BDBaseTableView.h"


@implementation BDBaseTableView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableDelegate)] && [_touchDelegate respondsToSelector:@selector(tableView:touchesBegin:withEvent:)]) {
        [_touchDelegate tableView:self touchesBegin:touches withEvent:event];
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableDelegate)] && [_touchDelegate respondsToSelector:@selector(tableView:touchesMoved:withEvent:)]) {
        [_touchDelegate tableView:self touchesMoved:touches withEvent:event];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableDelegate)] && [_touchDelegate respondsToSelector:@selector(tableView:touchesEnded:withEvent:)]) {
        [_touchDelegate tableView:self touchesEnded:touches withEvent:event];
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableDelegate)] && [_touchDelegate respondsToSelector:@selector(tableView:touchesCancelled:withEvent:)]) {
        [_touchDelegate tableView:self touchesCancelled:touches withEvent:event];
    }
}
//MARK:public methods

/**
 *  隐藏没有数据的分割线
 */
- (void)hideSeparatorForNotDataSource
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.1)];
    self.tableHeaderView = view;
    self.tableFooterView = view;
    
}

- (void)hideSeparatorWhenNotDataSource:(BDSeparatorHideType)separatorType
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.1)];
    switch (separatorType) {
        case BDSeparatorHideTypeHeader:
            self.tableHeaderView = view;
            break;
        case BDSeparatorHideTypeFooter:
            self.tableFooterView = view;
            break;
        default:
            self.tableHeaderView = view;
            self.tableFooterView = view;
            break;
    }
    
}

- (void)hideTableViewCellSeparator
{
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)clearTableBackgroundView
{
    self.backgroundView = nil;
    self.backgroundColor = [UIColor clearColor];
}

- (void)viewDidlayoutSeparatorInset
{
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)drawiOS6TableGroupStyle:(UITableView *)tableView destinationTable:(UITableView *)destTable cell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self drawiOS6TableGroupStyle:tableView destinationTable:destTable cell:cell forRowAtIndexPath:indexPath filterSection:0];
}

- (void)drawiOS6TableGroupStyle:(UITableView *)tableView destinationTable:(UITableView *)destTable cell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath filterSection:(NSInteger)section
{
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == destTable) {
            if (indexPath.section == section) {
                return;
            }
            CGFloat cornerRadius = 5.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 20, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+10, bounds.size.height-lineHeight, bounds.size.width-10*2, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}

@end
