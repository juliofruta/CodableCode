/// Function used for printing.
/// - Parameters:
///   - file: The file at which the function was called from.
///   - line: The line at whic the function was called from.
///   - output: The string to be printed.
func dump2(file: String = #file, line: Int = #line, _ output: String) {
    print(">>> \(output)\t|\(file):\(line)")
}
