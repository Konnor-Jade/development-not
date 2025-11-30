# Foundry 开发框架指南

> 快速、便携、模块化的以太坊应用开发工具包

## 📋 简介

**Foundry** 是用 Rust 编写的快速以太坊开发框架，提供完整的智能合约开发工具链。

**官方网站：** https://getfoundry.sh  
**文档：** https://book.getfoundry.sh  
**GitHub：** https://github.com/foundry-rs/foundry

### 核心工具

- **Forge** - 以太坊测试框架（类似 Truffle、Hardhat 和 DappTools）
- **Cast** - 与 EVM 智能合约交互、发送交易、获取链上数据的多功能工具
- **Anvil** - 本地以太坊节点，类似 Ganache、Hardhat Network
- **Chisel** - Solidity REPL（交互式命令行）

---

## 🚀 安装

### macOS / Linux

```bash
# 下载 foundryup 安装器
curl -L https://foundry.paradigm.xyz | bash

# 安装 forge, cast, anvil, chisel
foundryup

# 安装最新 nightly 版本
foundryup --version nightly
```

### 验证安装

```bash
forge --version
cast --version
anvil --version
chisel --version
```

### 更新 Foundry

```bash
foundryup
```

### 从源码安装（可选）

```bash
# 使用 Cargo 安装
cargo install --git https://github.com/foundry-rs/foundry --profile release --locked forge cast chisel anvil
```

---

## 🎯 快速开始

### 1. 创建新项目

```bash
# 初始化项目
forge init my-project
cd my-project

# 项目结构
tree -L 2
```

**默认项目结构：**
```
my-project/
├── foundry.toml        # 配置文件
├── script/             # 部署脚本
│   └── Counter.s.sol
├── src/                # 智能合约源码
│   └── Counter.sol
└── test/               # 测试文件
    └── Counter.t.sol
```

### 2. 编译合约

```bash
# 编译所有合约
forge build

# 编译输出在 out/ 目录
```

### 3. 运行测试

```bash
# 运行所有测试
forge test

# 详细输出（显示 gas 使用）
forge test -vv

# 运行特定测试
forge test --match-test testIncrement

# 运行特定合约的测试
forge test --match-contract CounterTest
```

### 4. 启动本地节点

```bash
# 启动 Anvil（默认端口 8545）
anvil

# Anvil 会提供 10 个预充值账户
# 每个账户有 10000 ETH
```

### 5. 部署合约

```bash
# 部署到本地 Anvil
forge create src/Counter.sol:Counter \
  --rpc-url http://localhost:8545 \
  --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

# 部署到测试网（例如 Sepolia）
forge create src/Counter.sol:Counter \
  --rpc-url https://rpc.sepolia.org \
  --private-key <YOUR_PRIVATE_KEY> \
  --verify \
  --etherscan-api-key <YOUR_ETHERSCAN_API_KEY>
```

---

## 📝 编写测试

### 基础测试示例

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
```

### 常用断言

```solidity
// 相等断言
assertEq(a, b);
assertEq(a, b, "error message");

// 布尔断言
assertTrue(condition);
assertFalse(condition);

// 大小比较
assertGt(a, b);  // a > b
assertGe(a, b);  // a >= b
assertLt(a, b);  // a < b
assertLe(a, b);  // a <= b
```

### Cheatcodes（作弊码）

Foundry 提供强大的测试工具：

```solidity
// 设置消息发送者
vm.prank(address);        // 下一次调用
vm.startPrank(address);   // 开始持续
vm.stopPrank();           // 停止

// 设置区块属性
vm.warp(timestamp);       // 设置区块时间
vm.roll(blockNumber);     // 设置区块号

// 处理 ETH
vm.deal(address, amount); // 给地址设置 ETH 余额

// 预期行为
vm.expectRevert();        // 预期下次调用会回滚
vm.expectEmit(true, true, true, true);  // 预期事件发出
emit Transfer(from, to, amount);

// 示例
function testRevert() public {
    vm.expectRevert("Insufficient balance");
    counter.withdraw(1000 ether);
}
```

---

## 🛠 Cast 命令行工具

Cast 是与链交互的瑞士军刀：

### 查询链上数据

```bash
# 获取账户余额
cast balance 0xYourAddress

# 获取区块信息
cast block latest

# 获取交易信息
cast tx <TX_HASH>

# 调用合约只读函数
cast call <CONTRACT_ADDRESS> "balanceOf(address)(uint256)" 0xAddress

# 获取存储槽
cast storage <CONTRACT_ADDRESS> <SLOT>
```

### 发送交易

```bash
# 发送 ETH
cast send <TO_ADDRESS> \
  --value 1ether \
  --rpc-url <RPC_URL> \
  --private-key <PRIVATE_KEY>

# 调用合约函数
cast send <CONTRACT_ADDRESS> \
  "transfer(address,uint256)" \
  0xRecipient 100 \
  --rpc-url <RPC_URL> \
  --private-key <PRIVATE_KEY>
```

### 实用工具

```bash
# ABI 编码
cast abi-encode "transfer(address,uint256)" 0xAddress 100

# Keccak-256 哈希
cast keccak "Hello, World!"

# 地址转换
cast --to-checksum-address 0xaddress

# 单位转换
cast --to-wei 1 ether
cast --from-wei 1000000000000000000
```

---

## 🌐 部署脚本

使用 Solidity 编写部署脚本：

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);
        
        Counter counter = new Counter();
        counter.setNumber(42);
        
        vm.stopBroadcast();
    }
}
```

### 运行脚本

```bash
# 本地模拟（不广播）
forge script script/Counter.s.sol

# 部署到测试网
forge script script/Counter.s.sol \
  --rpc-url https://rpc.sepolia.org \
  --broadcast \
  --verify \
  -vvvv

# 使用环境变量
export PRIVATE_KEY=0x...
forge script script/Counter.s.sol \
  --rpc-url sepolia \
  --broadcast
```

---

## 🔧 配置文件

`foundry.toml` 配置示例：

```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
solc_version = "0.8.19"
optimizer = true
optimizer_runs = 200

# 测试配置
[profile.default.fuzz]
runs = 256

# RPC 端点
[rpc_endpoints]
mainnet = "${MAINNET_RPC_URL}"
sepolia = "${SEPOLIA_RPC_URL}"
localhost = "http://localhost:8545"

# Etherscan 配置
[etherscan]
mainnet = { key = "${ETHERSCAN_API_KEY}" }
sepolia = { key = "${ETHERSCAN_API_KEY}" }
```

---

## 💡 实用技巧

### 1. 使用 Forge Fmt 格式化代码

```bash
# 格式化所有 Solidity 文件
forge fmt

# 检查格式（不修改）
forge fmt --check
```

### 2. Gas 报告

```bash
# 生成 gas 报告
forge test --gas-report

# 保存到文件
forge test --gas-report > gas-report.txt
```

### 3. 覆盖率测试

```bash
# 生成覆盖率报告
forge coverage

# 生成 LCOV 格式
forge coverage --report lcov
```

### 4. Fork 测试

```bash
# Fork 主网进行测试
forge test --fork-url https://eth.merkle.io

# Fork 特定区块
forge test --fork-url <RPC_URL> --fork-block-number 18000000
```

### 5. 调试测试

```bash
# 使用调试器
forge test --debug testFunction

# 详细输出级别
forge test -vvvv  # 最详细
```

### 6. 依赖管理

```bash
# 安装依赖（从 GitHub）
forge install openzeppelin/openzeppelin-contracts

# 更新依赖
forge update

# 删除依赖
forge remove openzeppelin-contracts
```

---

## 📦 常用库

### OpenZeppelin Contracts

```bash
forge install OpenZeppelin/openzeppelin-contracts
```

```solidity
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }
}
```

### Solmate

```bash
forge install transmissions11/solmate
```

```solidity
import {ERC20} from "solmate/tokens/ERC20.sol";
```

---

## 🎓 学习资源

### 官方文档
- **Foundry Book**: https://book.getfoundry.sh
- **Forge 标准库**: https://github.com/foundry-rs/forge-std
- **示例项目**: https://github.com/foundry-rs/foundry/tree/master/examples

### 教程
- **Foundry 完整教程**: https://github.com/smartcontractkit/full-blockchain-solidity-course-js
- **Cyfrin Updraft**: https://updraft.cyfrin.io/

### 社区
- **GitHub Discussions**: https://github.com/foundry-rs/foundry/discussions
- **Telegram**: https://t.me/foundry_rs

---

## ❓ 常见问题

### Q1: Foundry 与 Hardhat 的区别？

| 特性 | Foundry | Hardhat |
|------|---------|---------|
| 语言 | Rust | JavaScript |
| 测试语言 | Solidity | JavaScript |
| 编译速度 | 极快 ⚡ | 较慢 |
| 测试速度 | 极快 | 较慢 |
| 学习曲线 | 中等 | 较低 |
| Solidity 原生 | ✅ | ❌ |

### Q2: 如何处理环境变量？

```bash
# 创建 .env 文件
echo "PRIVATE_KEY=0x..." > .env
echo "ETHERSCAN_API_KEY=..." >> .env

# 在脚本中使用
uint256 key = vm.envUint("PRIVATE_KEY");
```

### Q3: 如何测试时间相关的合约？

```solidity
function testTimeLock() public {
    vm.warp(block.timestamp + 1 days);
    // 测试解锁逻辑
}
```

### Q4: 如何模拟不同账户？

```solidity
function testDifferentSenders() public {
    vm.prank(alice);
    contract.deposit{value: 1 ether}();
    
    vm.prank(bob);
    contract.deposit{value: 2 ether}();
}
```

### Q5: 如何验证已部署的合约？

```bash
forge verify-contract \
  --chain-id 11155111 \
  --compiler-version v0.8.19+commit.7dd6d404 \
  <CONTRACT_ADDRESS> \
  src/MyContract.sol:MyContract \
  --etherscan-api-key <API_KEY>
```

---

## 🚀 最佳实践

### 1. 测试命名规范

```solidity
contract MyContractTest is Test {
    // 基础测试
    function test_BasicFunctionality() public {}
    
    // 失败场景
    function testFail_Unauthorized() public {}
    
    // 模糊测试
    function testFuzz_Amount(uint256 amount) public {}
    
    // 不变量测试
    function invariant_TotalSupply() public {}
}
```

### 2. 使用 setUp 初始化

```solidity
function setUp() public {
    // 在每个测试前执行
    token = new Token();
    vm.deal(alice, 100 ether);
}
```

### 3. 使用有意义的断言消息

```solidity
assertEq(balance, expected, "Balance mismatch after transfer");
```

### 4. 测试边界条件

```solidity
function testFuzz_Transfer(uint256 amount) public {
    vm.assume(amount <= token.balanceOf(alice));
    vm.assume(amount > 0);
    // 测试逻辑
}
```

### 5. 使用快照进行 Gas 优化

```solidity
function testOptimized() public {
    uint256 snapshot = vm.snapshot();
    // 执行操作
    vm.revertTo(snapshot);
    // 重置状态
}
```

---

## 🎉 总结

Foundry 的优势：
- ⚡ **极快** - Rust 实现，编译和测试速度极快
- 🔧 **强大** - Solidity 原生测试，Cheatcodes 功能丰富
- 📦 **简单** - 无需 JavaScript，纯 Solidity 开发
- 🎯 **精确** - Gas 报告、覆盖率测试、调试器

**推荐使用场景：**
- ✅ 新项目开发
- ✅ 需要快速测试迭代
- ✅ 重视 Gas 优化
- ✅ 喜欢 Solidity 原生测试

**开始使用 Foundry，体验极速开发！** 🚀✨
