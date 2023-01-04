//
//  File.swift
//  newProject
//
//  Created by Maksim Kasyanenko on 15.12.2022.
//

import Foundation
//MARK: - DownloadProtocol
protocol DownloadProtocol: NSObject {
    var complition: (() -> ())? { get set }
    var isDownload: Bool { get set }
    var urlTrack: String? { get set }
    var localUrlTrack: URL? { get set }
    var delegete: DownloadTrackDelegate? { get set }
    func download()
}
//MARK: - DownloadTrackDelegate
protocol DownloadTrackDelegate: AnyObject {
    func progressTransfer(progress: Float, downloadSize: String)
    func endDownLoad()
}
//MARK: - DownloadTrack
class DownloadTrack: NSObject, DownloadProtocol {
   @MainActor var complition: (() -> ())?
    var isDownload = false
    var urlTrack: String?
    var localUrlTrack: URL?
    weak var delegete: DownloadTrackDelegate?
    private  lazy var session: URLSession = {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        return session
    }()
    
    init(urlTrack: String?) {
        self.urlTrack = urlTrack
    }
    
    func download()  {
        guard let urlString = urlTrack, let url = URL(string: urlString) else { return }
        let task = session.downloadTask(with: url)
        task.resume()
    }
}
//MARK: - URLSessionDelegate, URLSessionDownloadDelegate 
extension DownloadTrack: URLSessionDelegate, URLSessionDownloadDelegate {
    @MainActor func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        try? FileManager.default.removeItem(at: destinationURL)
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            localUrlTrack = destinationURL
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
        DispatchQueue.main.async {
            self.complition?()
            self.delegete?.endDownLoad()
        }
        isDownload = true
       
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
        let totalwriten = ByteCountFormatter.string(fromByteCount: totalBytesWritten, countStyle: .file)
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        let downloadSize = "\(totalwriten)/\(totalSize)"
        DispatchQueue.main.async {[weak self] in
            self?.delegete?.progressTransfer(progress: progress, downloadSize: downloadSize)
        }
    }
}

