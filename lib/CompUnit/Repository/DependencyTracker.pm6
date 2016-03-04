unit class CompUnit::Repository::DependencyTracker does CompUnit::Repository;

CompUnit::RepositoryRegistry.use-repository(CompUnit::Repository::DependencyTracker.new);

method id() {
    'dependencytracker'
}

my %seen := SetHash.new;

method need(CompUnit::DependencySpecification $spec, CompUnit::PrecompilationRepository $precomp?) {
    %seen{$spec.Str}++;
    # may not use precomp as precomp files don't go through .need for their deps
    self.next-repo.need($spec, CompUnit::PrecompilationRepository::None);
}

method loaded() {
    []
}

method path-spec() {
    'dependencytracker#'
}

END {
    say %seen;
}

# vim: ft=perl6
