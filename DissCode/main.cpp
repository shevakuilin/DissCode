//
//  main.cpp
//  DissCode
//
//  Created by ShevaKuilin on 2019/11/11.
//  Copyright © 2019 ShevaKuilin. All rights reserved.
//

#include <iostream>
#include <algorithm>

using namespace std;

string findSum(string str1, string str2) {
    // 开始计算之前，确保 str2 的长度更大
    if (str1.length() > str2.length()) {
        swap(str1, str2);
    }
    // 使用一个空字符串存储结果
    string str = "";
  
    // 计算两个字符串的长度
    int n1 = str1.length(), n2 = str2.length();
  
    // 反转两个字符串
    reverse(str1.begin(), str1.end());
    reverse(str2.begin(), str2.end());
  
    int carry = 0;
    for (int i=0; i<n1; i++) {
        // 计算当前数字的总和并进位
        int sum = ((str1[i]-'0')+(str2[i]-'0')+carry);
        str.push_back(sum%10 + '0');
  
        // 计算下一步的进位
        carry = sum/10;
    }
    // 加上 str2 的其余位数
    for (int i=n1; i<n2; i++) {
        int sum = ((str2[i]-'0')+carry);
        str.push_back(sum%10 + '0');
        carry = sum/10;
    }
    // 加入剩余进位
    if (carry) {
        str.push_back(carry+'0');
    }
    // 反向结果字符串
    reverse(str.begin(), str.end());
  
    return str;
}

string fib(int n) {
    if (n < 2) return to_string(n);
    string prev = "0", curr = "1";
    for (int i = 0; i < n - 1; i++) {
        string sum = findSum(prev, curr);
        prev = curr;
        curr = sum;
    }
    return curr;
}

int main(int argc, const char * argv[]) {
    int n;
    while (cin>>n) {
        string result = fib(n);
        cout << result << endl;
    }
    
    return 0;
}
