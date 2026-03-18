class ArchitectureLayerViewModel {
  const ArchitectureLayerViewModel({
    required this.name,
    required this.responsibility,
    required this.directories,
    required this.note,
  });

  final String name;
  final String responsibility;
  final List<String> directories;
  final String note;
}

class ArchitecturePatternViewModel {
  const ArchitecturePatternViewModel({
    required this.pattern,
    required this.implementation,
  });

  final String pattern;
  final String implementation;
}

class ArchitectureOverviewViewModel {
  const ArchitectureOverviewViewModel({
    required this.startupSteps,
    required this.layers,
    required this.folderTree,
    required this.implementationPatterns,
    required this.nextMilestones,
  });

  final List<String> startupSteps;
  final List<ArchitectureLayerViewModel> layers;
  final String folderTree;
  final List<ArchitecturePatternViewModel> implementationPatterns;
  final List<String> nextMilestones;
}
