//
//  CurrencyMainPageVM.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation

protocol CurrencyMainPageInputs {
    var refreshDataTrigger : Box<()>{get}
    var replaceCurrentCurrency : Box<String>{get}
    var addNumberToPad : Box<String>{get}
    var timeCheckTrigger : Box<()>{get}
}

protocol CurrencyMainPageOutpus {
    var loadingHudDisplay : Box<(String,String)>{get}
    var currentSelectCurrency : Box<String>{get}
    var amount : Box<String>{get}
    var currencyList : Box<[CurrencyNameModel]>{get}
    var rateList : Box<[RateModel]>{get}
    var alertMessage : Box<String>{get}
    var refreshTime : Box<String>{get}
}

protocol CurrencyMainPageFunctions {
    var inputs: CurrencyMainPageInputs{get}
    var outputs : CurrencyMainPageOutpus{get}
}

class CurrencyMainPageVM : CurrencyMainPageFunctions , CurrencyMainPageInputs , CurrencyMainPageOutpus{

    var inputs: CurrencyMainPageInputs{return self}

    var outputs: CurrencyMainPageOutpus{return self}


    //inputs
    var refreshDataTrigger: Box<()> = Box(())
    var replaceCurrentCurrency : Box<String> = Box("")
    var addNumberToPad : Box<String> = Box("")
    var timeCheckTrigger : Box<()> = Box(())

    //outputs
    var loadingHudDisplay: Box<(String, String)> = Box(nil)
    var currentSelectCurrency : Box<String> = Box("USD")
    var amount : Box<String> = Box("")
    var currencyList : Box<[CurrencyNameModel]> =  Box([])
    var rateList : Box<[RateModel]> = Box([])
    var alertMessage : Box<String> = Box("")
    var refreshTime : Box<String> = Box("")

    init(taskManager : currencyMainInjectProtocol) {

        inOutBinding(taskManager: taskManager)
    }

    //MARK: binding inputs and outputs
    final private func inOutBinding(taskManager : currencyMainInjectProtocol){

        //check time Binder
        timeCheckTrigger.binding(trigger: false) { [unowned self] _ in
            //1 loading activity
            self.loadingHudDisplay.value = ("loading...","Loading Currency Datas")
            let saveTime =  UserDefaults.standard.value(forKey: EnvironmentSetting.RefreshTimeKey) as? TimeInterval ?? 0
            let now = Date().timeIntervalSince1970
            let saveTimeInterval = TimeInterval(exactly: saveTime) ?? 0
            if TimeCompareHelper.compareTimeIsExceed(startTime: saveTimeInterval, endTime: now, limitMinutes: EnvironmentSetting.RefreshTime){
                //over 30 minitues , load api
                self.refreshDataTrigger.value = ()
            }else{
                let filePath = FileHelper.getFilePathForName(EnvironmentSetting.localCurrencyFileName)
                let (localData , _ ) =   self.readJSONFile(filePath: filePath)
                self.currencyList.value = localData?.listArray
                self.rateList.value = localData?.rateArray
                self.loadingHudDisplay.value = nil
            }
        }

        refreshDataTrigger.binding(trigger: false) {[unowned self] trigger in
            let group = DispatchGroup()
            group.enter()
            taskManager.fetchCurrencyList { result in
                switch result{
                case .success(let model):
                    self.currencyList.value = model
                case .failure(let error):
                    self.alertMessage.value = error.localizedDescription
                }
                group.leave()
            }

            group.enter()
            taskManager.fetchCurrencyData { result in
                switch result{
                case .success(let model):
                    self.rateList.value = model
                case .failure(let error):
                    self.alertMessage.value = error.localizedDescription
                }
                group.leave()
            }

            group.notify(queue: .main) {
                self.loadingHudDisplay.value = nil
                let localData = LocalStoreCurrency(rateArray: self.rateList.value ?? [], listArray: self.currencyList.value ?? [])
                //write file to document

                let filePath = FileHelper.getFilePathForName(EnvironmentSetting.localCurrencyFileName)

                self.writeJSONFileToDocument(localData: localData , filePath: filePath)
                //set Time
                UserDefaults.standard.setValue(Date().timeIntervalSince1970, forKey: EnvironmentSetting.RefreshTimeKey)

                let now = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                self.refreshTime.value =  dateFormatter.string(from: now)
            }
        }

        replaceCurrentCurrency.binding(trigger: false) { [unowned self]  cur in
            self.currentSelectCurrency.value = cur
        }

        addNumberToPad.binding(trigger: false) { [unowned self]  amount in

            guard let amount = amount  else { return }
            let oldNumber = self.amount.value ?? ""
            let newNumber = self.addingAmountNumber(oldNum: oldNumber, newNumb: amount )
            self.amount.value = newNumber
        }
    }
}

//MARK: file process with JSON txt
extension CurrencyMainPageVM{
    @discardableResult final func writeJSONFileToDocument(localData : LocalStoreCurrency , filePath : String) -> (Bool,Error?){

        //write file
        do {
            let data = try JSONEncoder().encode(localData)
            try data.write(to: URL(fileURLWithPath: filePath), options: .atomic)
        }
        catch {
            return (false , error)
        }
        return (true , nil)
    }

    @discardableResult final func readJSONFile(filePath : String) -> (LocalStoreCurrency?,Error?){
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath, isDirectory: false))
            let decoder = JSONDecoder()
            let localData = try decoder.decode(LocalStoreCurrency.self, from: data)
            return (localData,nil)
        }
        catch {
            return (nil , error)
        }

    }
}

//MARK: amount Display
extension CurrencyMainPageVM{


    final func addingAmountNumber(oldNum : String , newNumb : String)->String{
        guard newNumb.isEmpty == false else {
            return oldNum
        }

        if newNumb == "." && oldNum.contains(".") {
            return oldNum
        }else if newNumb == "C" || newNumb == "X"{
            return ""
        }else if newNumb == "Del"{
            guard oldNum.count > 0 else {
                return oldNum
            }
            return String(oldNum.prefix(oldNum.count-1))
        }

        if oldNum.count > 12 {
            return oldNum
        }

        return oldNum + newNumb
    }
}
