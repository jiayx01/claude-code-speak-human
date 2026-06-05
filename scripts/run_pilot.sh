#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_BIN="${CLAUDE_BIN:-claude}"
MODEL_46="${MODEL_46:-claude-opus-4-6}"
MODEL_48="${MODEL_48:-claude-opus-4-8}"
MAX_TASKS="${MAX_TASKS:-8}"
MAX_BUDGET_USD="${MAX_BUDGET_USD:-1.20}"
EFFORT="${EFFORT:-low}"
TIMEOUT_SEC="${TIMEOUT_SEC:-120}"
TASK_FILE="${TASK_FILE:-$ROOT/evaluation/eval_tasks.jsonl}"
WORD_LIMIT="${WORD_LIMIT:-350}"

CLAUDE_MD="$(cat "$ROOT/CLAUDE.md")"
OUTPUT_STYLE="$(cat "$ROOT/output-styles/pm-chinese.md")"

mkdir -p \
  "$ROOT/outputs/opus46" \
  "$ROOT/outputs/opus48_baseline" \
  "$ROOT/outputs/opus48_claude_md" \
  "$ROOT/outputs/opus48_full"

run_one() {
  local model="$1"
  local system_prompt="$2"
  local prompt="$3"
  local out="$4"
  local json_out="${out%.md}.json"
  local err_out="${out%.md}.err"

  if [[ -n "$system_prompt" ]]; then
    perl -e 'alarm shift; exec @ARGV' "$TIMEOUT_SEC" "$CLAUDE_BIN" -p \
      --model "$model" \
      --tools "" \
      --no-session-persistence \
      --effort "$EFFORT" \
      --max-budget-usd "$MAX_BUDGET_USD" \
      --output-format json \
      --append-system-prompt "$system_prompt" \
      "$prompt" > "$json_out" 2> "$err_out" || {
        echo "TIMEOUT_OR_ERROR: $model" > "$out"
        return 0
      }
  else
    perl -e 'alarm shift; exec @ARGV' "$TIMEOUT_SEC" "$CLAUDE_BIN" -p \
      --model "$model" \
      --tools "" \
      --no-session-persistence \
      --effort "$EFFORT" \
      --max-budget-usd "$MAX_BUDGET_USD" \
      --output-format json \
      "$prompt" > "$json_out" 2> "$err_out" || {
        echo "TIMEOUT_OR_ERROR: $model" > "$out"
        return 0
      }
  fi
  node -e 'const fs=require("fs"); const x=JSON.parse(fs.readFileSync(process.argv[1],"utf8")); process.stdout.write(x.result || "")' "$json_out" > "$out"
}

count=0
while IFS= read -r line; do
  count=$((count + 1))
  [[ "$count" -le "$MAX_TASKS" ]] || break

  id="$(node -e 'const x=JSON.parse(process.argv[1]); process.stdout.write(x.id)' "$line")"
  task_prompt="$(node -e 'const x=JSON.parse(process.argv[1]); process.stdout.write(x.prompt)' "$line")"
  prompt=$'请回答下面这个数据产品经理任务。\n\n实验约束：\n- 中文回答，'"$WORD_LIMIT"$' 字以内。\n- 开头先给核心判断。\n- 最多 5 个要点，避免大段铺陈。\n- 不展示完整隐藏推理链，只输出可读的判断依据、建议和风险。\n- 不要写成教科书，不要堆空泛原则。\n\n任务：'"$task_prompt"

  echo "Running $id ..."
  run_one "$MODEL_46" "" "$prompt" "$ROOT/outputs/opus46/$id.md"
  run_one "$MODEL_48" "" "$prompt" "$ROOT/outputs/opus48_baseline/$id.md"
  run_one "$MODEL_48" "$CLAUDE_MD" "$prompt" "$ROOT/outputs/opus48_claude_md/$id.md"
  run_one "$MODEL_48" "$CLAUDE_MD"$'\n\n'"$OUTPUT_STYLE" "$prompt" "$ROOT/outputs/opus48_full/$id.md"
done < "$TASK_FILE"

echo "Pilot complete: $count tasks attempted."
