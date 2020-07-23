//
//  HostingCell.swift
//  NGSwiftUITableCellSizing
//
//  Created by Noah Gilmore on 7/7/20.
//

import Foundation
import UIKit
import SwiftUI

// sizeThatFits method
//final class HostingCell<Content: View>: UITableViewCell {
//    private lazy var hostingController: UIHostingController<Content?> = UIHostingController(rootView: nil)
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        hostingController.view.backgroundColor = .clear
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func sizeThatFits(_ size: CGSize) -> CGSize {
//        let size = hostingController.sizeThatFits(in: size)
//        print("Returning size \(size)")
//        return size
//    }
//
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        hostingController.view.frame.size = self.sizeThatFits(bounds.size)
//    }
//
//    public func set(rootView: Content, parentController: UIViewController) {
//        self.hostingController.rootView = rootView
//        if !self.contentView.subviews.contains(hostingController.view) {
//            self.contentView.addSubview(hostingController.view)
//        }
//    }
//}

// Constraints method

final class HostingCell<Content: View>: UITableViewCell {
    private let hostingController = UIHostingController<Content?>(rootView: nil)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        hostingController.view.backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(rootView: Content, parentController: UIViewController) {
        self.hostingController.rootView = rootView
        self.hostingController.view.invalidateIntrinsicContentSize()

        let requiresControllerMove = hostingController.parent != parentController
        if requiresControllerMove {
            parentController.addChild(hostingController)
        }

        if !self.contentView.subviews.contains(hostingController.view) {
            self.contentView.addSubview(hostingController.view)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            hostingController.view.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
            hostingController.view.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
            hostingController.view.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            hostingController.view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }

        if requiresControllerMove {
            hostingController.didMove(toParent: parentController)
        }
    }
}

struct HostingCell_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
