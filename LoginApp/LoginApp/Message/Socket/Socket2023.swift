//
//  Socket2023.swift
//  LoginApp
//
//  Created by Nguyễn Văn Hữu on 24/12/2023.
//

import Foundation
import SocketIO

class Socket2023: NSObject{
    
    static let sharedInstane = Socket2023()
    
    let socket = SocketManager(socketURL: URL(string: Config.ServerURL)!,
                               config: [.log(true),
                                        .compress])
    
    var mSocket:SocketIOClient!
    
    override init() {
        super.init()
        mSocket = socket.defaultSocket
    }
    
    func getSocket()->SocketIOClient{
        return mSocket
    }
    func establishConnection(){
        mSocket.connect()
    }
    func closeConnection(){
        mSocket.disconnect()
    }
}
