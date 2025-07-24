protocol SelfIdentifiable: Identifiable, Hashable { }

extension SelfIdentifiable {
    var id: Self { return self }
}
