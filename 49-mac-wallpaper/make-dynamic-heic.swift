// Builds a macOS dynamic wallpaper: one HEIC holding a light and a dark image,
// which macOS switches with the appearance (like its own "Dynamic" wallpapers).
//
//   swift make-dynamic-heic.swift <light image> <dark image> <output.heic>
//
// The first image carries the `apple_desktop:apr` XMP tag: a base64 binary plist
// {"l": <light image index>, "d": <dark image index>}, which is how macOS finds
// the light and dark images.

import Foundation
import ImageIO
import UniformTypeIdentifiers

let args = CommandLine.arguments
guard args.count == 4 else {
    FileHandle.standardError.write("usage: make-dynamic-heic.swift <light> <dark> <output.heic>\n".data(using: .utf8)!)
    exit(2)
}

func loadImage(_ path: String) -> CGImage {
    guard let source = CGImageSourceCreateWithURL(URL(fileURLWithPath: path) as CFURL, nil),
          let image = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
        FileHandle.standardError.write("can't read \(path)\n".data(using: .utf8)!)
        exit(1)
    }
    return image
}

let light = loadImage(args[1])
let dark = loadImage(args[2])

let namespace = "http://ns.apple.com/namespace/1.0/" as CFString
let appearance = try PropertyListSerialization.data(
    fromPropertyList: ["l": 0, "d": 1], format: .binary, options: 0)
let metadata = CGImageMetadataCreateMutable()
CGImageMetadataRegisterNamespaceForPrefix(metadata, namespace, "apple_desktop" as CFString, nil)
let tag = CGImageMetadataTagCreate(namespace, "apple_desktop" as CFString, "apr" as CFString,
                                   .string, appearance.base64EncodedString() as CFString)!
CGImageMetadataSetTagWithPath(metadata, nil, "apple_desktop:apr" as CFString, tag)

guard let destination = CGImageDestinationCreateWithURL(
    URL(fileURLWithPath: args[3]) as CFURL, UTType.heic.identifier as CFString, 2, nil) else {
    FileHandle.standardError.write("can't write \(args[3])\n".data(using: .utf8)!)
    exit(1)
}
let options = [kCGImageDestinationLossyCompressionQuality: 0.85] as CFDictionary
CGImageDestinationAddImageAndMetadata(destination, light, metadata, options)
CGImageDestinationAddImage(destination, dark, options)
guard CGImageDestinationFinalize(destination) else {
    FileHandle.standardError.write("can't finalize \(args[3])\n".data(using: .utf8)!)
    exit(1)
}
