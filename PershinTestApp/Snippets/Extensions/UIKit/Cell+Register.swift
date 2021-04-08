//
//  Cell+Register.swift
//  PershinTestApp
//
//  Created by Sergey Pershin on 09.04.2021.
//

import UIKit



//These names must be the same:
//1. Class name
//2. NIB name (if NIB is used)
//3. Reuse identifier in NIB (if NIB is used)


extension UITableView {
    func registerClass(cellType: UITableViewCell.Type) {
        self.register(cellType, forCellReuseIdentifier: String(describing: cellType))
    }
    func registerNib(cellType: UITableViewCell.Type) {
        let className = String(describing: cellType)
        let bundle = Bundle(for: cellType)
        self.register(UINib(nibName: className, bundle: bundle), forCellReuseIdentifier: String(describing: cellType))
    }
    func registerViewClass(viewType: UIView.Type) {
        self.register(viewType, forHeaderFooterViewReuseIdentifier: String(describing: viewType))
    }
    func registerViewNib(viewType: UIView.Type) {
        let className = String(describing: viewType)
        let bundle = Bundle(for: viewType)
        self.register(UINib(nibName: className, bundle: bundle), forHeaderFooterViewReuseIdentifier: String(describing: viewType))
    }
}

extension UICollectionView {
    enum ViewType {
        case header
        case footer
        
        var value: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            default:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }
    
    func registerClass(cellType: UICollectionViewCell.Type) {
        self.register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }
    func registerNib(cellType: UICollectionViewCell.Type) {
        let className = String(describing: cellType)
        let bundle = Bundle(for: cellType)
        self.register(UINib(nibName: className, bundle: bundle), forCellWithReuseIdentifier: String(describing: cellType))
    }
    func registerViewClass(type: ViewType, cellType: UICollectionReusableView.Type) {
        self.register(cellType, forSupplementaryViewOfKind: type.value, withReuseIdentifier: String(describing: cellType))
    }
    func registerViewNib(type: ViewType, viewType: UICollectionReusableView.Type) {
        let className = String(describing: viewType)
        let bundle = Bundle(for: viewType)
        self.register(UINib(nibName: className, bundle: bundle), forSupplementaryViewOfKind: type.value, withReuseIdentifier: String(describing: viewType))
    }
}


