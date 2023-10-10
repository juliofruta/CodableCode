//
//  File.swift
//  
//
//  Created by Julio Cesar Guzman Villanueva on 10/6/23.
//

import Foundation

enum ShellError: Error {
    case commandFailed(String)
}

@discardableResult
func shell(_ command: String) throws -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.executableURL = URL(fileURLWithPath: "/bin/zsh")
    task.standardInput = nil

    do {
        try task.run()
        task.waitUntilExit()

        let status = task.terminationStatus
        guard status == 0 else {
            throw ShellError.commandFailed("Command failed with exit code \(status)")
        }

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!

        return output
    } catch {
        throw error
    }
}
