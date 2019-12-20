//
// Created by Rene Dohan on 12/18/19.
//

import BlocksKit
import Renetik

extension UIBarButtonItem {
    public convenience init(image: UIImage, onClick action: @escaping (_ sender: UIBarButtonItem) -> Void) {
        self.init()
        bk_init(with: image, style: UIBarButtonItem.Style.plain, handler: { action($0 as! UIBarButtonItem) })
    }

    public convenience init(item: UIBarButtonItem.SystemItem,
                            onClick action: @escaping (_ sender: UIBarButtonItem) -> Void) {
        self.init()
        bk_init(with: item, handler: { action($0 as! UIBarButtonItem) })
    }

    public convenience init(title: String, onClick action: @escaping (_ sender: UIBarButtonItem) -> Void) {
        self.init()
        bk_init(withTitle: title, style: UIBarButtonItem.Style.plain, handler: { action($0 as! UIBarButtonItem) })
    }
}