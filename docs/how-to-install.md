# 安装说明

## 1. 复制全局 CLAUDE.md

```bash
cp CLAUDE.md ~/.claude/CLAUDE.md
```

如果你已经有自己的 `~/.claude/CLAUDE.md`，不要直接覆盖。建议把本项目内容合并进去，保留你自己的项目习惯和命令。

## 2. 安装 output style

```bash
mkdir -p ~/.claude/output-styles
cp output-styles/pm-chinese.md ~/.claude/output-styles/pm-chinese.md
```

## 3. 在 Claude Code 中启用

打开 Claude Code 后，选择 output style：

```text
PM Chinese
```

## 4. 验证效果

可以用下面这类问题测试：

```text
业务要在房源列表加一个“急售”标签，说能提升点击率。
请帮我准备需求评审时该问的问题和判断标准。
```

理想输出应该：

- 第一段先给判断
- 中文自然，不像翻译稿
- 能把点击率、供给真实性、用户信任和实验验证连起来
- 不会为了显得完整而写成论文
