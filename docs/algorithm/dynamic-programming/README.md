# 53. 最大子序和

题目链接： https://leetcode-cn.com/problems/maximum-subarray

**思路**

假设已知 `[0,i-1]` 区间内 **以i-1为结尾** 的最大子序和为 sum, 则 `[0,i]` 区间内 **以i为结尾** 的最大子序和只能是sum + nums[i] 和 nums[i] 中二选一。

公式如下
```
dp[i] = max(dp[i-1] + nums[i], nums[i])
```

最后结果为 Max{dp[i] | i = 0,1,...,n-1} 


``` c++
class Solution {
public:
    int maxSubArray(vector<int>& nums) {
        if(nums.empty())
            return 0;
        int res = nums[0], sum = nums[0];
        for(int i = 1;i < nums.size(); ++i){
            sum = sum + nums[i] > nums[i] ? sum + nums[i] : nums[i];
            res = max(res, sum);
        }
        return res;
    }
};
```
# 72.编辑距离

题目链接: https://leetcode-cn.com/problems/edit-distance/

**思路**

设dp[i][j]表示字串word1.substr(0,i)转换成字串word2.substr(0,j)所需要的变换次数。

设已知word1前i-1位字串到word2前j位字串已经转换好,并且所需最少变换次数为dp[i-1][j-1]。

当word1第i位 word2第j位相同时, 不需要另外的变换,次数不需要增加, `dp[i][j] = dp[i-1][j-1]`。

而当word1第i位和word2第j位并不相同时, 则可以有三种方式来变换。

以 abcd 要转换成 bcda为例， 首先画一个表格, 表格第i行第j列表示word1前i位的子串变换成word2前j位所需要的次数

|    | ''       | b        | c        | d            | a               |
|----|----------|----------|----------|--------------|-----------------|
| '' | 0        | 1(加1位) | 2(加2位) | 3(加3位)     | 4(加4位)        |
| a  | 1(删1位) |          |          |              |                 |
| b  | 2(删2位) |          |          |              |                 |
| c  | 3(删3位) |          |          | abc-> bcd  | abcd->abc->bcda |
| d  | 4(删4位) |          |          | abcd->bcd    |                 |

1. (abc -> bcd) + (d->a) -> bcda

    这种情况是前三位都已经变换好，只剩最后一位不相同，只需要在原基础上做一次替换就好， 即 `dp[i-1][j-1] + 1`

2. abcd -> bcd -> bcda

    这种情况是前三位都已经变换好，但是还缺一位，添加上即可， 即 `dp[i][j-1] + 1`

3. abcd->abc->bcda->bcda

    这种情况是多了1位需要删掉，即`dp[i-1][j] + 1`

    这里可能有点不太好理解，毕竟一个格子上面的结果总是和自身的一样的，但别忘了上面的格子是从长度小1的子串变成的，所以不能忘记加上先前的删除操作，现有的abcd删1位变成abc，才有abc变成bcda

因此递推公式是
```
dp[i][j] = min(dp[i-1][j-1], dp[i-1][j], dp[i][j-1]) + 1
```
``` c++
class Solution {
 public:
  int minDistance(string word1, string word2) {
    int m = word1.size(), n = word2.size();
    vector<vector<int>> dp(m + 1, vector<int>(n + 1, 0));

    for (int i = 1; i <= n; ++i) {
      dp[0][i] = dp[0][i - 1] + 1;
    }
    for (int i = 1; i <= m; ++i) {
      dp[i][0] = dp[i - 1][0] + 1;
    }

    for (int i = 1; i <= m; ++i) {
      for (int j = 1; j <= n; ++j) {
        if (word1[i - 1] == word2[j - 1])
          dp[i][j] = dp[i - 1][j - 1];
        else {
          dp[i][j] = min(dp[i-1][j-1], min(dp[i - 1][j], dp[i][j - 1])) + 1;
        }
      }
    }
    return dp[m][n];
  }
};
```


