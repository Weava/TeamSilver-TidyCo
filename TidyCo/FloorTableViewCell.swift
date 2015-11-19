//
//  FloorTableViewCell.swift
//  TidyCo
//
//  Created by KEETON AUSTIN R on 11/18/15.
//  Copyright © 2015 Team Silver. All rights reserved.
//
//  Some code retrieved from 
//  https://github.com/rcdilorenzo/Cell-Expander/blob/master/Cell%20Expander/PickerTableViewCell.swift

import UIKit

class FloorTableViewCell: UITableViewCell {

    @IBOutlet weak var floorName: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    var buttons = [UIButton]()
    
    var expandedHeight: CGFloat { get { return CGFloat(buttons.count % 5 * 44)} }
    var defaultHeight: CGFloat { get { return 44 } }
    var isObserving = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addButtons() {
        
        buttons = [button1, button2, button3, button4, button5]
    }
    
    func checkHeight() {
        for button in buttons {
            button.hidden = (frame.size.height < expandedHeight)
        }
    }
    
    func watchFrameChanges() {
        if !isObserving {
            addObserver(self, forKeyPath: "frame", options: [NSKeyValueObservingOptions.New, NSKeyValueObservingOptions.Initial], context: nil)
            isObserving = true
        }
    }
    
    func ignoreFrameChanges() {
        if isObserving {
            removeObserver(self, forKeyPath: "frame")
            isObserving = false;
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
}
