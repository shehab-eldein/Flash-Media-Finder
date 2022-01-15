//
//  MovieCell.swift
//   Flash Media Finder
//
//  Created by shehab ahmed on 09/11/2021.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var describLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        mediaImage.layoutIfNeeded()
        mediaImage.layer.borderWidth = 5
        mediaImage.layer.borderColor = UIColor.white.cgColor
        mediaImage.layer.cornerRadius = mediaImage.frame.width/2
    }
    func configurationCell(name: String,imgURl: URL,label: String)  {
        mediaImage.sd_setImage(with: imgURl , completed: nil)
        describLabel.text = label
        NameLabel.text = name
    }
    private func animateImage() {
        let frame = self.mediaImage.frame
        self.mediaImage.frame.origin.x += 4
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5,animations:  {
            self.mediaImage.frame.origin.x = 8
            self.mediaImage.frame = frame
        }, completion: nil)
    }
    @IBAction func imageBtnTapped(_ sender: Any) {
        animateImage()
    }
    
}
