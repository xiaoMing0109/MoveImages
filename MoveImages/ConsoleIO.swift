//
//  ConsoleIO.swift
//  MoveImages
//
//  Created by LM on 2022/9/16.
//

import Foundation

enum OutputType {
    case standard
    case success
    case warning
    case error
}

class ConsoleIO {
    
    func writeMessage(_ message: String, to: OutputType = .standard) {
        switch to {
        case .standard:
            print("\u{001B}[;m\(message)")
        case .success:
            print("\u{001B}[0;32m\(message)")
        case .warning:
            print("\u{001B}[0;33m\(message)")
        case .error:
            fputs("\u{001B}[0;31m\(message)\n", stderr)
        }
    }
    
    func printUsage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        
        writeMessage("Usage:")
        writeMessage("  ./\(executableName) -r <fromPath> <toPath>    Recurive mode.")
        writeMessage("or")
        writeMessage("  ./\(executableName) -n <fromPath> <toPath>    Non-recursive mode.")
        writeMessage("or")
        writeMessage("  ./\(executableName)     Without an option to enter interactive mode.")
        writeMessage("or")
        writeMessage("  ./\(executableName) -h or --help     Show usage information.")
    }
    
    func getInput() -> String {
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        let strData = String(data: inputData, encoding: .utf8)!
        return strData.trimmingCharacters(in: .newlines)
    }
}
