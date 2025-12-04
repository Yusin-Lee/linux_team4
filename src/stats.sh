#!/bin/bash
# 통계 기능

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DATA_FILE="$SCRIPT_DIR/data/todos.txt"

# 파일 존재 확인
if [ ! -f "$DATA_FILE" ] || [ ! -s "$DATA_FILE" ]; then
    echo "=== 통계 ==="
    echo "등록된 할일이 없습니다."
    exit 0
fi

echo "=== 통계 ==="

total_count=$(wc -l < "$DATA_FILE")
completed_count=$(grep -c -E "^[0-9]+\|1\|" "$DATA_FILE")
incomplete_count=$((total_count - completed_count))

# 퍼센트 계산
if [ "$total_count" -gt 0 ]; then
    completed_percent=$((completed_count * 100 / total_count))
    incomplete_percent=$((100 - completed_percent))
else
    completed_percent=0
    incomplete_percent=0
fi

echo "전체 할일: ${total_count}개"
echo "완료: ${completed_count}개 (${completed_percent}%)"
echo "미완료: ${incomplete_count}개 (${incomplete_percent}%)"