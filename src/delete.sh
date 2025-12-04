#!/bin/bash
# 할일 삭제 기능

DATA_FILE="data/todos.txt"

# ID 확인
if [ -z "$1" ]; then
    echo "사용법: ./src/delete.sh [할일 ID]"
    exit 1
fi

DELETE_ID=$1

# 파일 존재 확인
if [ ! -f "$DATA_FILE" ]; then
    echo "할일 목록이 비어있습니다."
    exit 1
fi

# 해당 ID가 있는지 확인
if ! grep -q "^${DELETE_ID}|" "$DATA_FILE"; then
    echo "ID ${DELETE_ID}번 할일을 찾을 수 없습니다."
    exit 1
fi

# 해당 ID 삭제 (임시 파일 사용)
grep -v "^${DELETE_ID}|" "$DATA_FILE" > "${DATA_FILE}.tmp"
mv "${DATA_FILE}.tmp" "$DATA_FILE"

echo "할일 ${DELETE_ID}번이 삭제되었습니다."