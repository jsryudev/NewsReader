import Foundation

public struct OpenGraph {
    
    public let source: [OpenGraphMetadata: String]
    
    @discardableResult
    public static func fetch(url: URL, timeout: TimeInterval = 60, headers: [String: String]? = nil, completion: @escaping (Result<OpenGraph, Error>) -> Void) -> URLSessionDataTask {
        var mutableURLRequest = URLRequest(url: url)
        headers?.compactMapValues { $0 }.forEach {
            mutableURLRequest.setValue($1, forHTTPHeaderField: $0)
        }
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeout
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: mutableURLRequest, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                handleFetchResult(data: data, response: response, completion: completion)
            }
        })
        task.resume()
        return task
    }
    
    private static func handleFetchResult(data: Data?, response: URLResponse?, completion: @escaping (Result<OpenGraph, Error>) -> Void) {
        guard let data = data, let response = response as? HTTPURLResponse else {
            return
        }
        if !(200..<300).contains(response.statusCode) {
            completion(.failure(OpenGraphResponseError.unexpectedStatusCode(response.statusCode)))
        } else {
            if let htmlString = String(data: data, encoding: String.Encoding.utf8) {
                let og = OpenGraph(htmlString: htmlString)
                completion(.success(og))
                return
            } else if let htmlString = String(data: data, encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))) {
                let og = OpenGraph(htmlString: htmlString)
                completion(.success(og))
                return
            } else if let htmlString = String(data: data, encoding: String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0940))) {
                let og = OpenGraph(htmlString: htmlString)
                completion(.success(og))
                return
            } else {
                completion(.failure(OpenGraphParseError.encodingError))
                return
            }
        }
    }
    
    init(htmlString: String, injector: () -> OpenGraphParser = { DefaultOpenGraphParser() }) {
        let parser = injector()
        source = parser.parse(htmlString: htmlString)
    }
    
    public subscript (attributeName: OpenGraphMetadata) -> String? {
        return source[attributeName]
    }
}

private struct DefaultOpenGraphParser: OpenGraphParser {
}
