#!/bin/bash

docker run \
-v $PWD:/stallabella \
-e OPENAI_API_KEY=$OPENAI_API_KEY \
-w /stallabella \
--rm --entrypoint=/bin/bash -it ozanzal/cllm -c "./story.sh"