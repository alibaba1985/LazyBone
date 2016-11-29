//
//  UploadFileUtils.swift
//  AIVeris
//
//  Created by Rocky on 16/8/31.
//  Copyright © 2016年 ___ASIAINFO___. All rights reserved.
//

import Foundation

protocol UploadFileUtils {
    func uploadImage(image: UIImage) -> String?
    func uploadFile(filePathUrl: NSURL) -> String?
}

class LeanCloudUploadFileUtils: UploadFileUtils {
    func uploadImage(image: UIImage) -> String? {
        let data = UIImageJPEGRepresentation(image, 0.1)
        
        let file = AVFile(data: data)
        file?.save()

        return file?.url
    }

    func uploadImage(image: UIImage, competion:@escaping (String?, NSError?) -> Void) {
        let data = UIImageJPEGRepresentation(image, 0.1)
        let file = AVFile(data: data)
        file?.saveInBackground({ (success, error) in



            //competion(file?.url, error?)
        })



    }

    func uploadFile(filePathUrl: NSURL) -> String? {
        guard let data = NSData(contentsOf: filePathUrl as URL) else {
            return nil
        }
        
        let file = AVFile(data: data as Data!)
        file?.save()
        
        return file?.url
    }
    
}
