//
//  ConditionViewController.m
//  ConditionController
//
//  Created by 陈松林 on 14-9-3.
//  Copyright (c) 2014年 陈松林. All rights reserved.
//

#import "ConditionViewController.h"
#import "SynptomCell.h"

@interface ConditionViewController ()

@end

@implementation ConditionViewController
{
    NSArray*array;
    int addIndex;//添加按钮的叠加器
    int addRow;//添加按钮行的叠加器
    CGFloat selectValueAddWidth;
    NSMutableDictionary*selectConditionDict;
    NSMutableArray*colorArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    array=[[NSArray alloc]initWithObjects:@"阿和国际环境",@"啊看",@"阿绝对是 vv",@"阿好机会",@"阿会离开",@"阿还是 v 好",@"阿个很好",@"阿发个广告",@"阿个很好 i 人",@"一天热",@"阿好风景好",@"还是更好",@"咖灰过",@"女结婚 v 机会",@"Yury 特好机会",@"女家啊好 v",@"过分噶风格",@"经济的恢复和",@"刚刚发",@"考试",@"看见阿规范化的功夫",@"可还是的机会",@"饭否发",@"爸爸上班的",@"让人和家人", nil];
    [self loadColor];
    addIndex=0;
    addRow=1;
    selectValueAddWidth=0;
    
    selectConditionDict=[[NSMutableDictionary alloc]init];
    
    CGRect viewFrame=self.btnScrollView.frame;
    [self.btnScrollView removeFromSuperview];
    self.btnScrollView=[[UIScrollView alloc]initWithFrame:viewFrame];
    [self.btnScrollView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.view addSubview:self.btnScrollView];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)loadColor
{
    
    UIColor*color1=[[UIColor alloc]initWithRed:250/255.0 green:146/255.0 blue:81/255.0 alpha:1];
    UIColor*color2=[[UIColor alloc]initWithRed:242/255.0 green:101/255.0 blue:71/255.0 alpha:1];
    UIColor*color3=[[UIColor alloc]initWithRed:245/255.0 green:187/255.0 blue:90/255.0 alpha:1];
    UIColor*color4=[[UIColor alloc]initWithRed:241/255.0 green:148/255.0 blue:193/255.0 alpha:1];
    UIColor*color5=[[UIColor alloc]initWithRed:79/255.0 green:211/255.0 blue:190/255.0 alpha:1];
    
    colorArray=[[NSMutableArray alloc]initWithObjects:color1,color2,color3,color4,color5,color1,color2,color3,color4,color5, nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SynptomCell*cell=(SynptomCell*)[tableView dequeueReusableCellWithIdentifier:@"SynptomCell"];
    if(cell==nil)
    {
        NSArray*nib=[[NSBundle mainBundle] loadNibNamed:@"SynptomCell" owner:tableView options:nil];
        cell=[nib objectAtIndex:0];
    }
    NSString*selectValue=[array objectAtIndex:indexPath.row];
    cell.synptomLable.text =selectValue;
    
    if([[selectConditionDict allValues] containsObject:selectValue])
        [cell.cellImgView setImage:[UIImage imageNamed:@"EnterPay01.png"]];
    else
        [cell.cellImgView setImage:[UIImage imageNamed:@"EnterPay02.png"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SynptomCell*cell=(SynptomCell*)[tableView cellForRowAtIndexPath:indexPath];
    NSString*selectValue=[array objectAtIndex:indexPath.row];
    if(![[selectConditionDict allValues] containsObject:selectValue])
    {
        [cell.cellImgView setImage:[UIImage imageNamed:@"EnterPay01.png"]];
        [self scrollViewAddSubView:selectValue];
    }
    else
    {
        [cell.cellImgView setImage:[UIImage imageNamed:@"EnterPay02.png"]];
        [self scrollViewDeleteSubView:selectValue];
    }
}

-(void)scrollViewAddSubView:(NSString*)selectValue
{
    
    
    CGFloat marginLeft=10.0;
    CGFloat marginTop=5.0;
    addIndex++;
    CGSize size=self.btnScrollView.frame.size;
    CGFloat scrollViewWidth=size.width-marginLeft*2;
    CGFloat scrollViewHeight=size.height;
    CGFloat selectValueWidth=selectValue.length*16.0+8.0;
    CGFloat selectValueHeight=24.0;
    CGFloat selectValueMarginLeft=0;
    selectValueAddWidth+=selectValueWidth+(addIndex-1)*marginLeft;
    if(selectValueAddWidth>scrollViewWidth)
    {
        selectValueMarginLeft=10.0;
        selectValueAddWidth=selectValueWidth;
        addRow++;
    }
    else
    {
        selectValueMarginLeft=selectValueAddWidth-selectValueWidth+marginLeft;
    }
    if(addRow>1)
    {
        marginTop=addRow*5.0+(addRow-1)*selectValueHeight;
    }
    else
    {
        marginTop=5.0;
    }
    selectValueAddWidth-=(addIndex-1)*marginLeft;
    UIButton*addBtn=[[UIButton alloc]initWithFrame:CGRectMake(selectValueMarginLeft, marginTop, selectValueWidth, selectValueHeight)];
    [addBtn setBackgroundColor:[colorArray objectAtIndex:(addIndex-1)%10]];
    [addBtn setTitle:selectValue forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    addBtn.tag=addIndex-1;
    [selectConditionDict setObject:selectValue forKey:[NSString stringWithFormat:@"%d",addIndex-1]];
    [addBtn addTarget:self action:@selector(deleteSubview:) forControlEvents:UIControlEventTouchUpInside];
    UIImage*xImg=[UIImage imageNamed:@"X.png"];
    UIImageView*xImgView=[[UIImageView alloc]initWithImage:xImg];
    [xImgView setFrame:CGRectMake(selectValueWidth-8, 0, 8, 8)];
    [addBtn addSubview:xImgView];
    [self.btnScrollView addSubview:addBtn];
    if(addRow*5.0+(addRow+1)*selectValueHeight>scrollViewHeight)
    {
        self.btnScrollView.contentSize=CGSizeMake(scrollViewWidth+marginLeft*2, addRow*5.0+(addRow+1)*selectValueHeight);
    }
}
-(void)deleteSubview:(id)sender
{
    selectValueAddWidth=0;
    UIButton*deleteBtn=(UIButton*)sender;
    NSString*tempKey=[NSString stringWithFormat:@"%ld",(long)deleteBtn.tag];
    [selectConditionDict removeObjectForKey:tempKey];
    [self.myTabView reloadData];
    [self renewAddSubView];
}
-(void)scrollViewDeleteSubView:(NSString*)selectValue
{
    for (NSString*key in selectConditionDict.allKeys) {
        if([[selectConditionDict valueForKey:key]isEqual:selectValue])
        {
            [selectConditionDict removeObjectForKey:key];
            break;
        }
    }
    [self renewAddSubView];
}
-(void)renewAddSubView
{
    addIndex=0;
    addRow=1;
    CGRect viewFrame=self.btnScrollView.frame;
    [self.btnScrollView removeFromSuperview];
    self.btnScrollView=[[UIScrollView alloc]initWithFrame:viewFrame];
    [self.btnScrollView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [self.view addSubview:self.btnScrollView];
    CGFloat marginLeft=10.0;
    CGFloat marginTop=5.0;
    CGSize size=self.btnScrollView.frame.size;
    CGFloat scrollViewWidth=size.width-marginLeft*2;
    CGFloat scrollViewHeight=size.height;
    CGFloat selectValueHeight=24.0;
    CGFloat selectValueForAddWidth=0;
    NSMutableDictionary*newDict=[[NSMutableDictionary alloc]initWithDictionary:selectConditionDict];
    [selectConditionDict removeAllObjects];
    for (NSString*tempkey in newDict.allKeys) {
        addIndex++;
        NSString*selectValue=[newDict valueForKey:tempkey];
        CGFloat selectValueMarginLeft=0;
        CGFloat selectValueWidth=selectValue.length*16.0+8.0;
        selectValueForAddWidth+=selectValueWidth+(addIndex-1)*marginLeft;
        if(selectValueForAddWidth>scrollViewWidth)
        {
            selectValueMarginLeft=10.0;
            selectValueForAddWidth=selectValueWidth;
            addRow++;
        }
        else
        {
            selectValueMarginLeft=selectValueForAddWidth-selectValueWidth+marginLeft;
        }
        if(addRow>1)
        {
            marginTop=addRow*5.0+(addRow-1)*selectValueHeight;
        }
        else
        {
            marginTop=5.0;
        }
        selectValueForAddWidth-=(addIndex-1)*marginLeft;
        selectValueAddWidth=selectValueForAddWidth;
        UIButton*addBtn=[[UIButton alloc]initWithFrame:CGRectMake(selectValueMarginLeft, marginTop, selectValueWidth, selectValueHeight)];
        [addBtn setBackgroundColor:[colorArray objectAtIndex:(addIndex-1)%10]];
        [addBtn setTitle:selectValue forState:UIControlStateNormal];
        [addBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        addBtn.tag=addIndex-1;
        [selectConditionDict setObject:selectValue forKey:[NSString stringWithFormat:@"%d",addIndex-1]];
        [addBtn addTarget:self action:@selector(deleteSubview:) forControlEvents:UIControlEventTouchUpInside];
        UIImage*xImg=[UIImage imageNamed:@"X.png"];
        UIImageView*xImgView=[[UIImageView alloc]initWithImage:xImg];
        [xImgView setFrame:CGRectMake(selectValueWidth-8, 0, 8, 8)];
        [addBtn addSubview:xImgView];
        [self.btnScrollView addSubview:addBtn];
    }
    if(addRow*5.0+(addRow+1)*selectValueHeight>scrollViewHeight)
    {
        self.btnScrollView.contentSize=CGSizeMake(scrollViewWidth+marginLeft*2, addRow*5.0+(addRow+1)*selectValueHeight);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
