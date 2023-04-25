class RequestsFilter {
  final List<String> requestTypes;
  bool sortNewest;
  int role;

  RequestsFilter({
    this.requestTypes = const [],
    this.sortNewest = true,
    this.role = 2,
  });

  // Getters
  int get sortNewestInt => sortNewest ? 1 : 0;
}
