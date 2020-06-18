//
//  CurrencyManPageAcceptanceTests.swift
//  CurrencyExToolAcceptanceTest
//
//  Created by i9400503 on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import XCTest
@testable import CurrencyExTool
class CurrencyManPageAcceptanceTests: XCTestCase {

    private(set) var mainPageMAnager: CurrencyMainManager!
    private(set) var viewModel: CurrencyMainPageVM!

    override func setUp() {
        mainPageMAnager = CurrencyMainManager()
        viewModel = CurrencyMainPageVM(taskManager: mainPageMAnager)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_fetchTheRealAPI(){
          let exp = expectation(description: "fetch real api , It should be a lot of datas")
          viewModel.outputs.currencyList.binding(trigger: false) { list in
              guard let list = list , list.count > 0 else{
                  return
              }
              exp.fulfill()
          }

          viewModel.inputs.refreshDataTrigger.value = ()


          wait(for: [exp], timeout: 5)
      }

}
