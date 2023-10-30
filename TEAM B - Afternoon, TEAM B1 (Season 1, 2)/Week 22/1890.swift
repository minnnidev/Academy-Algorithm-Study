//
//  main.swift
//  Algorithm
//
//  Created by 김민 on 10/30/23.
//
// 백준 1890 점프 https://www.acmicpc.net/problem/1890

// dp 문제

let N = Int(readLine()!)!
var matrix = Array(repeating: Array(repeating: 0, count: N), count: N)
// dp[i][j] -> (i, j)번째까지 올 수 있는 경로의 개수
var dp = Array(repeating: Array(repeating: 0, count: N), count: N)

for i in 0..<N {
    matrix[i] = readLine()!.split(separator: " ").map { Int($0)! }
}

/*
초기값 설정 -> 가장 왼쪽 맨위칸에서 오른쪽으로 갈 수 있는 곳과 아래쪽으로 갈 수 있는 곳을 초기값으로 설정
*/
let firstDistance = matrix[0][0]
dp[0][firstDistance] = 1
dp[firstDistance][0] = 1

for i in 0..<N {
    for j in 0..<N {
        // 같은 열의 자기보다 이전 수 중 0이 아닌 수가 있는지 체크
        for k in 0..<i {
            if dp[k][j] != 0 { // 그 수가 0이 아니라면
                if k + matrix[k][j] == i { // matrix[k][j]의 거리로 (i, j)까지 올 수 있는지 체크
                    dp[i][j] += dp[k][j] // 올 수 있다면 이전 dp[k][j]의 경로의 개수를 합쳐줌.
                }
            }
        }
        // 같은 행의 자기보다 이전 수 중 0이 아닌 수가 있는지 체크
        for k in 0..<j {
            if dp[i][k] != 0 {
                if k + matrix[i][k] == j { // matrix[i][k]의 거리로 (i, j)까지 올 수 있는지 체크
                    dp[i][j] += dp[i][k] // 올 수 있다면 이전 dp[i][k]의 경로의 개수를 합쳐줌.
                }
            }
        }
    }
}

print(dp[N-1][N-1])
