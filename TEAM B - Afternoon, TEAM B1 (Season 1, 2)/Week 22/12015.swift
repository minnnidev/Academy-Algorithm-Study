//
//  main.swift
//  Algorithm
//
//  Created by 김민 on 10/27/23.
//
// 백준 12015 가장 긴 증가하는 부분 수열2 https://www.acmicpc.net/problem/12015

let N = Int(readLine()!)!
var A = readLine()!.split(separator: " ").map { Int($0)! }
var X = Array(repeating: 0, count: 1000001) // 증가하는 수열을 저장하는 부분
var maxLength = 0

for i in 0..<N {
    /*
    증가하는 부분 수열의 가장 큰 수보다 A[i]가 크다면 증가한다는 뜻이므로, X 배열에 추가
     */
    if X[maxLength] < A[i] {
        maxLength += 1
        X[maxLength] = A[i]
    } else {
        /*
         증가하는 부분 수열의 가장 큰 수보다 A[i]가 크지 않다면, X 배열 중간에 추가될 수 있다.
         이분 탐색을 통해서 들어갈 인덱스를 구해줌
         */
        var (left, right) = (0, maxLength)

        while (left < right) {
            var mid = (left + right) / 2

            if X[mid] >= A[i] {
                right = mid
            } else {
                left = mid + 1
            }
        }

        X[left] = A[i]
    }
}

print(maxLength)
