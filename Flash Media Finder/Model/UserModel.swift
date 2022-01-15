import UIKit

struct User: Codable {
    var name: String
    var pass: String
    var email: String
    var address: String
    var image : codableImage
}

struct codableImage: Codable {
    let imageData : Data?
    func getImage () -> UIImage? {
        if let imageData = self.imageData {
            return UIImage(data: imageData) 
        }
        return UIImage(named:"register" )!
    }
    
    init(withImage image : UIImage) {
        self.imageData = image.jpegData(compressionQuality: 1.0)
    }
}



