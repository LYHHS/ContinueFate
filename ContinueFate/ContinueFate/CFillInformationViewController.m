//
//  CFillInformationViewController.m
//  ContinueFate
//
//  Created by admin2015 on 16/4/23.
//  Copyright © 2016年 XuYuan. All rights reserved.
//

#import "CFillInformationViewController.h"

@interface CFillInformationViewController () <UITextViewDelegate> {
    //统计
    NSInteger statistical;
}
@property (strong ,nonatomic)NSString *greender;
@end

@implementation CFillInformationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _DescribeTV.delegate = self;
   //将统计字数设为0
    statistical = 0;
    NSLog(@"_objectForShow  = %@, _expertsM = %@",_objectForShow,_expertsM);
    //若希望在开关控件被打开或关闭时得到通知信息,就必须在你的类中,利用 UISwitch 的addTarget:action:forControlEvents:方法加上开关的 target。如下代码:
   [_Swtich addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
    
}

//点击开关获取 “男 女”
-(void)switchIsChanged:(UISwitch *)swith
{
    if ([_Swtich isOn]){
        NSLog(@"nv");
        _greender = @"女";
    } else {
        NSLog(@"nan");
        _greender = @"男";
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//实现Placeholder属性执行以下方法（用label实现Placeholder，当textView输入内容时隐藏label）
- (void)textViewDidChange:(UITextView *)textView
{
        if (_DescribeTV.text.length==0){
            //textview长度为0
            if ([textView isKindOfClass:nil]) {
                //判断是否为删除键
                _PlaceholderLab.hidden=NO;
                //隐藏文字
            }else{
                _PlaceholderLab.hidden=YES;
            }
        }else{//textview长度不为0
            if (_DescribeTV.text.length==1){
                //textview长度为1时候
                if ([textView isKindOfClass:nil]) {
                    //判断是否为删除键
                    _PlaceholderLab.hidden=NO;
                }else{
                    //不是删除
                    _PlaceholderLab.hidden=YES;
                }
            }else{
                //长度不为1时候
                _PlaceholderLab.hidden=YES;
            }
        }
    statistical = 300 - textView.text.length;
    [_LimitWN setText:[NSString stringWithFormat:@"(%ld/300}", (long)statistical]];  //_wordCount是一个显示剩余可输入数字的label
}

//如果输入超过规定的字数100，就不再让输入
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location >= 300)
    {
        [Utilities popUpAlertViewWithMsg:@"您已输入的字数据已达上限" andTitle:nil onView:self];
        return  NO;
    }
    else
    {
        return YES;
    }
}
//创建随机订单号（不确保唯一性）
- (NSString *)generateTradeNO {
    
    NSMutableString *resultStr = [[NSMutableString alloc]init];
    //订单号为15位数
    static int kNO = 15;
    //设置订单号中每一个字符的随机范围；
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    for (int i = 0 ; i < kNO ; i++) {
        
        //获取一个随机整数来表示从上述订单号随机范围字符串中截取第几个字符，该随机整数的获取范围应该从字符串的index0开始一直到字符串最后一个字符的index结束(0~35)
        NSInteger index = arc4random() % sourceStr.length;
        //
        //    NSString *oneStr = [sourceStr substringToIndex: index];
        //    NSString *twoStr = [oneStr substringFromIndex:oneStr.length - 1];
        
        //获取index位置所在的单个字符串的NSRange（范围：在字符串中所在位置和长度）值
        NSRange range = NSMakeRange(index, 1);
        //根据上述NSRange值去截取该单个字符
        NSString *oneStr = [sourceStr substringWithRange:range];
        //在一个可变字符串的结尾续接一个字符串
        [resultStr appendString:oneStr];
        
    }
    
    
    return resultStr;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)CompleteAction:(UIButton *)sender forEvent:(UIEvent *)event {
    //称呼
    NSString *cell = _CellTF.text;
    //年龄
    NSString *age = _AgeTF.text;
    //手机号
    NSString *phoneNum = _PhoneNum.text;
    //描述的问题
    NSString *Describe = _DescribeTV.text;
    //订单号
    NSString *tradeNO = [self generateTradeNO];
    NSLog(@"tradeNO = %@",tradeNO);
    //判断是否填写完整信息
    if ([_greender isEqualToString:@""] || [cell isEqualToString:@""] ||[age isEqualToString:@""] ||[phoneNum isEqualToString:@""] || [Describe isEqualToString:@""]) {
        [Utilities popUpAlertViewWithMsg:@"请填写完整信息" andTitle:nil onView:self];
    }
    //确认信息
   NSString *str = [[NSString alloc]initWithFormat:@"您的称呼：%@\n您的年龄：%@\n您的性别：%@\n您的联系电话：%@" ,cell ,age ,_greender ,phoneNum] ;
    //初始化提示框；
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认基本信息" message:str preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"在这里存数据");
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }]];

    //弹出提示框；  CLHSearchBar
    [self presentViewController:alert animated:true completion:nil];


}

@end
