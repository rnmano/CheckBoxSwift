//
//  ViewController.swift
//  CheckBoxinSwift
//
//  Created by Manokaran on 16/06/15.
//  Copyright (c) 2015 Netiapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{

    var tableview : UITableView!
   
    var ItemArray : NSMutableArray! = NSMutableArray()
    var addArray : NSMutableArray! = NSMutableArray()
    override func viewDidLoad()
    {
        super.viewDidLoad()
//self.view.backgroundColor=UIColor.redColor()
        // Do any additional setup after loading the view.
        
        
        let path = NSBundle.mainBundle().pathForResource("TableData", ofType: "plist")
        
        ItemArray = NSMutableArray(contentsOfFile: path!)

        println(ItemArray)
        
        tableview=UITableView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height), style: .Plain)
        tableview.delegate=self
        tableview.dataSource=self
        self.view.addSubview(tableview)
        
        
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ItemArray.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
    {
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "myCell")
        
    
//        tableview.separatorStyle=UITableViewCellSeparatorStyle.SingleLineEtched
//        cell.selectionStyle = UITableViewCellSelectionStyle.Blue;
//        cell.accessoryType = UITableViewCellAccessoryType.None
        var item : NSDictionary!
        
        item=ItemArray.objectAtIndex(indexPath.row) as NSDictionary
        println(item)
        var val=item.valueForKey("text") as String
        
        cell.textLabel?.text = val
        if (cell.accessoryView == nil)
        {
             // Only configure the Checkbox control once.
            
            var checkbox : Checkbox = Checkbox(frame: CGRectMake(0, 0, 25, 43))
            checkbox.checked=item.valueForKey("checked") as Bool
            checkbox.addTarget(self, action: "checkboxclicked:event:", forControlEvents: UIControlEvents.ValueChanged)
            cell.accessoryView=checkbox
            cell.accessoryView?.opaque=false
           
           

        }
        return cell
    }
    func checkboxclicked(sender:AnyObject, event:AnyObject)
    {
        println("DEMO")
        
        var touches :NSSet
        touches=event.allTouches()!
        var touch :UITouch
        touch=touches.anyObject() as UITouch
        var currentTouchPosition :CGPoint
        currentTouchPosition=touch.locationInView(tableview)
        var indexPath :NSIndexPath!
        indexPath=tableview.indexPathForRowAtPoint(currentTouchPosition)
        //        println(indexPath)
        
        if (indexPath != nil)
        {
            var addItem:NSDictionary!
            
            addItem=ItemArray[indexPath.row] as NSDictionary
            
            var addtext : String
            
            addtext=addItem.valueForKey("text") as String
            
            var index : NSInteger
            
            index=addArray.indexOfObject(addtext)
            
//            NSInteger index=[arrayOfStrings indexOfObject:yourString];
            if(NSNotFound == index)
            {
               println("NOT FOUND")
                
                addArray.addObject(addtext)
                
            }
            else
            {
                println("FOUND")
                addArray.removeObject(addtext)

            }
            println(indexPath.row)
            
        }
        else
        {
            
        }
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
