import UIKit


// 深度优先搜索 DFS

let No = "No"
let Yes = "Yes"
//var isCycle = false // 是否存在环
//var canContinue = true // 是否可以继续向下搜索
var start: Int = 0 // 记录图的起点，方便后面的回溯和环的判定
var directed = false // 标记是否为有向图
//var dpTable = [Int: Int]() // 记录表，记录已走过的内容

/**
 *
 * @param N     顶数量
 * @param M     边数量
 * @param I       是否为有向图
 * @param A      边起点数组
 * @param B      边终点数组
 *
 */
func DFS(_ N: Int, _ M: Int, _ I: Int, _ A: [Int], _ B: [Int]) -> String {
    // 如果 A 和 B 的数量不相等，直接返回 No
    // 因为无法形成有效边
    if A.count != B.count { return No }
    // 0 < N <= 100，0 < M <= 4000
    if N <= 0 || N > 100 { return No }
    if M <= 0 || M > 4000 { return No }
    // I = 0 | 1
    if I != 0 && I != 1 { return No }
    // 满足回路至少需要满足 顶点和边数量相等
//    if N > M { return No }
    // 递归结束条件
    // 1. 无到连接完成回路，直接返回 No
    // 2. 回路构成，返回 Yes
    
    // 记录图的起点，方便后面的回溯和环的判定
    start = A.first!
    // 标记是否为有向图
    directed = I == 0 ? true:false
    // 形成环，只需要考虑最外边，而不需要考虑交叉连线
    if directed {
        // 有向图
        // 深度优先搜索推断：
        // 有向图需要判断方向，所以先判断起点路径搜索的方向
        // 指向的 B 比 A 大且相邻(不相邻为非外边，外边必然相邻)，逆时针搜索，否则顺时针搜索
        // 逆时针，一条道走到黑，先遍历 A 当中是否包含 b，包含再往下走，不包含则回溯上一个顶点
        // 如果回溯到起点，则改为顺时针搜索，顺时针一条路走到黑，走不回起点则无环
        
        // 最简方案推断：
        // 对于「有向图」只要环形成，则 A 中至少包含一个当前 b，没有则无法形成回路
        // 也就是说，只要 A 和 B 中元素在「去重后」完全相同，就可以认为是存在环
        // 但是需要注意一点，因为形成环的条件，我们只考虑最外圈，所以，除了尾边以外(尾边的值差 N - 1)，A, B的值差不能大于1
        // 也就是说，值差等于 N - 1 就可以看做是尾边，我们在去重之前，需要先将除尾边以外的，值差大于1的先过滤掉，这步的目的是为了忽略外边以外的因素，避免影响结果
        
        // 先过滤
        var filterA = [Int]()
        var filterB = [Int]()
        for i in 0..<A.count {
            let a = A[i]
            let b = B[i]
            let diff = abs(a - b)
            if diff == (N - 1) || diff == 1 {
                 // 忽略交叉边
                filterA.append(a)
                filterB.append(b)
            }
        }
        // 全部被过滤说明全部为交叉边，直接返回 No
        if filterA.count == 0 || filterB.count == 0 { return No }
        // 再去重
        var tempA = [Int]()
        for j in 0..<filterA.count {
            let a = filterA[j]
            print("a = \(a)")
            if !tempA.contains(a) {
                print("tempA = \(tempA) 不包含 \(a)")
                tempA.append(a)
            }
        }
        var tempB = [Int]()
        for k in 0..<filterB.count {
            let b = filterB[k]
            if !tempB.contains(b) { tempB.append(b) }
        }
        // 排序后判断是否完全相等
        let sortA = tempA.sorted()
        let sortB = tempB.sorted()
        if sortA == sortB {
            // 相等则有环
            return Yes
        } else {
            // 否则无环
            return No
        }
    } else {
        // 无向图
        // 最初的推断：
        // 对于无向图来说，形成环的条件是每个顶点都相连，那么也就是每个顶点在 A 或 B 中都至少出现一次
        // 由于顶点在外边相连的条件是相邻，也就是说，相邻的两个顶点才可以完成外边的相连，相邻也就是左右的顶点值要么小于1，要么大于1，是可以按序排列的
        // A 和 B 的值虽然在有向图当中标识边的方向，但在无向图当中，是没有方向的，实际上，A 和 B 就代表着顶点的值(不可能出现顶点以外的值)，A 和 B 这两个数组就可以看做是两个顶点数组
        // 这样一来，我们就可以将 A 和 B 合并为同一个数组，直接去重，得到的最后结果，如果和顶点数量 N 相同，就可以认为是存在环，否则不存在环
        
        // 最简方案推断：
        // 观察有环的无向图规律，无向图形成环，在 A 和 B 当中，每个顶点的出现次数至少为2次才满足形成环的条件，这样才能满足左右相连
        //
    }
    
    return No;
}

// 测试
let N = 4
let M = 5
let I = 0
let A = [1, 2, 1, 1, 2]
let B = [2, 3, 3, 4, 4]
let result = DFS(N, M, I, A, B)
print("图中是否有环：\(result)")
