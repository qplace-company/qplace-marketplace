#!/bin/bash
# PostToolUse hook for Task: Task 완료 후 출력 크기 검증 및 요약 추출
set -euo pipefail

# 입력 읽기
input=$(cat)

# Task 결과 추출
task_result=$(echo "$input" | jq -r '.tool_result // ""' 2>/dev/null || echo "")

# 출력 길이 계산
result_length=${#task_result}

# 임계값 설정
MAX_LENGTH=5000
CRITICAL_LENGTH=10000

# <task_result> 태그 존재 여부 확인
has_task_result_tag=$(echo "$task_result" | grep -c "<task_result>" || echo "0")

# <summary> 태그 추출 시도
summary=$(echo "$task_result" | grep -oP '(?<=<summary>).*?(?=</summary>)' | head -1 || echo "")

if [[ $result_length -gt $CRITICAL_LENGTH ]]; then
  # 심각하게 긴 출력 - 강력한 경고
  if [[ -n "$summary" ]]; then
    echo "{
      \"systemMessage\": \"🚨 CRITICAL: Task 출력이 ${result_length}자로 매우 깁니다!\\n\\n추출된 요약: ${summary}\\n\\n전체 출력 대신 이 요약만 사용하세요.\",
      \"suppressOutput\": false
    }"
  else
    preview=$(echo "$task_result" | head -c 300)
    echo "{
      \"systemMessage\": \"🚨 CRITICAL: Task 출력이 ${result_length}자로 매우 깁니다! <task_result> 태그를 찾을 수 없습니다.\\n\\n미리보기: ${preview}...\\n\\n에이전트에게 요약된 출력을 요청하세요.\",
      \"suppressOutput\": false
    }"
  fi
elif [[ $result_length -gt $MAX_LENGTH ]]; then
  # 긴 출력 - 경고
  echo "{
    \"systemMessage\": \"⚠️ Task 출력이 ${result_length}자입니다. 가능하면 <summary> 태그 내용만 사용하세요.\",
    \"suppressOutput\": false
  }"
elif [[ $has_task_result_tag -eq 0 && $result_length -gt 1000 ]]; then
  # <task_result> 태그 없이 긴 출력
  echo "{
    \"systemMessage\": \"⚠️ Task 출력에 <task_result> 태그가 없습니다. 구조화된 출력 형식을 사용하세요.\",
    \"suppressOutput\": false
  }"
else
  # 정상 출력 - 조용히 통과
  echo "{}"
fi

exit 0
