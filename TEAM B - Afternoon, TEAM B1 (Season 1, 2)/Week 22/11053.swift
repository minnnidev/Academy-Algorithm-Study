//
//  main.swift
//  Algorithm
//
//  Created by 김민 on 10/27/23.
//
// 백준 11053 가장 긴 증가하는 부분 수열 https://www.acmicpc.net/problem/11053

let N = Int(readLine()!)!
var A = readLine()!.split(separator: " ").map { Int($0)! }
// dp[i]: i번째 수를 마지막으로 가지는 증가하는 수열의 길이
var dp = Array(repeating: 0, count: A.count)

dp[0] = 1

for i in 0..<A.count {
    var tmp = 0

    for j in 0..<i {
        if A[i] > A[j] {
            tmp = max(tmp, dp[j])
        }
    }

    dp[i] = tmp + 1
}

print(dp.max()!)
