import MongoSwiftSync

struct UnifiedListDatabases: UnifiedOperationProtocol {
    static var knownArguments: Set<String> { [] }

    func execute(on object: UnifiedOperation.Object, context: Context) throws -> UnifiedOperationResult {
        let testClient = try context.entities.getEntity(from: object).asTestClient()
        let dbSpecs = try testClient.client.listDatabases()
        let encoded = try BSONEncoder().encode(dbSpecs)
        return .bson(.array(encoded.map { .document($0) }))
    }
}

struct AssertNumberConnectionsCheckedOut: UnifiedOperationProtocol {
    /// The name of the client entity to perform the assertion on.
    let client: String

    /// The number of connections expected to be checked out.
    let connections: Int

    static var knownArguments: Set<String> {
        ["client", "connections"]
    }

    func execute(on object: UnifiedOperation.Object, context: Context) throws -> UnifiedOperationResult {
        // Currently this is a no-op; the operation exists to let us run test files that are otherwise unrunnable
        // without support for this operation. Once CMAP is implemented in Swift we should write this properly.
        // TODO: SWIFT-1320
        .none
    }
}
