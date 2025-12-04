#!/bin/bash
# To-Do List Manager - 메인 실행 파일

# 현재 스크립트 위치 기준으로 경로 설정
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DATA_FILE="$SCRIPT_DIR/data/todos.txt"

# 데이터 폴더/파일 초기화
init_data() {
    if [ ! -d "$SCRIPT_DIR/data" ]; then
        mkdir "$SCRIPT_DIR/data"
    fi
    if [ ! -f "$DATA_FILE" ]; then
        touch "$DATA_FILE"
    fi
}

# 도움말 출력
show_help() {
    echo "=== To-Do List Manager ==="
    echo "사용법: ./todo.sh [명령어] [인자]"
    echo ""
    echo "명령어:"
    echo "  add [내용]        - 할일 추가"
    echo "  delete [ID]       - 할일 삭제"
    echo "  list              - 전체 목록 보기"
    echo "  complete [ID]     - 할일 완료 처리"
    echo "  search [키워드]   - 할일 검색"
    echo "  filter [상태]     - 필터링 (completed/incomplete)"
    echo "  stats             - 통계 보기"
    echo "  help              - 도움말"
    echo ""
}

# 초기화
init_data

# 명령어 처리
case "$1" in
    add)
        shift
        bash "$SCRIPT_DIR/src/add.sh" "$*"
        ;;
    delete)
        bash "$SCRIPT_DIR/src/delete.sh" "$2"
        ;;
    list)
        bash "$SCRIPT_DIR/src/list.sh"
        ;;
    complete)
        bash "$SCRIPT_DIR/src/complete.sh" "$2"
        ;;
    search)
        bash "$SCRIPT_DIR/src/search.sh" "$2"
        ;;
    filter)
        bash "$SCRIPT_DIR/src/filter.sh" "$2"
        ;;
    stats)
        bash "$SCRIPT_DIR/src/stats.sh"
        ;;
    help|"")
        show_help
        ;;
    *)
        echo "알 수 없는 명령어: $1"
        echo "'./todo.sh help'로 사용법을 확인하세요."
        ;;
esac
