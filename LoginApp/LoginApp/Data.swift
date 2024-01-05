//
//  Data.swift
//  LoginApp
//
//  Created by Nguyễn Văn Hữu on 17/12/2023.
//

import Foundation

struct DataInfo:Decodable{
    var result:Int
    var message:String
}

struct LoginInfo:Decodable{
    var result:Int
    var message:String
    var token:String
}

struct VerifyInfo:Decodable{
    var result:Int
    var message:String
    var _id:String
    var email:String
}

struct RegisterInfo:Decodable{
    
}
