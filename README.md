# Claude Code Speak Human

让 Claude Code / Opus 用更自然、清晰、逻辑连贯的中文回答。

Opus 很强，会写代码、能理解上下文、也能做复杂任务。但在中文表达上，有时真的不像人话：

- 结论藏在后面
- 逻辑跳跃
- 英文翻译腔
- 喜欢堆抽象概念
- 明明有道理，但读起来很累

这个项目不是为了“训练模型”，也不是为了用一大堆提示词把 Claude 管死。它只做一件事：

> 用一份很短的 `CLAUDE.md` 和一个 Claude Code output style，让 Opus 的中文回答更像一个靠谱的人类合作者。

## 核心思路

Claude 已经足够聪明，不需要把所有行为都写进提示词。

更有效的做法是分工：

- `CLAUDE.md`：只放你的身份、长期偏好和高层工作方式。
- `output style`：专门纠正中文表达、逻辑连贯和可读性。

也就是说，不要用超长 `CLAUDE.md` 管住模型，而是用短配置做表达校准。

## 快速安装

```bash
mkdir -p ~/.claude/output-styles

cp CLAUDE.md ~/.claude/CLAUDE.md
cp output-styles/pm-chinese.md ~/.claude/output-styles/pm-chinese.md
```

然后在 Claude Code 中选择 `PM Chinese` output style。

## 文件说明

```text
.
├── CLAUDE.md
├── output-styles/
│   └── pm-chinese.md
├── examples/
│   ├── before-after.md
│   └── data-product-manager.md
├── evaluation/
│   ├── eval_tasks.jsonl
│   ├── pilot_scores.csv
│   └── rubric.md
├── scripts/
│   └── run_pilot.sh
└── docs/
    ├── experiment-design.md
    ├── how-to-install.md
    └── why-output-style.md
```

## 适合谁

- 中文 Claude Code 用户
- 产品经理、数据产品经理、数据分析师
- 经常让 Claude 写方案、总结、分析、代码解释的人
- 觉得 Opus 能力很强，但中文表达“不够像人话”的人

## 不适合什么

- 这不是 jailbreak。
- 这不是模型训练。
- 这不是万能提示词。
- 这不会保证所有场景都最优。

你应该把它当成一个可复制的起点，然后根据自己的表达偏好微调。

## 实验结论

我做了一轮小型 pilot，对比了：

- Opus 4.6 原始输出
- Opus 4.8 原始输出
- Opus 4.8 + `CLAUDE.md`
- Opus 4.8 + `CLAUDE.md` + `PM Chinese`

结果显示，`Opus 4.8 + CLAUDE.md + output style` 在中文自然度、结论清晰度、产品经理可读性上表现最好。

详细实验设计见 [docs/experiment-design.md](docs/experiment-design.md)。

## 关键观点

- Claude 已经足够聪明，别把它管死。
- 中文表达问题，不应该靠一大堆行为约束解决。
- `CLAUDE.md` 越长，越容易让模型变成“按模板答题”。
- Output style 更适合解决“说人话”的问题。
- 好的提示词不是让模型更听话，而是让它更像一个清醒的人类合作者。

## License

MIT
