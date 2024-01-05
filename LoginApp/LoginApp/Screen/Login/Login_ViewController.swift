//
//  Login_ViewController.swift
//  LoginApp
//
//  Created by Nguyễn Văn Hữu on 17/12/2023.
//

import UIKit

class Login_ViewController: UIViewController {

    
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func Login(_ sender: Any) {
        
        UserLogin()
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let dashboardVC = sb.instantiateViewController(identifier: "DASHBOARD") as! Dashboard_ViewController
        self.navigationController?.pushViewController(dashboardVC, animated: true)
    }
    
    @IBAction func Register(_ sender: Any) {
        
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let register_VC = sb.instantiateViewController(identifier: "REGISTER") as! Register_ViewController
        self.navigationController?.pushViewController(register_VC, animated: true)
        
    }
    
   
    func UserLogin() {
        
        let url = URL(string: "http://localhost:3000/login")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        let email:String = txtUsername.text!
        let password:String = txtPassword.text!
        
        let postData = ("Email="+email+"&Password="+password).data(using: .utf8)
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
            let loginData = try? jsonDecoder.decode(LoginInfo.self, from: data)
            DispatchQueue.main.async {
                
                self.txtUsername.text = ""
                self.txtPassword.text = ""
                
                if loginData?.result == 1 {
                    //save token
                    self.defaults.set(loginData?.token, forKey: "TOKEN")
                    
          
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Thong bao", message: "Login successfully", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler:{(action:UIAlertAction!) in
                                                            
                            
                        }))
                        self.present(alertView, animated: true, completion: nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        let alertView = UIAlertController(title: "Thong bao", message: "Please log in again", preferredStyle: .alert)
                        alertView.addAction(UIAlertAction(title: "Okey", style: .default))
                        self.present(alertView, animated: true, completion: nil)
                    }
                }
            }
            
        }.resume()
        
    }
    
}
