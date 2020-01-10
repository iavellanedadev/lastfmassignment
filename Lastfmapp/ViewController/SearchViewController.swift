//
//  ViewController.swift
//  Lastfmapp
//
//  Created by Consultant on 1/8/20.
//  Copyright © 2020 Consultant. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var albumTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchSetup()
        setupTable()
    }

    
    private func setupTable()
    {
        albumTableView.register(UINib(nibName: TrackTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: TrackTableViewCell.identifier)
        albumTableView.register(UINib(nibName: ArtistTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: ArtistTableViewCell.identifier)
        
        albumTableView.tableFooterView = UIView(frame: .zero)
        albumTableView.separatorStyle = .none
//        viewModel.artistDelegate = self
//        viewModel.trackDelegate = self
//        viewModel.albumDelegate = self
        viewModel.delegate = self
    }
    
    private func searchSetup()
    {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self //set delegate to current view controller class

        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return UITableView.automaticDimension
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
      
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.view.backgroundColor = .white
        switch indexPath.section
        {
        case 0:
            let album = viewModel.albums[indexPath.row]
            viewModel.type = .album
            
            detailVC.url = album.albumUrl
            viewModel.currentAlbum = album
            detailVC.viewModel = viewModel

        case 1:
            let artist = viewModel.artists[indexPath.row]
                    viewModel.type = .artist
            detailVC.url = artist.artistUrl
                    viewModel.currentArtist = artist
                    detailVC.viewModel = viewModel
        default:
            let track = viewModel.tracks[indexPath.row]
            viewModel.type = .track
            detailVC.url = track.trackUrl
            viewModel.currentTrack = track
            detailVC.viewModel = viewModel        }
        
        navigationController?.pushViewController(detailVC, animated: true)

    
      }
}

extension SearchViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section
        {
            case 0:
                return viewModel.albums.count
            case 1:
                return viewModel.artists.count
            default:
                return viewModel.tracks.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          switch section
          {
          case 0:
              return "Albums"
          case 1:
              return "Artists"
          default:
            return "Tracks"
          }
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section
        {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier, for: indexPath) as! AlbumTableViewCell
            
    
                let album = viewModel.albums[indexPath.row]
                cell.album = album
            
                
                return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ArtistTableViewCell.identifier, for: indexPath) as! ArtistTableViewCell
                let artist = viewModel.artists[indexPath.row]
                cell.artist = artist
                
            
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.identifier, for: indexPath) as! TrackTableViewCell
           
                let track = viewModel.tracks[indexPath.row]

                cell.track = track
            
            
                return cell
            
        }
     
    }
    
    
}

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        //TODO:filter function
        guard let search = searchController.searchBar.text else {return }
        
        guard let sanitized = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return }
        
        viewModel.get(sanitized)
        
    }

    
}

//extension SearchViewController: ArtistDelegate, TrackDelegate, AlbumDelegate{
//    func update(){
//        DispatchQueue.main.async {
//            self.albumTableView.reloadData()
//        }
//    }
//}

extension SearchViewController: ViewModelDelegate
{
    func update(){
        DispatchQueue.main.async {
            self.albumTableView.reloadData()
        }
    }
}

