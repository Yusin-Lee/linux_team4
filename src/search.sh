#!/bin/bash
# 검색 기능

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DATA_FILE="$SCRIPT_DIR/data/todos.txt"

# 키워드 확인
if [ -z "$1" ]; then
    echo "사용법: ./todo.sh search [키워드]"
    exit 1
fi

keyword="$1"

# 파일 존재 확인
if [ ! -f "$DATA_FILE" ] || [ ! -s "$DATA_FILE" ]; then
    echo "할일 목록이 비어있습니다."
    exit 0
fi

echo "=== 검색 결과 (키워드: '$keyword') ==="

results=$(grep -i "$keyword" "$DATA_FILE")

if [ -z "$results" ]; then
    echo "검색 결과가 없습니다."
else
    echo "$results" | while IFS='|' read -r id status content; do
        if [ "$status" -eq 1 ]; then
            echo "${id}. [X] ${content}"
        else
            echo "${id}. [ ] ${content}"
        fi
    done
fi
