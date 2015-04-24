//
//  ViewController.m
//  alidemo
//
//  Created by 王晨 on 15/3/10.
//  Copyright (c) 2015年 zhfish. All rights reserved.
//

#import "ViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *resultTextView;
@property (weak, nonatomic) IBOutlet UITextField *apiTextField;
@property (strong,nonatomic) NSMutableDictionary* response;
@end

@implementation ViewController
DEF_USERDEFAULTS(NSString, PayString)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.PayString) {
        self.apiTextField.text = self.PayString;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeText:(UITextField *)sender {
    self.PayString = sender.text;
}

- (IBAction)fetchPayString:(UIButton *)sender {
    NSURL * url = [NSURL URLWithString:self.PayString];
    NSString * resp = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    if(resp == nil) {
        ALERT(@"抓取失败");
        return;
    }
    
    self.response = [NSJSONSerialization JSONObjectWithData:[resp dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    if (self.response == nil) {
        ALERT(@"解析失败");
        return;
    }
    
    self.resultTextView.text = [self getPayStringFromJson];
}

//提取json里面的字段
- (NSString*)getPayStringFromJson {
    if (self.response == nil) {
        return @"";
    }
    return self.response[@"data"];
}

- (IBAction)goPay:(UIButton *)sender {
    NSLog(self.response[@"data"]);
    [[AlipaySDK defaultService] payOrder:[self getPayStringFromJson] fromScheme:ALISCHEME callback:^(NSDictionary *resultDic) {
        if ([resultDic[@"resultStatus"] integerValue] == 9000) {
            ALERT(@"支付成功");
        }
        else
        {
            ALERT(@"支付失败");
        }
        
        NSData * resp = [NSJSONSerialization dataWithJSONObject:resultDic options:NSJSONWritingPrettyPrinted error:nil];
        self.resultTextView.text = [[NSString alloc] initWithData:resp encoding:NSUTF8StringEncoding];
    }];

}
- (IBAction)hideKeyBoard:(UIButton *)sender {
    [self.apiTextField resignFirstResponder];
}
- (IBAction)makeSign:(UIButton *)sender {
    
    NSString * private = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANs9r8bMj0FS6uvU5qbYasJ47eFkmO53LNFctHIY1L7WUWOopmBszgfhu09CatllhD53FmxZda2Cz/7K8thAl0fQWFMlf3BO2iuwkO033ybxa8+2QRqzlA2QKyFvhVsqKAEPh94+vP/d8US+bG8ChEBEVqyvkiIoBvngqKV4VKLHAgMBAAECgYAO8YZwo3LEPhWbG3jZOHkWZk24hjXSUzcv0gTOnhiqJUuI4m7stZ3Zda5huaI0zTGVXGKf4f0eZYMt18Fzsftdnml1f7h1PD8ysJ5fTVzUw6eZpLIj5GB3mG8Pvy4NZR+sZ/kjnBVDNLr05dGz6IOfe8q/KvzqZH+o03+cU+hZcQJBAPXShCHBXeYrKFsx44kY6jxnGrVh6S8rx4WgyDl3DccYgrVBQaEHE9vzChAWA/IgDwdo5gjf6E8Kx669uAEMZBkCQQDkUW7lma7hPL3/+h71qHyFi6csyHceQwY0VqUwc3oxT++do+CvxTT2dvGRP1aXnExSSrvVvgKFQOQhgJJfOxnfAkEAx+ON1BDztNUFNNqlZfbfiYxheHqMbfIQhQWPqsK3blzs9EyC/FjP+jtvxFLSlJEjB2hyHWdM9PEUHHBi7l9QCQJBAJnfZ+XFVV7nGQXTA9p72rAGFnzP/befZCcR3fJxYQCq5spPD7ZmKfOQ5e0Fys4SwD0VsNG0ZO55dUY+6GbV5fECQQDROPc0Mr6Ph0GVwM23Nth5vzsueVrRljjDAMMKRLzVrnzTKdJdPDFnHPQokxd9wYJElmqWZjgo9pTUOTOWj5Cw";
    
    Order *order = [[Order alloc] init];
    order.partner = @"2088711694792332";
    order.seller = @"zhifubao@wheel365.com";
    order.tradeNO = @"12345678901234567890"; //订单ID（由商家自行制定）
    order.productName = @"乐递积分"; //商品标题
    order.productDescription = @"我要买积分"; //商品描述
    order.amount = @"0.01"; //商品价格
    order.notifyURL =  @"http://qa.wheel365.com?test=123"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    NSString *orderSpec = [order description];
    
    id<DataSigner> signer = CreateRSADataSigner(private);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderSpec, signedString, @"RSA"];;

    self.response = [@{@"data" : orderString} mutableCopy];
    self.resultTextView.text = orderString;
}
@end
