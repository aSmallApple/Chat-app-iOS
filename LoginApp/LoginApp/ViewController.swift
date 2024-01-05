//
//  ViewController.swift
//  LoginApp
//
//  Created by Nguyễn Văn Hữu on 07/12/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "line")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.animation()
        }
    }
    func animation(){
        UIView.animate(withDuration: 1) {
            let size = self.view.frame.size.width * 3
            let xposition = size - self.view.frame.width
            let yposition = self.view.frame.height - size
            
            self.imageView.frame = CGRect(x: -(xposition/2), y: yposition/2, width: size, height: size)
            self.imageView.alpha = 0
        }
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                    self.performSegue(withIdentifier: "Segue", sender: self)
                    
                })
            }
         }
        )
    }
    
    
}
