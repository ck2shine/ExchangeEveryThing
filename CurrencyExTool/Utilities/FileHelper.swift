//
//  FileHelper.swift
//  CurrencyExTool
//
//  Copyright © 2020 Shine. All rights reserved.
//

import Foundation
class FileHelper{

    @discardableResult static func deleteFileAtPath(_ filePath : String ) -> Error? {
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath){
            do {
                try  fileManager.removeItem(atPath: filePath)
            } catch let error as NSError{
                return error
            }

        }
        return nil
    }

    //MARK: document
    static func getDocumentFolder() -> URL {
        let fileManager = FileManager.default
        return  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    static func getFilePathForName(_ fileName : String) -> String{
        return getDocumentFolder().appendingPathComponent(fileName).path
    }

    //MARK: create folder
    @discardableResult static func checkFolderExsit(_ folderName : String , isCreate : Bool) -> Bool{
        let fileManager = FileManager.default

        let pathURL = getFilePathForName(folderName)

        let filePathExsit = fileManager.fileExists(atPath: pathURL)

        if isCreate == false{
            return filePathExsit
        }else{
            do
            {
                try fileManager.createDirectory(atPath:pathURL, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error as NSError
            {
                print("Unable to create directory \(error.debugDescription)")
            }
            return filePathExsit
        }

    }

    

}
