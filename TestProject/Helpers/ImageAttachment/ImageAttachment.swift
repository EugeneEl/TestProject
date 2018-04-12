//
//  ImageAttachment.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 08.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

/**
 ImageAttachment used to incapsulate either image or url.
 */
enum ImageAttachment {
    case image(UIImage)
    case imageURL(URL)
    
    /**
     used to retrieve url. If no url assertion failure is being executed.
     */
    func getURL() -> URL {
        switch self {
        case .imageURL(let url):
            return url
        default:
            assertionFailure("wrong value for image")
            
            return URL(string: "")!
        }
    }
    /**
     used to retrieve url. If no image assertion failure is being executed.
     */
    func getImage() -> UIImage {
        switch self {
        case .image(let image):
            return image
        default:
            assertionFailure("wrong value for image")
            
            return UIImage()
        }
    }
    
    static func convertStringsToAttachmentURL(_ stringURLs: [String]) -> [ImageAttachment] {
        var attachments = [ImageAttachment]()
        
        for stringURL in stringURLs {
            if let url = URL(string: stringURL) {
                let urlAttachment = ImageAttachment.imageURL(url)
                attachments.append(urlAttachment)
            }
        }
        
        return attachments
    }
}
