#!/bin/bash
# 할일 완료 표시 기능

DATA_FILE="data/todos.txt"

# ID 확인
if [ -z "$1" ]; then
    echo "사용법: ./src/complete.sh [할일 ID]"
    exit 1
fi

COMPLETE_ID=$1

# 파일 존재 확인
if [ ! -f "$DATA_FILE" ]; then
    echo "할일 목록이 비어있습니다."
    exit 1
fi

# 해당 ID가 있는지 확인
if ! grep -q "^${COMPLETE_ID}|" "$DATA_FILE"; then
    echo "ID ${COMPLETE_ID}번 할일을 찾을 수 없습니다."
    exit 1
fi

# 완료 상태로 변경 (0 → 1)
sed -i "s/^${COMPLETE_ID}|0|/${COMPLETE_ID}|1|/" "$DATA_FILE"

echo "할일 ${COMPLETE_ID}번이 완료 처리되었습니다."