#!/bin/bash
# 할일 추가 기능

DATA_FILE="data/todos.txt"

# 데이터 파일이 없으면 생성
if [ ! -f "$DATA_FILE" ]; then
    touch "$DATA_FILE"
fi

# 할일 내용 확인
if [ -z "$1" ]; then
    echo "사용법: ./src/add.sh [할일 내용]"
    exit 1
fi

# 마지막 ID 찾기 (파일이 비어있으면 0)
if [ -s "$DATA_FILE" ]; then
    LAST_ID=$(tail -1 "$DATA_FILE" | cut -d'|' -f1)
else
    LAST_ID=0
fi

# 새 ID 생성
NEW_ID=$((LAST_ID + 1))

# 할일 추가 (형식: ID|완료여부|내용)
echo "${NEW_ID}|0|$*" >> "$DATA_FILE"

echo "할일이 추가되었습니다. (ID: ${NEW_ID})"