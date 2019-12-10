//
//  ExampleServer.swift
//  Renetik_Example
//
//  Created by Rene Dohan on 2/19/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Renetik
import RenetikObjc

class ExampleServer {
    let client = CSAFClient(url: "https://renetik-library-server.herokuapp.com/api").also {
        $0.acceptable(contentTypes: ["text/html", "application/json"])
        $0.basicAuhentification(username: "username", password: "password")
    }

//    func loadSampleList(page: Int) -> CSResponse<ListData> {
//        return client.get("sampleList", data: ListData().construct("list", ListItemData.self),
//                          ["pageNumber": "\(page)"])
//    }
}
