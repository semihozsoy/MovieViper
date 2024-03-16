//
//  UITableView+Extension.swift
//  MovieViper
//
//  Created by Semih Ozsoy on 16.03.2024.
//

import UIKit

extension UITableView {
    func registerNib(_ type: UITableViewCell.Type,
                       bundle: Bundle) {
          register(UINib(nibName: type.identifier, bundle: bundle), forCellReuseIdentifier:  type.identifier)
      }
      
      func dequeueCell<CellType: UITableViewCell>(type: CellType.Type, indexPath: IndexPath) -> CellType {
          guard let cell = dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath) as? CellType else {
              fatalError("Wrong type of cell \(type)")
          }
          return cell
      }
}

