## 59. 螺旋矩阵 II

题目链接：https://leetcode-cn.com/problems/spiral-matrix-ii/

**思路**

1. 可以将该矩阵分解成多个圈，每次顺时针绕一圈做的都是重复的事情，因此可以写一个函数来解决顺时针绕一圈的工作。

2. 如果矩阵是N * N的规模， 那么需要绕 (N + 1) / 2圈，每一圈都从(i,i) 坐标开始。

3. 绕圈的时候重点是不要超过边界，这里需要根据层数来判断。假设此时是第k层，那么从(i,i)开始向右赋值的时候就不能，其列坐标就不能超过n - k。更具体的可以看代码注释。

``` c++
class Solution {
public:
    vector<vector<int>> generateMatrix(int n) {
        vector<vector<int>> res(n, vector<int>(n,0));
        int num = 1;
        for(int i = 0;i < (n + 1) / 2;++i){
            generateCircle(res, num, i,i);
        }
        return res;
    }

    void generateCircle(vector<vector<int>> &arr, int& num, int row, int col){
        int n =  arr.size(), level = row;
        for(;col < n - level; ++col) //上边界的赋值，方向从左到右
            arr[row][col] = num++;
        col--; // 上次循环中加过头了，所以要减1
        row++; // 开始右边界的赋值，此列第一个已经完成了，所以行数加1
        for(;row < n - level; ++row)
            arr[row][col] = num++;
        row--;  // 上次循环加过头了，所以要减1
        col--;  // 开始下边界的赋值，列坐标向左移
        for(;col >= level; col--)
            arr[row][col] = num++;
        col++;
        row--;
        for(; row > level; row--)
            arr[row][col] = num++;
    }

};
```