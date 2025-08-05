#!/bin/bash
set -x
# export KUBECONFIG=~/.kube/kvcache-container.conf

# export DEPLOYMENT_NAME=llm-disagg
# export NAMESPACE=dynamo
# kubectl port-forward svc/$DEPLOYMENT_NAME-frontend 8000:8000 -n ${NAMESPACE}

TOKENIZER=$4 #"/data01/models/Qwen3-32B" #"/root/models/DeepSeek-R1-Distill-Llama-8B"
MODEL=$3 #"/models/Qwen3-32B" #"qwen3-8B" #"deepseek-ai/DeepSeek-R1-Distill-Llama-8B"
HOST=$1 #"192.168.0.6" #"127.0.0.1"
PORT=$2 #30000 #8000
OUTPUT=$5 
#DATASET="/root/aibrix-benchmark/benchmarks/output/dataset/synthetic_shared.jsonl"
DATASET="/root/aibrix-benchmark/benchmarks/synthetic_multiturn_converted.jsonl"
#python3 benchmark_serving.py --port $PORT --host $HOST  --seed $(date +%s) \
#      --model $MODEL \
#      --tokenizer $TOKENIZER \
#      --dataset-name custom --dataset-path $DATASET \
#      --custom-skip-chat-template \
#      --num-prompts 200 --burstiness 100 --request-rate 1 --metric-percentiles 95 \
#      --backend openai-chat --endpoint /v1/chat/completions --ignore-eos | tee $5


python3 benchmark_serving.py --port $PORT --host $HOST  --seed $(date +%s) \
      --model $MODEL \
      --tokenizer $TOKENIZER \
      --dataset-name custom --dataset-path $DATASET \
      --custom-skip-chat-template \
      --num-prompts 200 --burstiness 100 --request-rate 1 --metric-percentiles 95 \
      --backend openai-chat --endpoint /v1/chat/completions --routing-strategy "pd" --ignore-eos | tee $5



