//  EGS
//
//  Created by Eugene Goloboyar on 20.03.2018.
//

import Foundation

typealias SuccessImageDownloadCompletion = (_ image: UIImage) -> ()
typealias FailureImageDownloadCompletion = () -> ()

extension UIImageView {
    
    func setImageWithURLAndIndicatory(_ url: URL?, successCompletion: SuccessImageDownloadCompletion? = nil, failureCompletion: FailureImageDownloadCompletion? = nil) {
        
        self.sd_setImage(with: url) {[weak self] (image, error, type, url)  in
            
            guard let strongSelf = self else {
                return
            }
            if error != nil {
                if failureCompletion != nil {
                    failureCompletion!()
                }
            } else {
                if successCompletion != nil {
                    guard let downloadedImage = image else { return }
                    successCompletion!(downloadedImage)
                }
            }
        }
    }
    
    func configureWithImageAttachment(_ attachment: ImageAttachment, successCompletion: SuccessImageDownloadCompletion? = nil, failureCompletion: FailureImageDownloadCompletion? = nil) {
        switch attachment {
        case .image(let image):
            self.sd_cancelCurrentImageLoad()
            self.image = nil
            self.image = image
            if successCompletion != nil {
                successCompletion!(image)
            }
        case .imageURL(let url):
            setImageWithURLAndIndicatory(url, successCompletion: successCompletion, failureCompletion: failureCompletion)
        }
    }
}
