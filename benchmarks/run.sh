#!/bin/bash
# export KUBECONFIG=~/.kube/kvcache-container.conf

# export DEPLOYMENT_NAME=llm-disagg
# export NAMESPACE=dynamo
# kubectl port-forward svc/$DEPLOYMENT_NAME-frontend 8000:8000 -n ${NAMESPACE}

TOKENIZER=$4 #"/data01/models/Qwen3-32B" #"/root/models/DeepSeek-R1-Distill-Llama-8B"
MODEL=$3 #"/models/Qwen3-32B" #"qwen3-8B" #"deepseek-ai/DeepSeek-R1-Distill-Llama-8B"
HOST=$1 #"192.168.0.6" #"127.0.0.1"
PORT=$2 #30000 #8000
OUTPUT=$5 
python3 benchmark_serving.py --port $PORT --host $HOST  --seed $(date +%s) \
      --model $MODEL \
      --tokenizer $TOKENIZER \
      --dataset-name random --random-input-len 8000 --random-output-len 200 \
      --num-prompts 200 --burstiness 100 --request-rate 1.5 --metric-percentiles 95 \
      --backend openai-chat --endpoint /v1/chat/completions --ignore-eos | tee $5


# Policy
#python3 benchmark_serving.py --port $PORT --host $HOST  --seed $(date +%s) \
#      --model $MODEL \
#      --tokenizer $TOKENIZER \
#      --dataset-name random --random-input-len 8000 --random-output-len 200 \
#      --num-prompts 200 --burstiness 100 --request-rate 1 --metric-percentiles 95 \
#      --backend openai-chat --endpoint /v1/chat/completions --routing-strategy "pd" --ignore-eos | tee $5



#python3 benchmark_serving.py --port $PORT --host $HOST  --seed $(date +%s) \
#      --model $MODEL \
#      --tokenizer $TOKENIZER \
#      --dataset-name random --random-input-len 8000 --random-output-len 200 \
#      --num-prompts 10 --burstiness 100 --request-rate 3.6 --metric-percentiles 95 \
#      --backend openai-chat --endpoint /v1/chat/completions --routing-strategy "pd" --ignore-eos | tee $5

# export DEPLOYMENT_NAME=disagg-router
# export NAMESPACE=dynamo
# # Forward the pod's port to localhost
# # kubectl port-forward svc/$DEPLOYMENT_NAME-frontend 8000:8000 -n ${NAMESPACE}

# # curl localhost:8000/v1/chat/completions -H "Content-Type: application/json" -d '{"model": "deepseek-ai/DeepSeek-R1-Distill-Llama-8B", "messages": [{"role": "user", "content": "Where is Beijing."}], "stream": false, "max_tokens": 50}'

# python3 benchmark_serving.py --port 8000 --seed $(date +%s) \
#       --model "deepseek-ai/DeepSeek-R1-Distill-Llama-8B" \
#       --tokenizer "/mnt/models/DeepSeek-R1-Distill-Llama-8B" \
#       --dataset-name random --random-input-len 8000 --random-output-len 200 \
#       --num-prompts 200 --burstiness 100 --request-rate 3.6 --metric-percentiles 95 \
#       --backend openai-chat --endpoint /v1/chat/completions --ignore-eos | tee benchmark-2p1d.log


