//
//  FileManager+JJ.swift
//  PANewToapAPP
//
//  Created by cmh on 16/10/11.
//  Copyright © 2016年 PingAn. All rights reserved.
//

import UIKit
import Foundation

extension FileManager {
    
    // File exist
    public static func jjs_isFileExistAtPath(fileFullPath: String, isDir: Bool) -> Bool
    {
        var tempIsDir = ObjCBool(isDir)
        return FileManager.default.fileExists(atPath: fileFullPath, isDirectory: &tempIsDir)
    }
    
    public static func jjs_isFileExistAtPath(fileFullPath: String) -> Bool
    {
        return FileManager.default.fileExists(atPath: fileFullPath)
    }
    
    //File Path
    public static func jjs_URLForDirectory(directory: SearchPathDirectory) -> URL?
    {
        return self.default.urls(for: directory, in: .userDomainMask).last
    }
    
    public static func jjs_pathForDirectory(directory: SearchPathDirectory) -> String
    {
        let strArray: [String] = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)
        
        assert(strArray.count > 0)

        return strArray.count > 0 ? strArray[0] : "Can't find directory"
    }
    
    public static func jjs_documentsDirector() -> String
    {
        return self.jjs_pathForDirectory(directory: .documentDirectory)
    }
    
    public static func jjs_libraryDirectory() -> String
    {
        return self.jjs_pathForDirectory(directory: .libraryDirectory)
    }
    
    public static func jjs_cachesDirectory() -> String
    {
        return self.jjs_pathForDirectory(directory: .cachesDirectory)
    }
    
    public static func jjs_tempDirectory() -> String
    {
        return NSTemporaryDirectory()
    }
    
    public static func jjs_createDirectoryAtPath(path: String) -> Bool
    {
        if self.jjs_isFileExistAtPath(fileFullPath: path)
        {
            return true
        }
        
        var success: Bool
        do {
            try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            success = true
        } catch let error as NSError {
            success = false
            assert(false, "Create directory failed, path: \(path), error: \(error.localizedDescription)")
        }

        return success
    }
    
    public static func jjs_filePathWithFileName(fileName: String) -> String?
    {
        let tempStr = fileName as NSString
        var resource = fileName as NSString
        var type: NSString = ""
        let range = tempStr.range(of: ".", options: NSString.CompareOptions.backwards)
        if range.location != NSNotFound
        {
            resource = tempStr.substring(to: range.location) as NSString
            type = tempStr.substring(from: (range.location + range.length)) as NSString
        }
        
        return Bundle.main.path(forResource: resource as String, ofType: type as String)
    }
    
    // get file list
    public static func jjs_getFileNameOrPathList(needFullPath: Bool, dirPath: String, needCheckSubDirectory: Bool, fileNameCompare:(_ fileName: String) -> Bool) -> [Any]
    {
        var fileList: [Any]? = Array()
        var tmpList: [String] = Array()
        do
        {
            tmpList = try FileManager.default.contentsOfDirectory(atPath: dirPath)
        }
        catch let error as NSError
        {
            assert(false, "error\(error.localizedDescription)")
        }
        
        for fileName: String in tmpList
        {
            let fullPath = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName).path
            let isDir = Bool()
            let fileExist = self.jjs_isFileExistAtPath(fileFullPath: fullPath, isDir: isDir)
            if fileExist == false
            {
                continue
            }
            
            if fileExist == true && needCheckSubDirectory == true
            {
                let subFileList = self.jjs_getFileNameOrPathList(needFullPath: needFullPath, dirPath: fullPath, needCheckSubDirectory: needCheckSubDirectory, fileNameCompare: fileNameCompare)
                
                if subFileList.count > 0
                {
                    fileList?.append(subFileList)
                }
                continue
            }
            
            if fileNameCompare(fileName) == false
            {
                continue
            }
            
            if needFullPath == true
            {
                fileList?.append(fullPath)
            }
            else
            {
                fileList?.append(fileName)
            }
        }
        
        return fileList!
    }
    
    // 通过全路径下的文件类型，返回此类型下的所有文件目录
    public static func jjs_getFileListOfType(type: String, needFullPath: Bool, dirPath: String) -> [Any]
    {
        return self.jjs_getFileNameOrPathList(needFullPath: needFullPath, dirPath: dirPath, needCheckSubDirectory: false) { (fileName) -> Bool in
            let str = URL(fileURLWithPath: fileName).pathExtension
            return str == type
        }        
    }
    
    // 通过全路径下的文件类型，返回此类型下的所有文件目录
    public static func jjs_getFileNameListOfType(type: String, dirPath: String) -> [Any]
    {
        return self.jjs_getFileListOfType(type: type, needFullPath: false, dirPath: dirPath)
    }
    
    // 通过全路径下的文件类型，返回此类型下的所有文件目录
    public static func jjs_getFilePathListOfType(type: String, dirPath: String) -> [Any]
    {
        return self.jjs_getFileListOfType(type: type, needFullPath: true, dirPath: dirPath)
    }
    
    // 通过全路径中的文件前缀，返回包含文件前缀的所有文件目录
    public static func jjs_getFileListOfPrefixName(prefixName: String, needFullPath: Bool, dirPath: String) -> [Any]
    {
        return self.jjs_getFileNameOrPathList(needFullPath: needFullPath, dirPath: dirPath, needCheckSubDirectory: false, fileNameCompare: { (fileName) -> Bool in
            return fileName.hasPrefix(prefixName)
        })
    }
    
    // 通过文件前缀，在不全的路径下，返回该路径下包含此前缀的文件名，并且在文件名前加上这个前缀
    public static func jjs_getFileNameListOfPrefixName(prefixName: String, dirPath: String) -> [Any]
    {
        return self.jjs_getFileListOfPrefixName(prefixName: prefixName, needFullPath: false, dirPath: dirPath)
    }
    
    // 通过全路径中的文件前缀，返回包含文件前缀的所有文件目录
    public static func jjs_getFilePathListOfPrefixName(prefixName: String, dirPath: String) -> [Any]
    {
        return self.jjs_getFileListOfPrefixName(prefixName: prefixName, needFullPath: true, dirPath: dirPath)
    }
    
    // 删除失效的文件
    public static func jjs_removeExpiredCache(filePathList: [Any], secondOfExpiredTime: NSInteger)
    {
        for obj: Any in filePathList
        {
            var fileAttributes: [FileAttributeKey : Any] = Dictionary()
            do
            {
                fileAttributes = try FileManager.default.attributesOfItem(atPath: obj as! String)
            }
            catch let error as NSError
            {
                assert(false, "error\(error.localizedDescription)")
            }
            let fileModifyDate = fileAttributes[FileAttributeKey.modificationDate] as! Date
            let timeInterval = Date().timeIntervalSince(fileModifyDate)
            if fabs(timeInterval) > Double(secondOfExpiredTime)
            {
                do
                {
                   try FileManager.default.removeItem(atPath: obj as! String)
                }
                catch let error as NSError
                {
                    assert(false, "error\(error.localizedDescription)")
                }
            }
        }
    }
    
    // 删除该目录下包含此prefixName的失效文件
    public static func jjs_removeExpiredCache(prefixName: String, dirPath: String, secondOfExpiredTime: NSInteger)
    {
        let filePathList = self.jjs_getFilePathListOfPrefixName(prefixName: prefixName, dirPath: dirPath)
        self.jjs_removeExpiredCache(filePathList: filePathList, secondOfExpiredTime: secondOfExpiredTime)
    }
    
    // 删除该目录下包含此type的失效文件
    public static func jjs_removeExpiredCacheWithTyp(type: String, dirPath: String, secondOfExpiredTime: NSInteger)
    {
        let filePathList = self.jjs_getFilePathListOfType(type: type, dirPath: dirPath)
        self.jjs_removeExpiredCache(filePathList: filePathList, secondOfExpiredTime: secondOfExpiredTime)
    }
    
    public static func jjs_fileSizeDictionaryFromDirPath(dirPath: String, needCheckSubDirectory: Bool) -> [CLong: Any]
    {
        let dirURL = URL(fileURLWithPath: dirPath, isDirectory: true)
        let dirEnumerator = FileManager().enumerator(at: dirURL, includingPropertiesForKeys:[URLResourceKey.pathKey, URLResourceKey.isDirectoryKey, URLResourceKey.fileSizeKey] , options: DirectoryEnumerationOptions.skipsHiddenFiles) { (_, _) -> Bool in
            return true
        }
        var fileSizeDic: [CLong: Any] = Dictionary()
        for theURL: NSURL in dirEnumerator?.allObjects as! [NSURL]
        {
            var filePath: AnyObject?
            do
            {
                try theURL.getResourceValue(&filePath, forKey: .pathKey)
            }
            catch
            {}
            var isDir: AnyObject?
            do
            {
                
                try theURL.getResourceValue(&isDir, forKey: URLResourceKey.isDirectoryKey)
            }
            catch
            {}
            if (isDir != nil) && !(isDir?.boolValue)!
            {
                var fileSizeNumber: AnyObject?
                do
                {
                   try theURL.getResourceValue(&fileSizeNumber, forKey: URLResourceKey.fileSizeKey)
                }
                catch
                {}
                if fileSizeNumber != nil
                {
                    let tempSize = fileSizeNumber as! CLong
                    fileSizeDic[tempSize] = filePath as! String
                }
            }
            else
            {
                if needCheckSubDirectory == true
                {
                    let subFileSizeDic = FileManager.jjs_fileSizeDictionaryFromDirPath(dirPath: filePath as! String, needCheckSubDirectory: needCheckSubDirectory)
                    fileSizeDic = fileSizeDic.jjs_dictionaryByMergingWith(dict1: subFileSizeDic)! as! [CLong : Any]
                }
            }
        }
        return fileSizeDic
    }
    
    // 将DirPath里面所有的文件所占的字节数及文件路径，写入到FilePath的只写文件中
    public static func jjs_printAllFileSizeToFilePath(filePath: String, fromDirPathArray: [Any]) -> Void
    {
        let file = fopen(filePath.cString(using: String.Encoding.utf8),"w".cString(using: String.Encoding.utf8))
        if ((file?.pointee) == nil)
        {
            assert(false, "Failed to open file: \(filePath)")
            return
        }
        let startDate = Date()
        var allFileSizeDic: [CLong: Any] = Dictionary()
        for obj: Any in fromDirPathArray
        {
            let fileSizeDic = FileManager.jjs_fileSizeDictionaryFromDirPath(dirPath: obj as! String, needCheckSubDirectory: true)
            allFileSizeDic = allFileSizeDic.jjs_dictionaryByMergingWith(dict1: fileSizeDic)! as! [CLong : Any]
        }
        
        var totalSize: CLong = 0
        var directorySizeDic: [String: CLong] = Dictionary()
        let sortKeys = Array(allFileSizeDic.keys).sorted { (s1: CLong, s2 : CLong) -> Bool in
            return String(describing: s1) > String(describing: s2)
        }
        for sizeNumber: CLong in sortKeys
        {
            let filePath: String = allFileSizeDic[sizeNumber] as! String
            vfprintf(file, "%ld\t\t\(filePath)\n", getVaList([sizeNumber as CVarArg]))
            let url = URL.init(fileURLWithPath: filePath)
            let directory = "\(url.deletingLastPathComponent())"
            var directorySizeNumber = directorySizeDic[directory]
            if directorySizeNumber == nil
            {
                directorySizeNumber = 0
                directorySizeDic[directory] = 0
            }
            let fileSize = sizeNumber
            totalSize += fileSize
            directorySizeDic[directory] = directorySizeNumber! + fileSize
        }
        
        vfprintf(file, "\n\n", getVaList([]))
        let directoryNewDic = directorySizeDic.jjs_exchangeKeyAndValue() as! [CLong : Any]
        let directorySortKeys = Array(directoryNewDic.keys).sorted { (s1: CLong, s2 : CLong) -> Bool in
            return String(describing: s1) > String(describing: s2)
        }
        for sizeNumber: CLong in directorySortKeys
        {
            let filePath = directoryNewDic[sizeNumber] as! String
            vfprintf(file, "%ld\t\t\(filePath)\n", getVaList([sizeNumber as CVarArg]))
        }
        
        vfprintf(file, "\n\n", getVaList([]))
        vfprintf(file, "------- total size is %ld -------\n", getVaList([totalSize as CVarArg]))
        vfprintf(file, "\n\n", getVaList([]))
        let endDate = Date()
        let totalTime = endDate.timeIntervalSince(startDate)
        if totalTime > 0
        {
            vfprintf(file, "total time on listing all file size is %f", getVaList([totalTime as CVarArg]))
        }
        fclose(file)
    }
    
}
