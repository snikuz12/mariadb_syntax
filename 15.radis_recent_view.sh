while true; do 



    read product
    if[ "$product"== 'exit']; then
        echo "나갑니다."
        break
    fi
    timestamp = $(date +%s)
    redis-cli zadd recent:products $timestamp $product
done
echo "사용자의 최근 본 상품목록 5개 : "
redis-cli zrevrange recent:products 0 4