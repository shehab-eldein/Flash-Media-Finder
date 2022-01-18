//
//  MovieTabelVc.swift
//  Flash Media Finder
//
//  Created by shehab ahmed on 09/11/2021.
//
import UIKit
import SDWebImage
import AVKit
import AVFoundation
class MovieTabelVc: UIViewController {
    //    var search: String!
    var media: String = "all"
    var mediaArray: [Media] = []
    
    //    MARK:- Outlets
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    //MARK:-LifeCycle Methods
    override func viewDidLoad() {
        spinner.isHidden = true
        super.viewDidLoad()
        searchBar.delegate = self
        activeTabelView()
        UserDefultManager.shared().setToMemory(true,key:"openIn")
        handelNavigationController()
        getLastSearch()
        addGradient()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        handelNavigationController()
    }
    //MARK:- Private Methods
    private  func handelNavigationController () {
        navigationItem.title = "Movies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(goToProfile))
    }
    @objc private func goToProfile() {
        navigationController?.pushViewController(VC.ProfileVC, animated: true)
    }
    private func activeTabelView() {
        tabelView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tabelView.delegate = self
        tabelView.dataSource = self
    }
    private func getData (search: String, media: String) {
        NetworkingManager.getMedia(search: search, media: media,spinner: spinner) { error ,mediarr in
            if let error = error {
                self.alert(message: error.localizedDescription)
            }
            if let arr = mediarr {
                self.mediaArray = arr
                self.tabelView.reloadData()
            }
        }
    }
    //MARK:- Actions
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        if let userChoose =  segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex) {
            self.media = userChoose
            
        }
    }
}
//MARK:- TabelView Extention

extension MovieTabelVc: UITableViewDelegate,UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mediaArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MediaCell
        let name  = mediaArray[indexPath.row].artistName
        let label  = mediaArray[indexPath.row].longDescription
        let imageUrl =  URL(string:mediaArray[indexPath.row].artworkUrl100!)
        cell.configurationCell(name: name ?? "" , imgURl: (imageUrl ?? URL(string:"")!), label: label ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vidioUrl = URL(string:  mediaArray[indexPath.row].previewUrl!) {
            let player = AVPlayer(url: vidioUrl)
            let vc = AVPlayerViewController()
            vc.player = player
            present(vc, animated: true)
        }
        
        let cell = mediaArray[indexPath.row]
        if let dataCell = coderManager.shared().encodeCell(cell: cell) {
            DataBaseManager.shared().insertChoosenCell(cell: dataCell)
        }
        
    }
}
//MARK:- SearchBtn Extention
extension MovieTabelVc: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let search = searchBar.text{
            //        Networking
            getData(search: search, media: self.media)
            spinner.isHidden = false
            spinner.startAnimating()
        }
        if searchBar.text?.isEmpty == true {
            alert(message: "Search Bar is Empty!" )
        }
    }
    private  func getLastSearch () {
        self.mediaArray = DataBaseManager.shared().arrayOfSearches()
    }
    
}

