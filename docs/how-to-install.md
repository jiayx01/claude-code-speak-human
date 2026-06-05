# 安装说明

## 1. 复制全局 CLAUDE.md

```bash
cp CLAUDE.md ~/.claude/CLAUDE.md
```

如果你已经有自己的 `~/.claude/CLAUDE.md`，不要直接覆盖。建议把本项目内容合并进去，保留你自己的项目习惯和命令。

## 2. 安装 output style

```bash
mkdir -p ~/.claude/output-styles
cp output-styles/human-chinese.md ~/.claude/output-styles/human-chinese.md
```

## 3. 在 Claude Code 中启用

打开 Claude Code 后，选择 output style：

```text
Human Chinese
```

## 4. 验证效果

可以用下面这类问题测试：

```text
我需要把一个复杂问题讲给非技术同事听。
请帮我改成自然、清楚、容易理解的中文表达。
```

理想输出应该：

- 第一段先给判断
- 中文自然，不像翻译稿
- 逻辑顺序清楚，读者能知道为什么和下一步怎么做
- 不会为了显得完整而写成论文
