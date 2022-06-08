// swift-tools-version: 5.6

///
import PackageDescription

///
let package = Package(
    name: "JSONLiterals",
    platforms: [.macOS(.v10_13), .iOS(.v11), .watchOS(.v4), .tvOS(.v11)],
    products: [
        
        ///
        .library(
            name: "JSONLiterals",
            targets: ["JSONLiterals"]
        ),
    ],
    dependencies: [
        
        ///
        .package(
            url: "https://github.com/jeremyabannister/FoundationToolkit",
            from: "0.1.0"
        ),
    ],
    targets: [
        
        ///
        .target(
            name: "JSONLiterals",
            dependencies: [
                
                ///
                "FoundationToolkit"
            ]
        ),
        
        ///
        .testTarget(
            name: "JSONLiterals-tests",
            dependencies: [
                
                ///
                "JSONLiterals",
                
                ///
                .product(
                    name: "FoundationTestToolkit",
                    package: "FoundationToolkit"
                )
            ]
        ),
    ]
)
