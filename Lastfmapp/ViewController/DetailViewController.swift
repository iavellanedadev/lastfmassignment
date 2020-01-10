//
//  DetailViewController.swift
//  Lastfmapp
//
//  Created by Consultant on 1/9/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailPhoto: UIImageView!
    
    @IBOutlet weak var detailMainLabel: UILabel!
    
    @IBOutlet weak var detailSecondaryLabel: UILabel!
    
    @IBOutlet weak var detailButton: UIButton!
    
   
    var url: String!
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func urlButtonTouched(_ sender: UIButton) {

        if let url = NSURL(string: url){
                  UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
              }
    }
    
    private func loadData()
    {
        switch viewModel.type
        {
        case .album:
            detailMainLabel.text = viewModel.currentAlbum.albumName
            detailSecondaryLabel.text = viewModel.currentAlbum.artistName

            
                     DispatchQueue.main.async {
                        guard let url = URL(string: self.viewModel.currentAlbum.albumImage) else {return}
                         
                         var data = Data()

                         do{
                         data = try Data(contentsOf: url)


                         }catch{
                             print("ERROR FOUND GETTING IMAGE: " + error.localizedDescription)
                         }


                         guard let image = UIImage(data: data) else {return }


                         self.detailPhoto.image = image
                     }
        case .artist:
            detailMainLabel.text = viewModel.currentArtist.artistName
           

            DispatchQueue.main.async {
                guard let url = URL(string: self.viewModel.currentArtist.image) else {return}
                
                var data = Data()

                do{
                data = try Data(contentsOf: url)


                }catch{
                    print("ERROR FOUND GETTING IMAGE: " + error.localizedDescription)
                }


                guard let image = UIImage(data: data) else {return }


                self.detailPhoto.image = image
            }
            
        default:
            detailMainLabel.text = viewModel.currentTrack.trackName
            detailSecondaryLabel.text = viewModel.currentTrack.artistName
         
        }
    }

}
