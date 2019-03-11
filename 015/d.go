package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
)

func main() {
	f := bufio.NewScanner(os.Stdin)
	f.Split(bufio.ScanWords)

	W := read(f)
	N := read(f)
	K := read(f)
	A := make([]int, N)
	B := make([]int, N)
	for i := range A {
		A[i] = read(f)
		B[i] = read(f)
	}

	DP := make([][][]int, W+1)
	for i := range DP {
		DP[i] = make([][]int, K+1)
		for j := range DP[i] {
			DP[i][j] = make([]int, N+1)
			for k := range DP[i][j] {
				DP[i][j][k] = -1
			}
		}
	}

	var dfs func(int, int, int) int
	dfs = func(restW int, restK int, curN int) int {
		if restW <= 0 || restK <= 0 || curN == N {
			return 0
		}

		if memo := DP[restW][restK][curN]; memo >= 0 {
			return memo
		}

		var res int
		if restW >= A[curN] && restK > 0 {
			res = max(B[curN]+dfs(restW-A[curN], restK-1, curN+1), dfs(restW, restK, curN+1))
		} else {
			res = dfs(restW, restK, curN+1)
		}

		DP[restW][restK][curN] = res
		return res
	}

	fmt.Println(dfs(W, K, 0))
}

func read(s *bufio.Scanner) int {
	s.Scan()
	res, _ := strconv.ParseInt(s.Text(), 10, 64)
	return int(res)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
