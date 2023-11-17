An (untested) implementation of the [Union-Find Disjoint Set data structure](https://en.wikipedia.org/wiki/Disjoint-set_data_structure) (GC-safe). This data structure works well for Kruskal's Algorithm (for finding minimum/maximum spanning trees), as well as incremental graph connectivity.

This implementation uses both path compression and union by rank, so their asymptotic time complexity is O(a(n)), where a(n) is the inverse Ackermann function.

(For some reason, I keep implementing data structures and algorithms in GML, but I never end up using them in any games. Or working on any games in any form of consistency)