//
//  ProjectListInteractor.swift
//  CleanSwift(VIP)
//
//  Created by Steve JobsOne on 4/18/20.
//  Copyright (c) 2020 Steve JobsOne. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ProjectListBusinessLogicDelegate {
  func doSomething(request: ProjectList.Something.Request)
}

protocol ProjectListDataStoreDelegate {
  var name: String! { get set }
}

class ProjectListInteractor: ProjectListBusinessLogicDelegate, ProjectListDataStoreDelegate {
    var name: String!
    
  var presenterDelegate: ProjectListPresentationLogicDelegate?
  var worker: ProjectListWorker?
 
  
  // MARK: Do something
  
  func doSomething(request: ProjectList.Something.Request) {
    worker = ProjectListWorker()
    worker?.doSomeWork()
    
    let response = ProjectList.Something.Response()
    presenterDelegate?.presentSomething(response: response)
  }
}