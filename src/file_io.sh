#!/bin/bash
# Feature 3: 파일 저장/불러오기 기능

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DATA_FILE="$SCRIPT_DIR/data/todos.txt"

# 데이터 로드 함수 (프로그램 시작 시 호출)
load_data() {
    echo "--- 데이터 로드 ---"

    # data 폴더가 없으면 생성
    if [ ! -d "$SCRIPT_DIR/data" ]; then
        mkdir "$SCRIPT_DIR/data"
    fi

    # 데이터 파일이 없으면 생성
    if [ ! -f "$DATA_FILE" ]; then
        touch "$DATA_FILE"
        echo "데이터 파일이 새로 생성되었습니다."
    else
        echo "이전 데이터를 로드했습니다."
        
        # 로드된 내용 미리보기
        if [ -s "$DATA_FILE" ]; then
            echo "--- 저장된 할일 목록 ---"
            while IFS='|' read -r id status content; do
                if [ "$status" -eq 1 ]; then
                    echo "${id}. [X] ${content}"
                else
                    echo "${id}. [ ] ${content}"
                fi
            done < "$DATA_FILE"
            echo "------------------------"
        fi
    fi
}

# 다음 ID 가져오기 함수
get_next_id() {
    if [ ! -s "$DATA_FILE" ]; then
        echo 1
    else
        local last_id=$(tail -1 "$DATA_FILE" | cut -d'|' -f1)
        echo $((last_id + 1))
    fi
}

# 할일 추가 함수 (파일에 append)
append_to_file() {
    local id="$1"
    local status="$2"
    local content="$3"
    echo "${id}|${status}|${content}" >> "$DATA_FILE"
}

# 상태 업데이트 함수
update_file_status() {
    local id_to_update="$1"
    local new_status="$2"
    sed -i "s/^${id_to_update}|[0-1]|/${id_to_update}|${new_status}|/" "$DATA_FILE"
}

# 데이터 저장 함수 (프로그램 종료 시)
save_data() {
    echo "데이터가 저장되었습니다."
}

# 스크립트가 직접 실행될 때 (테스트용)
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    case "$1" in
        load)
            load_data
            ;;
        save)
            save_data
            ;;
        *)
            echo "사용법: ./file_io.sh [load|save]"
            ;;
    esac
fi