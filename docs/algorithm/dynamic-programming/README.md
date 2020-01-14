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