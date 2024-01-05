//
//  Register_ViewController.swift
//  LoginApp
//
//  Created by Nguyễn Văn Hữu on 10/12/2023.
//

import UIKit

class Register_ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet weak var imgAvatar: UIImageView!
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
  
    @IBOutlet weak var txtLastName: UITextField!

    
    @IBOutlet weak var mySpinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySpinner.isHidden = true
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func choosePhotoFromGallery(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage {
            imgAvatar.image = image
        }else {
            // file chosen is not image
        }
        self.dismiss(animated: true, completion: nil)
    }
    func UserRegister() {
        
        
        var url = URL(string: Config.ServerURL + "/uploadFile")
        let boundary = UUID().uuidString
        let session = URLSession.shared
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"avatar\"; filename=\"avatar.png\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append((imgAvatar.image?.pngData())!)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            if error == nil {
                let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)
                if let json  = jsonData as? [String: Any]{
                    
                    print(json)
                    if(json["result"] as! Int == 1){
                        let urlFile = json["info"] as? [String:Any]
                        print(urlFile!["filename"]!)
                        
                        
                        //send user infomation
                        DispatchQueue.main.async {
                            
                            url = URL(string: Config.ServerURL +  "/register")
                            var request = URLRequest(url: url!)
                            request.httpMethod = "POST"
                            
                            let fileName = urlFile!["filename"] as! String
                            
                            var sData = "Email=" + self.txtUsername.text!
                            sData += "&Password=" + self.txtPassword.text!
                            sData += "&Name=" +  self.txtLastName.text! + self.txtFirstName.text!
                            sData += "&Avatar=" + fileName
                            
                            
                            let postData = sData.data(using: .utf8)
                            request.httpBody = postData
                            
                            let taskUserRegister = URLSession.shared.dataTask(with: request, completionHandler: { data , response, error in
                                guard error == nil else { print("error"); return }
                                guard let data = data else { return }
                                
                                do{
                                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
            
                                    if( json["result"] as! Int == 1 ){
                                        DispatchQueue.main.async {
                                            let alertView = UIAlertController(title: "Thong bao", message: (json["message"] as! String), preferredStyle: .alert)
                                            alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler:{(action:UIAlertAction!) in
                                                                                
                                                self.navigationController?.popViewController(animated: true)
                                            }))
                                            self.present(alertView, animated: true, completion: nil)
                                        }
                                        
                                    }else{
                                        DispatchQueue.main.async {
                                            let alertView = UIAlertController(title: "Thong bao", message: (json["message"] as! String), preferredStyle: .alert)
                                            alertView.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                                            self.present(alertView, animated: true, completion: nil)
                                            
                                            self.txtUsername.text = ""
                                            self.txtPassword.text = ""
                                            self.txtFirstName.text = ""
                                            self.txtLastName.text = ""
                                            self.mySpinner.isHidden = true
                                            
                                        }
                                        
                                    }
                                    
                                }catch let error { print(error.localizedDescription) }
                            })
                            taskUserRegister.resume()
                        }
                        
                     }else{
                        print("Upload failed!")
                    }
                }
            }
        }).resume()
    }
       
    @IBAction func uploadPhotoToServer(_ sender: Any) {
        
        mySpinner.isHidden = false
        mySpinner.startAnimating()
        
        
        UserRegister()
    }
}
