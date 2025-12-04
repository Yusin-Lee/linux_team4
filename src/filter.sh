#!/bin/bash
# 필터링 기능

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DATA_FILE="$SCRIPT_DIR/data/todos.txt"

# 필터 타입 확인
if [ -z "$1" ]; then
    echo "사용법: ./todo.sh filter [completed|incomplete]"
    exit 1
fi

filter_type="$1"

# 파일 존재 확인
if [ ! -f "$DATA_FILE" ] || [ ! -s "$DATA_FILE" ]; then
    echo "할일 목록이 비어있습니다."
    exit 0
fi

case "$filter_type" in
    completed)
        echo "=== 완료된 할일 ==="
        status_code="1"
        ;;
    incomplete)
        echo "=== 미완료 할일 ==="
        status_code="0"
        ;;
    *)
        echo "오류: 'completed' 또는 'incomplete'를 입력해주세요."
        exit 1
        ;;
esac

results=$(grep -E "^[0-9]+\|${status_code}\|" "$DATA_FILE")

if [ -z "$results" ]; then
    echo "결과가 없습니다."
else
    echo "$results" | while IFS='|' read -r id status content; do
        if [ "$status" -eq 1 ]; then
            echo "${id}. [X] ${content}"
        else
            echo "${id}. [ ] ${content}"
        fi
    done
fi
