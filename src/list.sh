#!/bin/bash
# 할일 목록 조회 기능

DATA_FILE="data/todos.txt"

# 파일 존재 확인
if [ ! -f "$DATA_FILE" ] || [ ! -s "$DATA_FILE" ]; then
    echo "=== 할일 목록 ==="
    echo "등록된 할일이 없습니다."
    exit 0
fi

echo "=== 할일 목록 ==="

# 완료/미완료 카운트
TOTAL=0
DONE=0

while IFS='|' read -r id status content; do
    TOTAL=$((TOTAL + 1))
    if [ "$status" -eq 1 ]; then
        echo "${id}. [X] ${content}"
        DONE=$((DONE + 1))
    else
        echo "${id}. [ ] ${content}"
    fi
done < "$DATA_FILE"

NOT_DONE=$((TOTAL - DONE))
echo ""
echo "총 ${TOTAL}개의 할일 (완료: ${DONE}, 미완료: ${NOT_DONE})"