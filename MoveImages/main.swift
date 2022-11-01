//
//  main.swift
//  MoveImages
//
//  Created by LM on 2022/9/19.
//

import Foundation

let moveImage = MoveImage()

if CommandLine.argc < 2 {
    moveImage.interactiveMode()
} else {
    moveImage.staticMode()
}
