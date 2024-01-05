//
//  Dashboard_ViewController.swift
//  LoginApp
//
//  Created by Nguyễn Văn Hữu on 17/12/2023.
//

import UIKit

class Dashboard_ViewController: UIViewController {

    
    
    @IBOutlet weak var lbl_Information: UILabel!
    
    @IBOutlet weak var img_Avatar: UIImageView!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img_Avatar.layer.cornerRadius = img_Avatar.frame.size.width/2
        CheckAuth()
        
        
    }
    

    @IBAction func Logout(_ sender: Any) {
        if let tokenString = defaults.string(forKey: "TOKEN"){
            VeryfyToken(Token: tokenString)
            UserLogout(Token: tokenString)
        }else{
            self.defaults.removeObject(forKey: "TOKEN")
            self.navigationController?.popViewController(animated: true)
        }
         let actionAlert = UIAlertController(title: "",
                                             message: "",
                                             preferredStyle: .actionSheet)
            actionAlert.addAction(UIAlertAction(title: "Log out",
                                            style: .destructive,
                                            handler: {  [weak self] _ in
            guard self != nil else{
                
                return
            }
                    
        }))
        actionAlert.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        present(actionAlert, animated: true)
        
        
    }
    
    func VeryfyToken(Token:String){
        let url = URL(string: "http://localhost:3000/verify")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        
        let postData = ("Token="+Token).data(using: .utf8)
        request.httpBody = postData
        
        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let _ = response as? HTTPURLResponse,
                  error == nil else{
                print("error", error ?? "Undefined error")
                return
            }
            print(data)
            
            let jsonDecoder = JSONDecoder()
            let loginData = try? jsonDecoder.decode(VerifyInfo.self, from: data)
            DispatchQueue.main.async {
                if loginData?.result == 1 {
                    self.lbl_Information.text = loginData?.email
                }else{
                    self.dismiss(animated: true)
                }
            }
            
        }.resume()
    }
    
    func UserLogout(Token:String){
        let url = URL(string: "http://localhost:3000/logout")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        
        let postData = ("Token="+Token).data(using: .utf8)
        request.httpBody = postData
        
        let _ = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let _ = response as? HTTPURLResponse,
                  error == nil else{
                print("error", error ?? "Undefined error")
                return
            }
            print(data)
            
            let jsonDecoder = JSONDecoder()
            _ = try? jsonDecoder.decode(DataInfo.self, from: data)
            DispatchQueue.main.async {
                
                self.defaults.removeObject(forKey: "TOKEN")
                self.navigationController?.popViewController(animated: true)
            }
            
        }.resume()
    }
    
    func CheckAuth(){
        var logined = false
        if let tokenString = defaults.string(forKey: "TOKEN"){
            VeryfyToken(Token: tokenString)
        }else{
            logined = false
        }
        if (logined==false){
            //self.dismiss(animated: true)
        }
        
    }
    
}
