//
//  CurrencySelectVM.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

protocol CurrencyDataInputs {
    var tableDataTrigger : Box<Bool>{get}
}

protocol CurrencyDataOutpus {
    var dataList : Box<[CurrencyRowType]>{get}
    var infoText : Box<String>{get}
    var selectedCurrency : Box<String>{get}
}

protocol CurrencyDataFunctions {
    var inputs: CurrencyDataInputs{get}
    var outputs : CurrencyDataOutpus{get}
}

class CurrencyDataVM :CurrencyDataFunctions , CurrencyDataInputs , CurrencyDataOutpus{


    //input
    var tableDataTrigger: Box<Bool> = Box(false)

    //output
    var infoText: Box<String> = Box("")
    var selectedCurrency: Box<String> = Box("")
    var dataList : Box<[CurrencyRowType]> = Box([])

    var inputs: CurrencyDataInputs{return self}

    var outputs: CurrencyDataOutpus{return self}

    //store properties


    init(taskManager : currencyDataInjectProtocol){

        inOutBinding(taskManager: taskManager)
    }
}

extension CurrencyDataVM{
    //MARK: binding inputs and outputs
    final private func inOutBinding(taskManager : currencyDataInjectProtocol){

        tableDataTrigger.binding(trigger: false) {[unowned self] trigger in
            let rowViewModels = self.createRowViewModels(taskManager : taskManager ,
                                                         defaultCurrency: EnvironmentSetting.defaultCurrency)
            //reload table
            self.dataList.value = rowViewModels
            //change tittle
            if let model = rowViewModels.first {
                self.infoText.value = self.createTitleText(model: model, additionalString: taskManager.sendingData)
            }

        }
    }
}

extension CurrencyDataVM{


    //MARK: get the cell indentify
    final func cellIndentify(_ viewModel : CurrencyRowType)->String{
        switch viewModel {
        case is CurrencySelectVM:
            return String(describing: CurrencySelectCell.self)
        case is CurrencyRateVM:
            return String(describing: CurrencyRateCell.self)
        default:
            fatalError("undefined viewModel Type: \(viewModel)")
        }
    }
    
    //MARK: convert data to rowViewModel
    final func createRowViewModels(taskManager : currencyDataInjectProtocol,defaultCurrency : String) -> [CurrencyRowType]{

        var rowViewModels = [CurrencyRowType]()

        //whether the currency is USD or not
        var baseRate : Float?
        if let _ = taskManager.currencyListDatas.first as? RateModel ,
            taskManager.selectCurrency != defaultCurrency{

            let selectCurrencyModel = taskManager.currencyListDatas.filter {
                if let model = $0 as? RateModel, model.convertToCUR == taskManager.selectCurrency{
                    return true
                }
                return false
            }.first

            //fetch the base rate of other currency
            if let rate1stModel = selectCurrencyModel as? RateModel{
                baseRate = 1 / rate1stModel.rate
            }
        }

        taskManager.currencyListDatas.forEach {

            if let listModel = $0 as? CurrencyNameModel {
                let model = CurrencySelectVM(model: listModel)
                model.pressAction = {[sCur = selectedCurrency ] in
                    sCur.value = model.curShortName.value
                }
                rowViewModels.append(model)
            }
            else if var rateModel = $0 as? RateModel{

                //it means base rate is not USD
                if let baseRate = baseRate{
                    //refresh model Data
                    rateModel.sourceCUR = taskManager.selectCurrency
                    let exchangeRate = 1 / rateModel.rate
                    rateModel.rate = baseRate / exchangeRate
                }

                rowViewModels.append(CurrencyRateVM(model: rateModel, amount: taskManager.sendingData))
            }
        }

        return rowViewModels
    }


    //MARK: USD to Other currency
    /*
     if currency is not USD , change the rate from USD Table
     because free user is only able to fetch USD currency
     */
    final func tranferToOtherCurrencyFromUSD(){

    }
}

extension CurrencyDataVM{
    //MARK : create title
    final func createTitleText(model : CurrencyRowType , additionalString : String)->String{
        switch model {
        case is CurrencySelectVM:
            return "Currenct Currency : \(additionalString)"
        case is CurrencyRateVM :
            return "Amount : \(additionalString.moneyFormat())"
        default:
            return "Unknow RowType"
        }
    }

}
