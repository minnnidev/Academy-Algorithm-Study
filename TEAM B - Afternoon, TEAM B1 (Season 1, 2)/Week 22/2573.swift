//
//  main.swift
//  Algorithm
//
//  Created by 김민 on 10/31/23.
//
// 백준 2573 빙산 https://www.acmicpc.net/problem/2573

// 1번 풀이
//let line = readLine()!.split(separator: " ").map { Int($0)! }
//let (N, M) = (line[0], line[1])
//var matrix = Array(repeating: Array(repeating: 0, count: M), count: N)
//
//for i in 0..<N {
//    matrix[i] = readLine()!.split(separator: " ").map { Int($0)! }
//}
//
//// 동시에 녹는 것이므로 배열 복사 필요
//var tmp = matrix
//var year = 0
//
//let dx = [-1, 0, 1, 0]
//let dy = [0, 1, 0, -1]
//
//// 얼음 녹이는 함수
//func meltIce() {
//    for x in 0..<N {
//        for y in 0..<M {
//            if tmp[x][y] != 0 { // 바다가 아니라 빙산일 때
//                for k in 0..<4 { // 동서남북 네 방향 탐색
//                    let nx = x + dx[k]
//                    let ny = y + dy[k]
//
//                    if 0..<N ~= nx && 0..<M ~= ny && matrix[nx][ny] == 0 { // 범위 안에 있고, 각 방향이 바다일 경우
//                        if tmp[x][y] > 0 { // 0보다 더 줄어들 수 없으므로, 0보다 클 때만 녹여줌
//                            tmp[x][y] -= 1
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    matrix = tmp
//}
//
//// bfs로 덩어리 탐색하기
//func bfs(x: Int, y: Int, visited: inout [[Bool]]) {
//    var queue = [(x, y)]
//
//    while !queue.isEmpty {
//        let (x, y) = (queue[0].0, queue[0].1)
//        queue.removeFirst()
//
//        for k in 0..<4 {
//            let nx = x + dx[k]
//            let ny = y + dy[k]
//
//            // 덩어리들을 찾기 위해 범위 내에 있고, 이웃하고 방문하지 않은 빙산을 찾음 -> 후에 실행할 때 bfs가 끝나면 덩어리 개수 1 추가하기
//            if 0..<N ~= nx && 0..<M ~= ny && matrix[nx][ny] != 0 && !visited[nx][ny] {
//                visited[nx][ny] = true
//                queue.append((nx, ny))
//            }
//        }
//    }
//}
//
//while true {
//    year += 1
//    meltIce()
//
//    if matrix.flatMap({ $0 }).allSatisfy({ $0 == 0 }) { // 빙산이 전부 다 녹았을 때는 0 출력
//        year = 0
//        break
//    }
//
//    var visited = Array(repeating: Array(repeating: false, count: M), count: N)
//    var lump = 0
//
//    for x in 0..<N {
//        for y in 0..<M {
//            if matrix[x][y] != 0 && !visited[x][y] { // 빙산인 곳 탐색하기
//                bfs(x: x, y: y, visited: &visited)
//                lump += 1
//            }
//        }
//    }
//
//    if lump >= 2 {
//        break
//    }
//}
//
//print(year)


// 2번 풀이
// 처음 입력받을 때 빙산인 것만 따로 입력받아서 시간 줄임
let line = readLine()!.split(separator: " ").map { Int($0)! }
let (N, M) = (line[0], line[1])
var matrix = Array(repeating: Array(repeating: 0, count: M), count: N)
var ices = [(Int, Int)]()

for i in 0..<N {
    matrix[i] = readLine()!.split(separator: " ").map { Int($0)! }

    for j in 0..<M {
        if matrix[i][j] != 0 {
            ices.append((i, j))
        }
    }
}

// 동시에 녹는 것이므로 배열 복사 필요
var tmp = matrix
var year = 0

let dx = [-1, 0, 1, 0]
let dy = [0, 1, 0, -1]

// 얼음 녹이는 함수
func meltIce() {
    for (x, y) in ices {
        for k in 0..<4 { // 동서남북 네 방향 탐색
            let nx = x + dx[k]
            let ny = y + dy[k]

            if 0..<N ~= nx && 0..<M ~= ny && matrix[nx][ny] == 0 { // 범위 안에 있고, 각 방향이 바다일 경우
                if tmp[x][y] > 0 { // 0보다 더 줄어들 수 없으므로, 0보다 클 때만 녹여줌
                    tmp[x][y] -= 1
                }
            }
        }
    }

    matrix = tmp
}

// bfs로 덩어리 탐색하기
func bfs(x: Int, y: Int, visited: inout [[Bool]]) {
    var queue = [(x, y)]
    var index = 0

    while queue.count > index {
        let (x, y) = (queue[index].0, queue[index].1)
        index += 1

        for k in 0..<4 {
            let nx = x + dx[k]
            let ny = y + dy[k]

            // 덩어리들을 찾기 위해 범위 내에 있고, 이웃하고 방문하지 않은 빙산을 찾음 -> 후에 실행할 때 bfs가 끝나면 덩어리 개수 1 추가하기
            if 0..<N ~= nx && 0..<M ~= ny && matrix[nx][ny] != 0 && !visited[nx][ny] {
                visited[nx][ny] = true
                queue.append((nx, ny))
            }
        }
    }
}

while true {
    year += 1
    meltIce()

    if matrixmatrix.flatMap({ $0 }).allSatisfy({ $0 == 0 }) { // 빙산이 전부 다 녹았을 때는 0 출력
        year = 0
        break
    }

    var visited = Array(repeating: Array(repeating: false, count: M), count: N)
    var lump = 0

    for (x, y) in ices {
        if matrix[x][y] != 0 && !visited[x][y] { // 빙산인 곳 탐색하기
            bfs(x: x, y: y, visited: &visited)
            lump += 1
        }
    }

    if lump >= 2 {
        break
    }
}

print(year)
