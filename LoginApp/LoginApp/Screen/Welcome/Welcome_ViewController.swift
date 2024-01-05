//
//  Welcome_ViewController.swift
//  LoginApp
//
//  Created by Nguyễn Văn Hữu on 16/12/2023.
//

import UIKit

class Welcome_ViewController: UIViewController {

    @IBOutlet weak var lbl_Welcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_Welcome.frame.origin.x = 0 - lbl_Welcome.frame.size.width
        
        UIView.animate(withDuration: 3, animations: {
            self.lbl_Welcome.frame.origin = CGPoint(
                x: self.view.frame.size.width/2 - self.lbl_Welcome.frame.size.width/2,
                y: self.view.frame.size.height/2 - self.lbl_Welcome.frame.size.height/2
            )
        }, completion: nil)      
        self.navigationController?.popViewController(animated: true)
    }
}
