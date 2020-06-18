//
//  CurrencyManPageTests.swift
//  CurrencyExToolTests
//
//  Created by i9400503 on 2020/6/18.
//  Copyright © 2020 Shine. All rights reserved.
//

import XCTest
@testable import CurrencyExTool
class CurrencyManPageTests: XCTestCase {

    class EmptyTaskManager: currencyMainInjectProtocol {
        func fetchCurrencyList(complete completeHandler: @escaping (Result<[CurrencyNameModel], CurrenyFetchError>) -> ()) {
            DispatchQueue.main.async {
                completeHandler(.success([]))
            }
        }

        func fetchCurrencyData(complete completeHandler: @escaping (Result<[RateModel], CurrenyFetchError>) -> ()) {
            DispatchQueue.main.async {
                completeHandler(.success([RateModel(sourceCUR: "USD", convertToCUR: "TWD", rate: 29.6)]))
            }
        }
    }

    private(set) var emptyManager: EmptyTaskManager!
    private(set) var viewModel: CurrencyMainPageVM!

    override func setUp() {
        emptyManager = EmptyTaskManager()
        viewModel = CurrencyMainPageVM(taskManager: emptyManager)
    }

    func test_triggerInitTableDataList(){
        let exp = expectation(description: "the data will be all empty")
        viewModel.outputs.currencyList.binding(trigger: false) { list in
            guard let list = list , list.count == 0 else{
                return
            }
            exp.fulfill()
        }

        viewModel.inputs.refreshDataTrigger.value = ()


        wait(for: [exp], timeout: 0.5)
    }

    func test_RateListFetch(){
        let exp = expectation(description: "RateList assert failed")

        viewModel.outputs.rateList.binding(trigger: false) { list in
            guard let list = list , list.count > 0 else{
                DispatchQueue.main.async {
                    XCTFail("list Should not empty")
                    exp.fulfill()
                }
                return
            }

            let model = list.first!
            DispatchQueue.main.async {
                XCTAssertEqual(model.convertToCUR, "TWD")
                XCTAssertEqual(model.sourceCUR, "USD")
                    exp.fulfill()
            }


        }
        viewModel.inputs.refreshDataTrigger.value = ()
        wait(for: [exp], timeout: 0.5)
    }
}
