//
//  ThemeViewController.swift
//  iKanType
//
//  Created by ಅಜೇಯ on 1/12/16.
//  Copyright © 2016 ಅಜೇಯ ಜಯರಾಂ. All rights reserved.
//

import UIKit
import Keyboard

class ThemeViewController: UICollectionViewController {
    
    private var themes = [ThemeModel]()
    private let reuseIdentifier = "ThemeCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private var selectedTheme : String?
    private var selectedItemIndexPath : NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let resourcePath = Bundle.main.resourcePath
        
        let fileManager = FileManager.default
        
        do {
            let files = try fileManager.contentsOfDirectory(atPath: resourcePath!)
            
            for file: String in files {
                if (file.hasSuffix(".theme")) {
                    let fileName = file as NSString
                    themes.append(ThemeFactory.createTheme(fileName: fileName.deletingPathExtension)!)
                }
            }
        } catch _ {
        }
        
        
        let shared: UserDefaults = UserDefaults(suiteName: "group.com.iKanType")!
        selectedTheme = shared.string(forKey: "theme")
        
        //if (theme != nil) {
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func themeSelected(sender: UITextField) {
        //let shared: NSUserDefaults = NSUserDefaults(suiteName: "group.com.iKanType")!
        //shared.setValue(textField!.text, forKey: "theme")
        //shared.synchronize()
    }
    
    //MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return themes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! ThemeCell
        cell.imageView.image = UIImage(named: themes[indexPath.row].previewImage!)
        cell.themeName?.text = themes[indexPath.row].themeName
        
        if selectedTheme == themes[indexPath.row].themeName {
            cell.isSelected = true
            selectedItemIndexPath = indexPath as NSIndexPath?
        }
        //cell.backgroundColor = UIColor.blackColor()
        // Configure the cell
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var indexPaths: [NSIndexPath] = [NSIndexPath]()
        
        if (selectedItemIndexPath != nil) {
            let cell = collectionView.cellForItem(at: selectedItemIndexPath! as IndexPath)
            cell?.isSelected = false
            indexPaths.append(selectedItemIndexPath!)
        }
        
        selectedItemIndexPath = indexPath as NSIndexPath?
        let cell = collectionView.cellForItem(at: selectedItemIndexPath! as IndexPath)
        cell?.isSelected = true
        indexPaths.append(indexPath as NSIndexPath)
        
        selectedTheme = themes[indexPath.row].themeName
        let shared: UserDefaults = UserDefaults(suiteName: "group.com.iKanType")!
        shared.setValue(selectedTheme, forKey: "theme")
        shared.synchronize()
        
        collectionView .reloadItems(at: indexPaths as [IndexPath])
        
    }
}
