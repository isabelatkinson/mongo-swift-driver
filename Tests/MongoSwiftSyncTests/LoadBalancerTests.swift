import MongoSwiftSync
import Nimble
import TestsCommon

final class LoadBalancerTests: MongoSwiftTestCase {
    let skipFiles = [
        // todo explain why
        "wait-queue-timeouts.json"
    ]

    func testLoadBalancers() throws {
        let tests = try retrieveSpecTestFiles(
            specName: "load-balancers",
            excludeFiles: skipFiles,
            asType: UnifiedTestFile.self
        ).map { $0.1 }

        let runner = try UnifiedTestRunner()
        try runner.runFiles(tests)
    }
}
