//
//  String+Extension.swift
//  MoveImages
//
//  Created by LM on 2022/9/19.
//

import Foundation

extension String {
        
    var isImageFile: Bool {
        let types = ["png", "jpg", "jpeg"]
        
        let fileType = URL(fileURLWithPath: self).pathExtension.lowercased()
        return types.contains(fileType)
    }
}
