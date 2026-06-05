# Evaluation

这里放了一组可复用的中文表达评测材料。

## 文件

- `eval_tasks.jsonl`：30 条中文工作场景任务，当前偏产品和数据场景，可替换为你的真实任务。
- `rubric.md`：10 个评分维度。
- `pilot_scores.csv`：本项目第一轮 pilot 的人工评分结果。

## 如何运行

```bash
./scripts/run_pilot.sh
```

默认模型名：

```bash
MODEL_46=claude-opus-4-6
MODEL_48=claude-opus-4-8
```

如果你的 Claude CLI 模型名不同，可以这样替换：

```bash
MODEL_46=your-reference-model MODEL_48=your-target-model ./scripts/run_pilot.sh
```

输出会写到 `outputs/`，默认不会被 Git 跟踪。
