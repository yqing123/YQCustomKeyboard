//
//  YQCustomKeyboardView.m
//  YQCustomKeyboard
//
//  Created by 杨清 on 2018/8/8.
//  Copyright © 2018年 深圳市前海硕极科技有限公司. All rights reserved.
//

#import "YQCustomKeyboardView.h"

#define kCustomKeyboardHeight ([UIScreen mainScreen].bounds.size.width>375?200:176)


@interface YQCustomKeyboardView ()

@property (copy, nonatomic) NSArray <NSString *>*keysArr;

@property (nonatomic, assign) YQCustomKeyboardViewType keyboardType;

@end


@implementation YQCustomKeyboardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kCustomKeyboardHeight);
        
    }
    return self;
}

+ (instancetype)keyboardWithType:(YQCustomKeyboardViewType)keyboardType delegate:(id <YQCustomKeyboardViewDelegate>)delegate
{
    YQCustomKeyboardView *keyboardView = [[YQCustomKeyboardView alloc] init];
    keyboardView.delegate = delegate;
    keyboardView.keyboardType = keyboardType;
    return keyboardView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)reloadKeyboardWithKeys:(NSArray <NSString *>*)keysArr
{
    self.keysArr = keysArr;
    
}

- (void)setKeyboardType:(YQCustomKeyboardViewType)keyboardType
{
    _keyboardType = keyboardType;
    
    switch (keyboardType) {
        case YQCustomKeyboardViewTypeDefault:
        case YQCustomKeyboardViewTypeCarnumber:
        {
            //
            {
                NSArray *keyArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
                UIControl *containerView = [[UIControl alloc] initWithFrame:self.bounds];
                containerView.backgroundColor = [UIColor colorWithRed:207/255.0 green:212/255.0 blue:217/255.0 alpha:1];
                [self addSubview:containerView];
                CGFloat leftEdgeInsets = 12;
                CGFloat spacing = 5;
                CGFloat btnWidth = (containerView.frame.size.width-2*leftEdgeInsets-9*spacing)/10;
                CGFloat tmpY = 10;
                CGFloat btnHeight = (containerView.frame.size.height-10-8-3*5)/4;
                for (NSInteger i=0; i<10 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+i*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 2000+i;
                    btn.backgroundColor = UIColor.whiteColor;
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-10*btnWidth-9*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=10; i<20 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-10)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 2000+i;
                    btn.backgroundColor = UIColor.whiteColor;
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-9*btnWidth-8*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=20; i<29 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-20)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 2000+i;
                    btn.backgroundColor = UIColor.whiteColor;
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-7*btnWidth-6*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=29; i<36 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-29)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 2000+i;
                    btn.backgroundColor = UIColor.whiteColor;
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                //切换键盘
                UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, tmpY, leftEdgeInsets-12-spacing, btnHeight)];
                changeBtn.backgroundColor = UIColor.whiteColor;
                [changeBtn setTitle:[NSString stringWithFormat:@"%@",@"切换"] forState:UIControlStateNormal];
                [changeBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [changeBtn addTarget:self action:@selector(tapChangeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:changeBtn];
                //删除按钮
                UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width-12-50, tmpY, 50, btnHeight)];
                delBtn.backgroundColor = UIColor.whiteColor;
                [delBtn setTitle:[NSString stringWithFormat:@"%@",@"删除"] forState:UIControlStateNormal];
                [delBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [delBtn addTarget:self action:@selector(tapDeleteKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:delBtn];
            }
#if 1
            //省简称
            {
                NSArray *keyArr = @[@"京",@"沪",@"粤",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"桂",@"琼",@"渝",@"川",@"桂",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新"];
                UIControl *containerView = [[UIControl alloc] initWithFrame:self.bounds];
                containerView.backgroundColor = [UIColor colorWithRed:209/255.0 green:214/255.0 blue:219/255.0 alpha:1];
                [self addSubview:containerView];
                CGFloat leftEdgeInsets = 12;
                CGFloat spacing = 5;
                CGFloat btnWidth = (containerView.frame.size.width-2*leftEdgeInsets-9*spacing)/10;
                CGFloat tmpY = 10;
                CGFloat btnHeight = (containerView.frame.size.height-10-8-3*5)/4;
                for (NSInteger i=0; i<10 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+i*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 1000+i;
                    btn.backgroundColor = UIColor.whiteColor;
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-9*btnWidth-8*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=10; i<19 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-10)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 1000+i;
                    btn.backgroundColor = UIColor.whiteColor;
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-7*btnWidth-6*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=19; i<26 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-19)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 1000+i;
                    btn.backgroundColor = UIColor.whiteColor;
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                leftEdgeInsets = (containerView.frame.size.width-5*btnWidth-4*spacing)/2;
                tmpY += btnHeight+5;
                for (NSInteger i=26; i<31 && i<keyArr.count; i++) {
                    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(leftEdgeInsets+(i-26)*(btnWidth+spacing), tmpY, btnWidth, btnHeight)];
                    btn.tag = 1000+i;
                    btn.backgroundColor = UIColor.whiteColor;
                    [btn setTitle:[NSString stringWithFormat:@"%@",keyArr[i]] forState:UIControlStateNormal];
                    [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                    [btn addTarget:self action:@selector(tapInputKey:) forControlEvents:UIControlEventTouchUpInside];
                    [containerView addSubview:btn];
                }
                //切换键盘
                UIButton *changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, tmpY, 50, btnHeight)];
                changeBtn.backgroundColor = UIColor.whiteColor;
                [changeBtn setTitle:[NSString stringWithFormat:@"%@",@"切换"] forState:UIControlStateNormal];
                [changeBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [changeBtn addTarget:self action:@selector(tapChangeKeyboard:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:changeBtn];
                //删除按钮
                UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(containerView.frame.size.width-12-50, tmpY, 50, btnHeight)];
                delBtn.backgroundColor = UIColor.whiteColor;
                [delBtn setTitle:[NSString stringWithFormat:@"%@",@"删除"] forState:UIControlStateNormal];
                [delBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                [delBtn addTarget:self action:@selector(tapDeleteKey:) forControlEvents:UIControlEventTouchUpInside];
                [containerView addSubview:delBtn];
            }
#endif
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark - actions

- (void)tapInputKey:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(customKeyboardInputKey:)]) {
        [self.delegate customKeyboardInputKey:[sender titleForState:UIControlStateNormal]];
    }
}
- (void)tapDeleteKey:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(customKeyboardDeleteKey)]) {
        [self.delegate customKeyboardDeleteKey];
    }
}

- (void)tapChangeKeyboard:(UIButton *)sender
{
    NSLog(@"Change Keyboard");
    [self sendSubviewToBack:sender.superview];
}

@end
