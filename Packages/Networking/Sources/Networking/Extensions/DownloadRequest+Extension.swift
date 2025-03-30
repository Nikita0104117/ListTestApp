//
//  DownloadRequest+Extension.swift
//

import Foundation
import Alamofire

public extension DownloadRequest {
    func buildStream() -> DownloadStream {
        DownloadStream(request: self)
    }
}
