import Foundation

//Trial Division
func primesUpToTrialDivision(_ n: Int) -> [Int] {
    guard n > 1 else { return [] }
    
    var primes = [2]
    
    for i in 3...n {
        var isPrime = true
        
        for divisor in primes where divisor * divisor <= n {
            if i % divisor == 0 {
                isPrime = false
                break
            }
        }
        
        if isPrime { primes.append(i) }
    }
    
    return primes
}

//Sieve of Eratosthenes
func primesUpToSieve(_ n: Int) -> [Int] {
    guard n > 1 else { return [] }
    
    var primesMap: [Bool] = Array(repeating: true, count: n + 1)
    
    primesMap[0] = false
    primesMap[1] = false
    
    for i in 2...n {
        if primesMap[i] {
            for multiple in stride(from: i * i, through: n, by: i) {
                primesMap[multiple] = false
            }
        }
    }
    
    return primesMap.indices.filter { primesMap[$0] == true }.map { $0 }
}

// Djikstra's Prime Finding Alogrithm
func primesUpToDijkstra(_ n: Int) -> [Int] {
    var pool = [(multiple: 4, prime: 2)]
    var primes = [2]
    
    for i in stride(from: 3, through: n, by: 2) {
        while pool[0].multiple < i {
            let (multiple, prime) = pool.removeFirst()
            pool.append((multiple + prime, prime))
            pool.sort { $0.0 < $1.0 }
        }
        
        if pool[0].multiple == i {
            let (multiple, prime) = pool.removeFirst()
            pool.append((multiple + prime, prime))
            pool.sort { $0.0 < $1.0 }
        } else {
            primes.append(i)
            pool.append((i * i, i))
            pool.sort { $0.0 < $1.0 }
        }
    }
    
    return primes
}


print(primesUpToTrialDivision(100))
print(primesUpToSieve(100))
print(primesUpToDijkstra(100))

