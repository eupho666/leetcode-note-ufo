## 160. 相交链表
题目链接：https://leetcode-cn.com/problems/intersection-of-two-linked-lists/

**方法1**

1. 先把链表A的节点全部加入到set中
2. 然后将链表B的节点依次到set里查找，查找到的第一个即为相交节点，如果没找到说明不相交。

``` c++
class Solution {
public:
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        set<ListNode*> s;
        ListNode *p = headA;
        while(p){
            s.insert(p);
            p = p->next;
        }
        p = headB;
        while(p){
            if(s.find(p) != s.end())
                return p;
            p = p->next;
        }
        return nullptr;
    }
};
```
**方法2**

思路：

两个指针同时移动， 直到位置相同为止。

假设有两个相交的链表，链表A的节点为 1->2->3->4->5，链表B的节点为 6->8->4->5， 已知第一个相交节点为4

使A指针遍历完原来的链表A，再遍历链表B直到4节点，移动的长度为5 + 2 = 7

使B指针遍历完原来的链表B， 再遍历链表A直到4节点，移动的长度为4 + 3 = 7

可以知道只要让指针移动到末尾时指向另一个链表的开头，两个指针终会相遇

``` c++
class Solution {
public:
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        ListNode *pa = headA, *pb = headB;
        while(pa != pb){
            pa = pa == nullptr ? headB : pa->next;
            pb = pb == nullptr ? headA : pb->next;
        }
        return pa;
    }
};
```

##  83. 删除排序链表中的重复元素

题目链接：https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list

思路：
1. 使用两个指针pre和cur, pre指针指向参照节点，cur指针指向当前节点。
2. 如果pre->val = cur->val,则删除cur指向的内存，同时将pre->next指向当前节点的下一个节点, 然后将cur往后移动。
3. 如果pre->val != cur->val, 将pre指向当前节点, cur往后移动

``` c++

class Solution {
public:
    ListNode* deleteDuplicates(ListNode* head) {
        if(head){
            ListNode* cur = head->next, *pre = head;
            while(cur){
                if(cur->val == pre->val){
                    pre->next = cur->next;
                    delete cur;
                    cur = pre->next;
                }else{
                    pre = cur;
                    cur = cur->next;
                }
            }
        }
        return head;
    }
};

```