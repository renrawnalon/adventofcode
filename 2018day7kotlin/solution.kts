import java.io.File

// Common helper functions

fun fileToDependencyMap(file: String): MutableMap<String, MutableSet<String>> {
  val content = File(file)
    .readText()
    .split("\n")
    .filter({ it.length > 0 })
    .map({
      val line = it.split(" ")
      Pair(line[7], line[1])
    })


  val mappy: MutableMap<String, MutableSet<String>> = mutableMapOf()

  for (pair in content) {
    if (mappy[pair.second] == null) {
      mappy.put(pair.second, mutableSetOf())
    }

    var dependencySet = mappy[pair.first] ?: mutableSetOf()
      dependencySet.add(pair.second)
      mappy.put(pair.first, dependencySet)
  }

  return mappy
}

// Part 1 Solution

fun solvePart1(file: String): String {
  var dependencyMap = fileToDependencyMap(file)
  var result = ""

  while (dependencyMap.count() > 0) {
    val step = dependencyMap
      .filter({ it.value.count() == 0 })
      .map({ it.key })
      .sortedBy({ it })
      .firstOrNull()
    if (step != null) {
      result += step
      dependencyMap.remove(step)
      dependencyMap = dependencyMap
        .mapValues({
          it.value.subtract(setOf(step)).toMutableSet()
        }).toMutableMap()
    }
  }

  return result
}

// Part 2 Solution

// Execute solutions

val result1_simple = solvePart1("../2018day7/input_simple.txt")
println(result1_simple)

val result1 = solvePart1("../2018day7/input.txt")
println(result1)
