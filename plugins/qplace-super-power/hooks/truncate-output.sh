#!/bin/bash
# SubagentStop hook: 서브에이전트 출력을 검증하고 필요시 요약 제안
set -euo pipefail

# 입력 읽기
input=$(cat)

# 출력 추출 (tool_result 또는 output 필드)
output=$(echo "$input" | jq -r '.tool_result // .output // ""' 2>/dev/null || echo "")

# 출력 길이 계산
output_length=${#output}

# 임계값 설정 (3000자)
MAX_LENGTH=3000

if [[ $output_length -gt $MAX_LENGTH ]]; then
  # 출력이 너무 긴 경우 경고 메시지 추가
  truncated_preview=$(echo "$output" | head -c 500)

  echo "{
    \"decision\": \"approve\",
    \"reason\": \"출력이 ${output_length}자로 제한(${MAX_LENGTH}자)을 초과했습니다. 요약이 필요합니다.\",
    \"systemMessage\": \"⚠️ 서브에이전트 출력이 너무 깁니다 (${output_length}자). <task_result> 태그 내 요약만 사용하세요.\\n\\n미리보기:\\n${truncated_preview}...\"
  }"
else
  # 정상 출력
  echo "{
    \"decision\": \"approve\",
    \"reason\": \"출력 크기 정상 (${output_length}자)\"
  }"
fi

exit 0
