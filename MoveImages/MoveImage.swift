//
//  MoveImage.swift
//  MoveImages
//
//  Created by LM on 2022/9/19.
//

import Foundation

enum OptionType: String {
    case recursion
    case non_recursion
    case help
    case quit
    case unknown
    
    init?(rawValue: String) {
        switch rawValue {
        case "-r": self = .recursion
        case "-n": self = .non_recursion
        case "-h", "-help", "--help": self = .help
        case "-q", "-quit": self = .quit
        default: self = .unknown
        }
    }
}

class MoveImage {
    let consoleIO = ConsoleIO()
    
    func staticMode() {
        let argCount = CommandLine.argc
        let option = CommandLine.arguments[1]
        
        switch OptionType(rawValue: option) {
        case .recursion, .non_recursion:
            if argCount == 4 {
                let from = CommandLine.arguments[2]
                let to = CommandLine.arguments[3]
                
                var recursion: Bool {
                    if OptionType(rawValue: option) == .recursion {
                        return true
                    }
                    return false
                }
                moveImages(fromFolderPath: from, toFolderPath: to, recursion: recursion)
            } else {
                if argCount > 4 {
                    consoleIO.writeMessage("Too many arguments for option \(option)", to: .error)
                } else {
                    consoleIO.writeMessage("Too few arguments for option \(option)", to: .error)
                }
                consoleIO.printUsage()
            }
        case .help:
            consoleIO.printUsage()
        case .quit: break
        default:
            consoleIO.writeMessage("Unknown option \(option)")
            consoleIO.printUsage()
        }
    }
    
    func interactiveMode() {
        consoleIO.writeMessage("Welcome to MoveImages. This program is used for move images to destination folder.")
        
        var shouldQuit = false
        while !shouldQuit {
            consoleIO.writeMessage("Type '-r' to recursive from subpath, type '-n' to non-recursive from path, type '-q' to quit.")
            
            let option = consoleIO.getInput()
            switch OptionType(rawValue: option) {
            case .recursion, .non_recursion:
                consoleIO.writeMessage("Input folder path:")
                let from = consoleIO.getInput()
                
                consoleIO.writeMessage("Input destination folder path:")
                let to = consoleIO.getInput()
                
                var recursion: Bool {
                    if OptionType(rawValue: option) == .recursion {
                        return true
                    }
                    return false
                }
                moveImages(fromFolderPath: from, toFolderPath: to, recursion: recursion)
            case .quit:
                shouldQuit = true
            default:
                consoleIO.writeMessage("Unknown option \(option)", to: .error)
            }
        }
    }
}

extension MoveImage {
    
    func moveImages(fromFolderPath: String, toFolderPath: String, recursion: Bool) {
        let folderPath = fromFolderPath.trimmingCharacters(in: .whitespaces)
        let destinationFolderPath = toFolderPath.trimmingCharacters(in: .whitespaces)
        let manager = FileManager.default
        
        var isDirectory: ObjCBool = false
        let isExist = manager.fileExists(atPath: folderPath, isDirectory: &isDirectory)
        guard isExist else {
            consoleIO.writeMessage("\(folderPath) is not exist!", to: .error)
            return
        }
        guard isDirectory.boolValue else {
            consoleIO.writeMessage("\(folderPath) is not a folder!", to: .error)
            return
        }
        
        var contents: [String] = []
        if recursion {
            guard let enumerator = manager.enumerator(atPath: folderPath) else {
                consoleIO.writeMessage("\(folderPath) may be an empty folder!", to: .error)
                return
            }
            contents = enumerator.allObjects as! [String]
        } else {
            do {
                contents = try manager.contentsOfDirectory(atPath: fromFolderPath)
            } catch {
                consoleIO.writeMessage("contentsOfDirectory error: \(error.localizedDescription)", to: .error)
                return
            }
        }
        
        // Create destination folder if not exist.
        if !manager.fileExists(atPath: destinationFolderPath, isDirectory: &isDirectory) ||
           isDirectory.boolValue == false {
            do {
                try manager.createDirectory(atPath: destinationFolderPath, withIntermediateDirectories: true)
            } catch {
                consoleIO.writeMessage("createDirectory error: \(error.localizedDescription)", to: .error)
                return
            }
        }
        
        for filePath in contents {
            let absolutePath = folderPath + "/" + filePath
            guard manager.fileExists(atPath: absolutePath, isDirectory: &isDirectory),
                  isDirectory.boolValue == false,
                  filePath.isImageFile
            else { continue }
            
            do {
                let fileName = URL(fileURLWithPath: filePath).lastPathComponent
                let toPath = destinationFolderPath + "/" + fileName
                try manager.moveItem(atPath: absolutePath, toPath: toPath)
            } catch {
                consoleIO.writeMessage("moveItem error: \(error.localizedDescription)", to: .error)
            }
        }

        consoleIO.writeMessage("Move image to \(destinationFolderPath) finished!", to: .success)
    }
}
